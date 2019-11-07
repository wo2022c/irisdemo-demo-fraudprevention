Class Datalake.BO.Transaction.NewTransactionReq Extends (%Persistent,Ens.Request)
{
	Property TransactionNumber As %Integer [ Required ];
	
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
	
	Property FromAccountOldBalance As %Library.Double [ Required ];
	
	Property FromAccountNewBalance As %Library.Double [ Required ];
	
	/// customer who is the recipient of the transaction
	Property ToAccountNumber As %String [ Required ];

	Property ToAccountOldBalance As %Library.Double [ Required ];
	
	Property ToAccountNewBalance As %Library.Double [ Required ];
	
	Property WhiteListRequestId As %String;
	
	Property TransactionAllowed As %Boolean [ Required ];
	

Storage Default
{
<Data name="NewTransactionReqDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>TransactionNumber</Value>
</Value>
<Value name="3">
<Value>TransDateTime</Value>
</Value>
<Value name="4">
<Value>TransType</Value>
</Value>
<Value name="5">
<Value>Amount</Value>
</Value>
<Value name="6">
<Value>FromAccountNumber</Value>
</Value>
<Value name="7">
<Value>FromAccountOldBalance</Value>
</Value>
<Value name="8">
<Value>FromAccountNewBalance</Value>
</Value>
<Value name="9">
<Value>ToAccountNumber</Value>
</Value>
<Value name="10">
<Value>ToAccountOldBalance</Value>
</Value>
<Value name="11">
<Value>ToAccountNewBalance</Value>
</Value>
<Value name="12">
<Value>WhiteListRequestId</Value>
</Value>
<Value name="13">
<Value>TransactionAllowed</Value>
</Value>
</Data>
<DataLocation>^Datalake.B555E.NewTransact577DD</DataLocation>
<DefaultData>NewTransactionReqDefaultData</DefaultData>
<IdLocation>^Datalake.B555E.NewTransact577DD</IdLocation>
<IndexLocation>^Datalake.B555E.NewTransact577DI</IndexLocation>
<StreamLocation>^Datalake.B555E.NewTransact577DS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}