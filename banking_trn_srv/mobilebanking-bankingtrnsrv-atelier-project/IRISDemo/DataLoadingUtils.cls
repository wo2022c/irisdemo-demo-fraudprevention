Include DEMOMACROS

Class IRISDemo.DataLoadingUtils
{
	/// This is called from IRISDemo.Installer to load the white list that 
	/// was exported from the datalake
	ClassMethod LoadWhiteList(pFileName As %String) As %Status
	{
		#Dim oTrans As IRISDemo.Trans
		
		Set tSC = $$$OK
		Try
		{
			Write !!,"Loading white list data exported from datalake...",!
			
			//Disable journaling to speed data bulk load
			DO DISABLE^%NOJRN
			
			//So we can insert the white list records setting the IDs.
			//This is useful for data loading, but not for production!
			Do $System.SQL.SetIdentityInsert(1, .tSC)
			Quit:$System.Status.IsError(tSC)
			
			Set iLine=0 //Header is consumed
			
			Set oRSWL=##class(%ResultSet).%New("IRISDemo.Util.FileReader:CSV2")
			Set tSC = oRSWL.Execute(pFileName)
			Quit:$System.Status.IsError(tSC)
			
			While oRSWL.Next()
			{
				Set iLine=iLine+1
				
				Set tID = oRSWL.Get("BS_WL_REQ_ID")
				Set tRequestDate = oRSWL.Get("BS_WL_REQ_DATE")
				Set tFromAccountNumber = oRSWL.Get("BC_ACC_NUMBER")
				Set tFromDate = oRSWL.Get("BS_WL_VALID_FROM")
				Set tToDate = oRSWL.Get("BS_WL_VALID_TO")
				
				&SQL(insert into WhiteList_Data.WhiteListRequest (ID, RequestDate, FromAccountNumber, FromDate, ToDate) values (:tID, :tRequestDate, :tFromAccountNumber, :tFromDate, :tToDate))
				$$$ThrowSQLExceptionIfError("LoadWhiteListException")
			}
			
			Write !,"Loading of white list data finished OK!",!
		}
		Catch (oException)
		{
			Set tSC = oException.AsStatus()
		}
		
		DO ENABLE^%NOJRN
		
		Do $System.SQL.SetIdentityInsert(0)
				
		Quit tSC
	}
}