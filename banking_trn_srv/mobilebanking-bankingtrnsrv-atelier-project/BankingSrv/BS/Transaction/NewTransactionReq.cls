Class BankingSrv.BS.Transaction.NewTransactionReq  Extends (%Persistent, Ens.Request)
{

	Property TransDateTime As %TimeStamp [ Required ];
	
	 /// CASH_IN is the process of increasing the balance of account by paying in cash to a merchant.
	 /// CASH_OUT is the opposite process of CASH-IN, it means to withdraw cash from a merchant which decreases the balance of the account.
	 /// DEBIT is similar process than CASH-OUT and involves sending the money from the mobile money service to a bank account.
	 /// PAYMENT is the process of paying for goods or services to merchants which decreases the balance of the account and increases the balance of the receiver.
	 /// TRANSFER is the process of sending money to another user of the service through the mobile money platform.
	Property TransType As %Library.String(VALUELIST=",CASH_IN,CASH_OUT,DEBIT,PAYMENT,TRANSFER") [ Required ];
	
	Property Amount As %Library.Double(MINVAL=1) [ Required ];
	
	/// Customer/Merchant who started the transaction
	Property FromAccountNumber As %String [ Required ];
	
	/// customer who is the recipient of the transaction
	Property ToAccountNumber As %String [ Required ];
	
	ClassMethod CreateNewFromDynamicObj(pDynamicObj As %DynamicObject)
	{
		Set obj = ..%New()

		// Using UTC time
		Set obj.TransDateTime = $ZDateTime($ZTimeStamp,3)
		
		Set obj.TransType=pDynamicObj.TransType
		Set obj.Amount=pDynamicObj.Amount
		Set obj.FromAccountNumber=pDynamicObj.FromAccountNumber
		Set obj.ToAccountNumber=pDynamicObj.ToAccountNumber
		
		Quit obj
	}

Storage Default
{
<Data name="NewTransactionReqDefaultData">
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
<Value>FromAccountNumber</Value>
</Value>
<Value name="6">
<Value>ToAccountNumber</Value>
</Value>
</Data>
<DataLocation>^BankingSrvB430.NewTransact577DD</DataLocation>
<DefaultData>NewTransactionReqDefaultData</DefaultData>
<IdLocation>^BankingSrvB430.NewTransact577DD</IdLocation>
<IndexLocation>^BankingSrvB430.NewTransact577DI</IndexLocation>
<StreamLocation>^BankingSrvB430.NewTransact577DS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}