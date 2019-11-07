Class WhiteList.BO.QueryWhiteListReq Extends (%Persistent,Ens.Request)
{
	Property FromAccountNumber As %String [ Required ];
	
Storage Default
{
<Data name="QueryWhiteListReqDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>FromAccountNumber</Value>
</Value>
</Data>
<DataLocation>^WhiteList.BO.QueryWhiteL1B8DD</DataLocation>
<DefaultData>QueryWhiteListReqDefaultData</DefaultData>
<IdLocation>^WhiteList.BO.QueryWhiteL1B8DD</IdLocation>
<IndexLocation>^WhiteList.BO.QueryWhiteL1B8DI</IndexLocation>
<StreamLocation>^WhiteList.BO.QueryWhiteL1B8DS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}