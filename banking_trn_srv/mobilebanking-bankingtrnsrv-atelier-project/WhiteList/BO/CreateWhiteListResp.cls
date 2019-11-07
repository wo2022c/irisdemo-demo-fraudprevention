Class WhiteList.BO.CreateWhiteListResp Extends (%Persistent,Ens.Response)
{
	Property WhiteListRequestId As %String [ Required ];
	
Storage Default
{
<Data name="CreateWhiteListRespDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>WhiteListRequestId</Value>
</Value>
</Data>
<DataLocation>^WhiteList.BO.CreateWhite3CE5D</DataLocation>
<DefaultData>CreateWhiteListRespDefaultData</DefaultData>
<IdLocation>^WhiteList.BO.CreateWhite3CE5D</IdLocation>
<IndexLocation>^WhiteList.BO.CreateWhite3CE5I</IndexLocation>
<StreamLocation>^WhiteList.BO.CreateWhite3CE5S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}