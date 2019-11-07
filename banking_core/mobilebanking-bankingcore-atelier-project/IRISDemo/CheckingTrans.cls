Include DEMOMACROS

Class IRISDemo.CheckingTrans Extends %Persistent
{	
	Property TransDateTime as %TimeStamp;
	
	Property TransType As %Library.String(VALUELIST=",PAYMENT,REFUND,CASH_IN,CASH_OUT,TRANSFER") [ SqlColumnNumber = 3 ];
	
	Property Amount As %Library.Double;
	
	/// Customer/Merchant who started the transaction
	Property FromAccount As Account;
	
	ForeignKey FromAccountFK(FromAccount) References IRISDemo.Account();
	
	/// Initial balance before the transaction
	Property FromAccountOldBalance As %Library.Double;
	
	/// new balance after the transaction
	Property FromAccountNewBalance As %Library.Double;

	/// customer who is the recipient of the transaction
	Property ToAccount As Account;
	
	ForeignKey ToAccountFK(ToAccount) References IRISDemo.Account();
	
	/// Initial balance recipient before the transaction. Note that there is not information for customers that start with M (Merchants).
	Property ToAccountOldBalance As %Library.Double;
	
	/// new balance recipient after the transaction. Note that there is not information for customers that start with M (Merchants).
	Property ToAccountNewBalance As %Library.Double;
	
/// Throws exceptions!
/// If successful, returns new transaction ID
/// This method is called by a SOAP service on class IRISDemo.Services.TransactionServices  
ClassMethod CreateTransaction(pTransDateTime As %TimeStamp, pTransType As %String, pAmount As %Double, pFromAccountNumber As %String, pToAccountNumber As %String, pIgnoreLackOfFounds As %Boolean = 0) As IRISDemo.CheckingTrans 
{
	#Dim oTrans As IRISDemo.MobileTransaction
	Set tSC = $$$OK
	
	Set tTransactionId=""
	Set oTrans = ..%New()
	
	Set oTrans.FromAccount = ##class(Account).AccountNumberIndexOpen(pFromAccountNumber,,.tSC)
	$$$ThrowStatusExceptionIfError(tSC, "SourceAccountNumberNotFoundException")

	Set oTrans.ToAccount = ##class(Account).AccountNumberIndexOpen(pToAccountNumber,,.tSC)
	$$$ThrowStatusExceptionIfError(tSC, "DestinationAccountNumberNotFoundException")

	Set oTrans.Amount=pAmount
	Set oTrans.TransDateTime=pTransDateTime
	Set oTrans.TransType=pTransType
	
	Set oTrans.FromAccountOldBalance=oTrans.FromAccount.Balance
	Set oTrans.ToAccountOldBalance=oTrans.ToAccount.Balance
	
	Set oTrans.ToAccount.Balance=oTrans.ToAccount.Balance+oTrans.Amount
	Set oTrans.FromAccount.Balance=oTrans.FromAccount.Balance-oTrans.Amount

	Do oTrans.ValidateTransaction(pIgnoreLackOfFounds)
			
	Set oTrans.FromAccountNewBalance=oTrans.FromAccount.Balance
	Set oTrans.ToAccountNewBalance=oTrans.ToAccount.Balance
	
	Set tSC = oTrans.%Save(1)
	$$$ThrowStatusExceptionIfError(tSC, "SaveTransactionException")
	
	Quit oTrans
}

/// Throws exception if validation fails!
Method ValidateTransaction(pIgnoreLackOfFounds As %Boolean = 0) 
{
	#Dim oTrans As IRISDemo.MobileTransaction
	Set tRet=1

	If (..TransType="PAYMENT")
	{
		If ..FromAccount.%ClassName()'="CustomerAccount"
		{
			$$$ThrowException("InvalidSourceAccountNumberException", "Source account type should be Customer")
		}

		If ..ToAccount.%ClassName()'="MerchantAccount"
		{
			$$$ThrowException("InvalidDestinationAccountNumberException", "Destination account type should be Merchant")
		}				
	}
			
	If 'pIgnoreLackOfFounds && (..FromAccount.Balance<0)
	{
		$$$ThrowException("InsufficientFundsOnSourceException", "Source account has insufficient funds.")
	} 

}

Storage Default
{
<Data name="CheckingTransDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>TransDateTime</Value>
</Value>
<Value name="3">
<Value>TransType</Value>
</Value>
<Value name="4">
<Value>Amount</Value>
</Value>
<Value name="5">
<Value>FromAccount</Value>
</Value>
<Value name="6">
<Value>FromAccountOldBalance</Value>
</Value>
<Value name="7">
<Value>FromAccountNewBalance</Value>
</Value>
<Value name="8">
<Value>ToAccount</Value>
</Value>
<Value name="9">
<Value>ToAccountOldBalance</Value>
</Value>
<Value name="10">
<Value>ToAccountNewBalance</Value>
</Value>
<Value name="11">
<Value>IsFraud</Value>
</Value>
<Value name="12">
<Value>TransactionNumber</Value>
</Value>
</Data>
<DataLocation>^IRISDemo.CheckingTransD</DataLocation>
<DefaultData>CheckingTransDefaultData</DefaultData>
<IdLocation>^IRISDemo.CheckingTransD</IdLocation>
<IndexLocation>^IRISDemo.CheckingTransI</IndexLocation>
<StreamLocation>^IRISDemo.CheckingTransS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}