Class WhiteList.BS.WhiteListResp Extends (%Persistent,Ens.Response)
{
	Property WhiteListRequestId As %String ;
	
Storage Default
{
<Data name="WhiteListRespDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>WhiteListRequestId</Value>
</Value>
</Data>
<DataLocation>^WhiteList.BS.WhiteListRespD</DataLocation>
<DefaultData>WhiteListRespDefaultData</DefaultData>
<IdLocation>^WhiteList.BS.WhiteListRespD</IdLocation>
<IndexLocation>^WhiteList.BS.WhiteListRespI</IndexLocation>
<StreamLocation>^WhiteList.BS.WhiteListRespS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}