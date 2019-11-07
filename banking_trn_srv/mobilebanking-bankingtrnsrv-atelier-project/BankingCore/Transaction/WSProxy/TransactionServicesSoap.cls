Class BankingCore.Transaction.WSProxy.TransactionServicesSoap Extends %SOAP.WebClient [ ProcedureBlock ]
{

/// This is the URL used to access the web service.
Parameter LOCATION = "http://localhost:9090/csp/app/IRISDemo.SOAP.TransactionServices.cls";

/// This is the namespace used by the Service
Parameter NAMESPACE = "http://bankingcore.demo";

/// Use xsi:type attribute for literal types.
Parameter OUTPUTTYPEATTRIBUTE = 1;

/// Determines handling of Security header.
Parameter SECURITYIN = "ALLOW";

/// This is the name of the Service
Parameter SERVICENAME = "TransactionServices";

/// This is the SOAP version supported by the service.
Parameter SOAPVERSION = 1.1;

/// Overrides default handling of string arguments.
Parameter XMLIGNORENULL = 1;

Method CreateTransaction(pTransDateTime As %TimeStamp, pTransType As %String(VALUELIST=",PAYMENT,REFUND,CASH_IN,CASH_OUT,TRANSFER"), pAmount As %xsd.double, pFromAccountNumber As %String, pToAccountNumber As %String) As BankingCore.Transaction.WSProxy.s0.CreateTransactionResp [ Final, ProcedureBlock = 1, SoapBindingStyle = document, SoapBodyUse = literal, WebMethod ]
{
 Quit ..WebMethod("CreateTransaction").Invoke($this,"http://bankingcore.demo/IRISDemo.SOAP.TransactionServices.CreateTransaction",.pTransDateTime,.pTransType,.pAmount,.pFromAccountNumber,.pToAccountNumber)
}

}
