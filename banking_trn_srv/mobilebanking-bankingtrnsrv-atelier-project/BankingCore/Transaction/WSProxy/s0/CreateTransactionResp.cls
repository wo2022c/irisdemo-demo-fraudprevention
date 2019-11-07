/// Created from: /shared/IRISDemo.SOAP.TransactionServices.cls.wsdl.xml
Class BankingCore.Transaction.WSProxy.s0.CreateTransactionResp Extends (%SerialObject, %XML.Adaptor) [ ProcedureBlock ]
{

Parameter ELEMENTQUALIFIED = 1;

Parameter NAMESPACE = "http://bankingcore.demo";

Parameter XMLNAME = "CreateTransactionResp";

Parameter XMLSEQUENCE = 1;

Parameter XMLIGNORENULL = 1;

Property TransactionId As %String(MAXLEN = "", XMLNAME = "TransactionId");

Property FromAccountOldBalance As %xsd.double(XMLNAME = "FromAccountOldBalance");

Property FromAccountNewBalance As %xsd.double(XMLNAME = "FromAccountNewBalance");

Property ToAccountOldBalance As %xsd.double(XMLNAME = "ToAccountOldBalance");

Property ToAccountNewBalance As %xsd.double(XMLNAME = "ToAccountNewBalance");

Storage Default
{
<Data name="CreateTransactionRespState">
<Value name="1">
<Value>TransactionId</Value>
</Value>
<Value name="2">
<Value>FromAccountOldBalance</Value>
</Value>
<Value name="3">
<Value>FromAccountNewBalance</Value>
</Value>
<Value name="4">
<Value>ToAccountOldBalance</Value>
</Value>
<Value name="5">
<Value>ToAccountNewBalance</Value>
</Value>
</Data>
<State>CreateTransactionRespState</State>
<StreamLocation>^BankingCor2BDC.CreateTrans6A62S</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
