Class BankingCore.Transaction.CreateTransactionRequest Extends Ens.Request [ ProcedureBlock ]
{

Parameter RESPONSECLASSNAME = "BankingCore.Transaction.CreateTransactionResponse";

Property pTransDateTime As %TimeStamp;

Property pTransType As %String;

Property pAmount As %xsd.double;

Property pFromAccountNumber As %String;

Property pToAccountNumber As %String;

Storage Default
{
<Data name="CreateTransactionRequestDefaultData">
<Subscript>"CreateTransactionRequest"</Subscript>
<Value name="1">
<Value>pTransDateTime</Value>
</Value>
<Value name="2">
<Value>pTransType</Value>
</Value>
<Value name="3">
<Value>pAmount</Value>
</Value>
<Value name="4">
<Value>pFromAccountNumber</Value>
</Value>
<Value name="5">
<Value>pToAccountNumber</Value>
</Value>
<Value name="6">
<Value>pTransactionAllowed</Value>
</Value>
</Data>
<DefaultData>CreateTransactionRequestDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
