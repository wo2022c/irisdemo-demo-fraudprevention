Class BankingCore.Transaction.TransactionServicesSoap Extends Ens.BusinessOperation [ ProcedureBlock ]
{

Parameter ADAPTER = "EnsLib.SOAP.OutboundAdapter";

Method CreateTransaction(pRequest As BankingCore.Transaction.CreateTransactionRequest, Output pResponse As BankingCore.Transaction.CreateTransactionResponse) As %Library.Status
{
 Set ..Adapter.WebServiceClientClass = "BankingCore.Transaction.WSProxy.TransactionServicesSoap"
 Set tSC = ..Adapter.InvokeMethod("CreateTransaction",.CreateTransactionResult,pRequest.pTransDateTime,pRequest.pTransType,pRequest.pAmount,pRequest.pFromAccountNumber,pRequest.pToAccountNumber)  Quit:$$$ISERR(tSC) tSC
 Set tSC = pRequest.NewResponse(.pResponse)  Quit:$$$ISERR(tSC) tSC
 Set pResponse.CreateTransactionResult=$get(CreateTransactionResult)
 Quit $$$OK
} 

XData MessageMap
{
<MapItems>
	<MapItem MessageType="BankingCore.Transaction.CreateTransactionRequest">
		<Method>CreateTransaction</Method>
	</MapItem>
</MapItems>
}

}
