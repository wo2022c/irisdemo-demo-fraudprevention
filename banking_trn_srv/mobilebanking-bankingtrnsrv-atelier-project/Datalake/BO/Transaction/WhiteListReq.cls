Class Datalake.BO.Transaction.WhiteListReq Extends (%SerialObject,%XML.Adaptor)
{
	Property RequestDate As %TimeStamp;
	
	Property FromDate As %Date;
	
	Property ToDate As %Date;
	
Storage Default
{
<Data name="WhiteListReqState">
<Value name="1">
<Value>RequestDate</Value>
</Value>
<Value name="2">
<Value>FromDate</Value>
</Value>
<Value name="3">
<Value>ToDate</Value>
</Value>
</Data>
<State>WhiteListReqState</State>
<StreamLocation>^Datalake.BO.T555E.WhiteListReqS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}