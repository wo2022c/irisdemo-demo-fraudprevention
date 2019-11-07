Include DEMOMACROS

/// This class exposes banking transactional services to the organization. 
/// It shows how to correctly deal with exceptions when using SOAP (by using Faults) and good
/// practices on trapping errors. 
Class IRISDemo.SOAP.TransactionServices Extends %SOAP.WebService [ ProcedureBlock ]
{

/// Name of the WebService.
Parameter SERVICENAME = "TransactionServices";

/// SOAP Namespace for the WebService
Parameter NAMESPACE = "http://bankingcore.demo";

//Parameter LOCATION = "http://bankingcore/csp/app/IRISDemo.Services.TransactionServices.cls";

/// Namespaces of referenced classes will be used in the WSDL.
Parameter USECLASSNAMESPACES = 1;

Method CreateTransaction(pTransDateTime As %TimeStamp, pTransType As %String(VALUELIST=",PAYMENT,REFUND,CASH_IN,CASH_OUT,TRANSFER") = "TRANSFER", pAmount As %Double, pFromAccountNumber As %String, pToAccountNumber As %String) As CreateTransactionResp [ WebMethod ]
{
	#Dim oResp As IRISDemo.SOAP.CreateTransactionResp
	#Dim oTrans As IRISDemo.CheckingTrans
	
	Set tSC = $$$OK
	Try
	{
		Set oTrans = ##class(IRISDemo.CheckingTrans).CreateTransaction(pTransDateTime,pTransType,pAmount,pFromAccountNumber,pToAccountNumber,0)
		
		Set oResp = ##class(CreateTransactionResp).%New()
		Set oResp.TransactionId = oTrans.%Id()
		Set oResp.FromAccountNewBalance=oTrans.FromAccountNewBalance
		Set oResp.FromAccountOldBalance=oTrans.FromAccountOldBalance
		Set oResp.ToAccountNewBalance=oTrans.ToAccountNewBalance
		Set oResp.ToAccountOldBalance=oTrans.ToAccountOldBalance

		Return oResp
	}
	Catch (oException)
	{
		$$$SOAPFaultWithException(oException)
	}
}

}
