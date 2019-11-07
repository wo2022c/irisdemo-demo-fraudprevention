Include DEMOMACROS

Class IRISDemo.DataLoadingUtils
{

	/// This is called from IRISDemo.Installer to create the user merchants, 
	/// customer accounts, transactions between them and fraud complaints
	ClassMethod LoadFullDataFromCSVFile(pFileName As %String) As %Status
	{
		#Dim oTrans As IRISDemo.Trans
		
		Set tSC = $$$OK
		Try
		{
			//Disable journaling to speed data bulk load
			DO DISABLE^%NOJRN
			
			Set iLine=0 //Header is consumed
			
			Set oRSTransactions=##class(%ResultSet).%New("IRISDemo.Util.FileReader:CSV")
			Set tSC = oRSTransactions.Execute(pFileName)
			Quit:$System.Status.IsError(tSC)
						
			Do ..ClearErrors()
			
			Set tBaseDate=$ZDateH("2018-01-01",3)
			
			While oRSTransactions.Next()
			{
				Set iLine=iLine+1
				//Quit:iLine>10000
				
				// I should use SQL instead of objects here since SQL will allow me 
				// to insert with flags such as %NOINDEX and build the indices later
				Set oTrans = ##class(CheckingTrans).%New()
				Set oTrans.TransactionNumber=iLine
				
				// step must be transformed into TransDateTime. One step is 1 hour
				Set day=oRSTransactions.Get("step")
				Set dateH=tBaseDate+day
				Set hourH=$ZTime($Random(60*60*24))
				Set oTrans.TransDateTime=$ZDate(dateH,3)_" "_$ZTime(hourH)
				
				Set oTrans.Amount=+oRSTransactions.Get("amount")
				Set oTrans.IsFraud=+oRSTransactions.Get("fraud")
				
				Set tSC = ##class(Account).OpenOrCreateByNumber(oRSTransactions.Get("merchant"), .oToAccount)
				Quit:$System.Status.IsError(tSC)
				
				Set oTrans.ToAccount=oToAccount
				If oTrans.ToAccount.%Id()=""
				{
					Set tCategoryDesc=$ZConvert($Piece(oRSTransactions.Get("category"),"_",2), "S")
					Set tSC=##class(MerchantCategory).OpenOrCreateByDesc(tCategoryDesc, .oCategory)
					$$$ThrowStatusExceptionIfError(tSC, "CreateCategoryException")
					
					Set oTrans.ToAccount.Category=oCategory
				}
				
				Set tSC = ##class(Account).OpenOrCreateByNumber(oRSTransactions.Get("customer"), .oFromAccount)
				Quit:$System.Status.IsError(tSC)
				
				Set oTrans.FromAccount=oFromAccount
				If oTrans.FromAccount.%Id()=""
				{
					Set oTrans.FromAccount.Gender=$Case(oRSTransactions.Get("gender"),"M":1, "F":2, :3)
					Set oTrans.FromAccount.DateOfBirth=..DateOfBirthForAgeGroup(oRSTransactions.Get("age"))
				}
				
				Set oTrans.TransType="PAYMENT"
				
				Set oTrans.FromAccountOldBalance=oTrans.FromAccount.Balance
				Set oTrans.ToAccountOldBalance=oTrans.ToAccount.Balance
				
				Set oTrans.ToAccount.Balance=oTrans.ToAccount.Balance+oTrans.Amount
				Set oTrans.FromAccount.Balance=oTrans.FromAccount.Balance-oTrans.Amount
				
				Set oTrans.FromAccountNewBalance=oTrans.FromAccount.Balance
				Set oTrans.ToAccountNewBalance=oTrans.ToAccount.Balance
				
				Set tSC = oTrans.%Save(1)
				Quit:$System.Status.IsError(tSC)
				
				Set tSC = ..CreateFraudComplaint(oTrans)
				Quit:$System.Status.IsError(tSC)
			}
			Quit:$System.Status.IsError(tSC)
			
			Do $System.SQL.TuneSchema("IRISDemo",1,0,,1,1)
			
			Set tSC = ..PopulateWhiteList()
			Quit:$System.Status.IsError(tSC)
			
			Set tSC = ..ExportWhiteList()
			Quit:$System.Status.IsError(tSC)
			
			Set tSC = ..LabelEncode()
			
		}
		Catch (oException)
		{
			Set tSC = oException.AsStatus()
		}
		
		DO ENABLE^%NOJRN
		
		Set ^IRISDemo.TransL("Total")=iLine
		Do ..ShowResults(tSC)
		
		Quit tSC
	}

	ClassMethod CreateFraudComplaint(pTransaction As IRISDemo.CheckingTrans) As %Status
	{
		#Dim oFraudComplaint As IRISDemo.FraudComplaint
		
		Set tSC = $$$OK
		Try
		{
			Set oFraudComplaint=##class(IRISDemo.FraudComplaint).%New()
			Set oFraudComplaint.ComplaintDate=$ZDateTimeH(pTransaction.TransDateTime,3)+$Random(10)
			Set oFraudComplaint.Confirmed=pTransaction.IsFraud
			Set oFraudComplaint.CustomerAccount=pTransaction.FromAccount
			Set oFraudComplaint.Transaction=pTransaction
			
			// If it is fraud, I want to file a Confirmed complaint.
			// If it is NOT fraud, I want to file 1 out of 1000 non confirmed complaints 
			// just to have some unconfirmed complaints on the database (frauds made by the customer him/her-self)
			If pTransaction.IsFraud || ('$Random(1000))
			{
				Set tSC = oFraudComplaint.%Save()
				Quit:$System.Status.IsError(tSC)
			}
			
		}
		Catch (oException)
		{
			Set tSC = oException.AsStatus()
		}
				
		Quit tSC
	}

	/// This will encode some of the code tables we have, such as Merchant Categories,
	/// in the same way python sklearn.preprocessing.LabelEncoder would do. I am doing this
	/// because Nitor (the partner) built a ML model for us and used this method to encode the
	/// values of their string features. When we migrat this to Spark, we may end up using this 
	ClassMethod LabelEncode() As %Status
	{
		Set tSC = $$$OK
		Try
		{
			Set oRS = ##class(%ResultSet).%New()
			Set tSC = oRS.Prepare("select ID from IRISDemo.BC_MERCH_CATEGORY order by BC_MERCH_CAT_DESC")
			Quit:$System.Status.IsError(tSC)
			
			Set tSC = oRS.Execute()
			Quit:$System.Status.IsError(tSC)
			
			For iCode=0:1
			{
				Quit:'oRS.Next()
				
				Set oMerchantCat = ##class(IRISDemo.MerchantCategory).%OpenId(oRS.GetData(1))
				Set oMerchantCat.Code=iCode
				Set tSC = oMerchantCat.%Save()
				Quit:$System.Status.IsError(tSC)
			}
			Quit:$System.Status.IsError(tSC)
			
			Set oRS = ##class(%ResultSet).%New()
			Set tSC = oRS.Prepare("select ID from IRISDemo.BC_MERCH_ACCOUNT order by BC_ACC_NUMBER")
			Quit:$System.Status.IsError(tSC)
			
			Set tSC = oRS.Execute()
			Quit:$System.Status.IsError(tSC)
			
			For iCode=0:1
			{
				Quit:'oRS.Next()
				
				Set oMerchant = ##class(IRISDemo.MerchantAccount).%OpenId(oRS.GetData(1))
				Set oMerchant.Code=iCode
				Set tSC = oMerchant.%Save()
				Quit:$System.Status.IsError(tSC)
			}
			Quit:$System.Status.IsError(tSC)
		}
		Catch (oException)
		{
			Set tSC = oException.AsStatus()
		}
				
		Quit tSC
	}
	
	ClassMethod PopulateWhiteList() As %Status
	{
		#Dim oFraudComplaint As IRISDemo.FraudComplaint
		
		Set tSC = $$$OK
		Try
		{
			
			// Give me the standard deviation and average of transacted amounts of all transactions that doesn't have a confirmed fraud complaint
			Set oRS = ##class(%ResultSet).%New()
			Set tSC = oRS.Prepare("select t.BC_TRANS_SRC_ACC, AVG(t.BC_TRANS_AMOUNT) AMOUNT_AVG, STDDEV(t.BC_TRANS_AMOUNT) AMOUNT_STDDEV "_
								  "from IRISDemo.BC_TRANSACTIONS t, "_
								  "	 IRISDemo.CS_FRAUD_COMPLAINT c "_

								  "where t.ID*=c.CS_FRAUD_COMP_TRANSACTION AND "_
								  "      t.BC_TRANS_TYPE='PAYMENT' AND"_
								  "	  (c.CS_FRAUD_COMP_CONFIRMED is null OR c.CS_FRAUD_COMP_CONFIRMED<>1)"_

								  "group by t.BC_TRANS_SRC_ACC "_
								  "having STDDEV(t.BC_TRANS_AMOUNT)>0")
			
			Quit:$System.Status.IsError(tSC)
			
			Set tSC = oRS.Execute()
			Quit:$System.Status.IsError(tSC)
			
			Set oRSFind = ##class(%ResultSet).%New()
			Set tSC = oRSFind.Prepare("select t.ID "_
									  "from IRISDemo.BC_TRANSACTIONS t "_
									  "where t.BC_TRANS_SRC_ACC =? and "_
									  "((t.BC_TRANS_AMOUNT - ?)/?) > 7 ")
			Quit:$System.Status.IsError(tSC)
			
			While oRS.Next()
			{
				Write !,"Source account: ",oRS.GetData(1)
				Write !,"AVG amount    : ",oRS.GetData(2)
				Write !,"STDDEV amount : ",oRS.GetData(3)
				
				Set tSC = oRSFind.Execute(oRS.GetData(1), oRS.GetData(2), oRS.GetData(3))
				Quit:$System.Status.IsError(tSC)
				
				While oRSFind.Next()
				{
					Write !,"Transaction found: ",oRSFind.GetData(1)
					
					Set tSC = ..CreateWhiteListForTrans(oRSFind.GetData(1))
					Quit:$System.Status.IsError(tSC)
				}
				Quit:$System.Status.IsError(tSC)
			}
			Quit:$System.Status.IsError(tSC)
		}
		Catch (oException)
		{
			Set tSC = oException.AsStatus()
		}
				
		Quit tSC
	}

	ClassMethod ExportWhiteList() As %Status
	{
		#Dim oFile As %File
		
		Set tSC = $$$OK
		Try
		{
			Set oRS = ##class(%ResultSet).%New()
			Set tSC = oRS.Prepare("select *, BS_WL_ACCOUNT->BC_ACC_NUMBER as BC_ACC_NUMBER from IRISDemo.BS_WHITE_LIST_REQ")
			Quit:$System.Status.IsError(tSC)
			
			Set tSC = oRS.Execute()
			Quit:$System.Status.IsError(tSC)
			
			Set oFile=##class(%File).%New("/tmp/whitelist.csv")
			Set tSC = oFile.Open("WNS")
			Quit:$System.Status.IsError(tSC)
			
			Set tSC = oFile.WriteLine("BS_WL_REQ_ID;BS_WL_REQ_DATE;BC_ACC_NUMBER;BS_WL_VALID_FROM;BS_WL_VALID_TO")
			Quit:$System.Status.IsError(tSC)
			
			While oRS.Next()
			{
				Set tC1=oRS.Get("BS_WL_REQ_ID")
				Set tC2=oRS.Get("BS_WL_REQ_DATE")
				Set tC3=oRS.Get("BC_ACC_NUMBER")
				Set tC4=oRS.Get("BS_WL_VALID_FROM")
				Set tC5=oRS.Get("BS_WL_VALID_TO")
				
				Set tSC = oFile.WriteLine(tC1_";"_tC2_";"_tC3_";"_tC4_";"_tC5)
				Quit:$System.Status.IsError(tSC)
			}
			
			Do oFile.Close()
		}
		Catch (oException)
		{
			Set tSC = oException.AsStatus()
		}
				
		Quit tSC
	}

	ClassMethod CreateWhiteListForTrans(pTransId As %String) As %Status
	{
		#Dim oWhiteList As IRISDemo.WhiteListRequest
		
		Set tSC = $$$OK
		Try
		{
			Set oTrans = ##class(IRISDemo.CheckingTrans).%OpenId(pTransId)
			
			Set oRS = ##class(%ResultSet).%New()
			Set tSC = oRS.Prepare("select ID from IRISDemo.BS_WHITE_LIST_REQ where BS_WL_ACCOUNT=? and BS_WL_VALID_FROM >= ? and BS_WL_VALID_TO <= ?")
			Quit:$System.Status.IsError(tSC)
			
			Set dTransDateTime = $ZDateH($Piece(oTrans.TransDateTime," "), 3)
			Set dFromDate=dTransDateTime
			Set dToDate=dTransDateTime+1
	
			Set tSC = oRS.Execute(oTrans.FromAccount.%Id(), dFromDate, dToDate)
			Quit:$System.Status.IsError(tSC)
			
			If oRS.Next()
			{
				Do oTrans.WhiteListedBySetObjectId(oRS.GetData(1))
			}
			Else
			{
				Set tRequestDate=dTransDateTime-$Random(10)
				
				// As I am not passing the last parameter (pWhiteListRequestId), it will generate one out of a 
				// $Increment on a sequence global. This is just for the demo. This patter should never be followed 
				// on production systems because there is no need.
				Set oWhiteList = ##class(IRISDemo.WhiteListRequest).%New(tRequestDate, oTrans.FromAccount, dFromDate, dToDate)
				
				Set tSC = oWhiteList.%Save()
				Quit:$System.Status.IsError(tSC)
				
				Set oTrans.WhiteListedBy=oWhiteList
			}
			
			Set tSC = oTrans.%Save()
		}
		Catch (oException)
		{
			Set tSC = oException.AsStatus()
		}
				
		Quit tSC
	}
	
	ClassMethod DateOfBirthForAgeGroup(pAgeGroup As %Integer) As %Date
	{
		If pAgeGroup=0
		{
			Set iAgeMin=15
			Set iAgeMax=18 
		}
		ElseIf pAgeGroup=1
		{
			Set iAgeMin=19
			Set iAgeMax=25 
		}
		ElseIf pAgeGroup=2
		{
			Set iAgeMin=26
			Set iAgeMax=35 
		}
		ElseIf pAgeGroup=3
		{
			Set iAgeMin=36
			Set iAgeMax=45 
		}
		ElseIf pAgeGroup=4
		{
			Set iAgeMin=46
			Set iAgeMax=55 
		}
		ElseIf pAgeGroup=5
		{
			Set iAgeMin=56
			Set iAgeMax=65 
		}
		Else
		{
			Set iAgeMin=$Random(60)+18
			Set iAgeMax=iAgeMin+1
		}
	
		Set iDateMax=$H-(iAgeMin*365)
		Set iDateMin=$H-(iAgeMax*365)
		
		Set iDateDelta=$Random(iDateMax-iDateMin)
		
		Quit iDateMin+iDateDelta
	}
	
	ClassMethod ClearErrors() [ Private ]
	{
		Kill ^IRISDemo.TransL
	}
	
	ClassMethod LogError(pLine As %Integer, pError As %String) [ Private ]
	{
		Set i=$Increment(^IRISDemo.TransL("Errors"))
		Set ^IRISDemo.TransL("Errors",i)=$LB(pLine, pError)
	}
	
	ClassMethod ShowResults(pSC As %Status) [ Private ]
	{
		Do $System.Status.DisplayError(pSC)
		
		Set iTotalLines=^IRISDemo.TransL("Total")
		Set iTotalErrors=$Get(^IRISDemo.TransL("Errors"),0)
		
		For i=1:1:iTotalErrors 
		{
			Set i=$Order(^IRISDemo.TransL("Errors",i))
			
			Set tErrorData = ^IRISDemo.TransL("Errors",i)
			
			Write !,$LG(tErrorData,1),$C(9),": ",$LG(tErrorData,2)
		}
		
		Write !,iTotalLines," lines processed.",!
		Write !,iTotalErrors," errors reported - "_(iTotalErrors/iTotalLines*100)_"% of the records.",!
		
		Kill ^IRISDemo.Trans
	}

}
