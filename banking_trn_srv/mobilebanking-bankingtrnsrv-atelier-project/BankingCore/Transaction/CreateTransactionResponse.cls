Class BankingCore.Transaction.CreateTransactionResponse Extends Ens.Response [ ProcedureBlock ]
{

Property CreateTransactionResult As BankingCore.Transaction.WSProxy.s0.CreateTransactionResp;

Storage Default
{
<Data name="CreateTransactionResponseDefaultData">
<Subscript>"CreateTransactionResponse"</Subscript>
<Value name="1">
<Value>CreateTransactionResult</Value>
</Value>
</Data>
<DefaultData>CreateTransactionResponseDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
