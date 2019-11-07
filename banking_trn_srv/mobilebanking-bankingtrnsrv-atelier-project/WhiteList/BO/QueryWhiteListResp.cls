Class WhiteList.BO.QueryWhiteListResp Extends (%Persistent,Ens.Response)
{
	Property WhiteListRequestFound As %Boolean [ InitialExpression = 0, Required ];
	
	Property WhiteListRequestId As %String;
	
	Property RequestDate As %TimeStamp;
	
	Property FromAccountNumber As %String ;
	
	Property FromDate As %Date ;
	
	Property ToDate As %Date ;

Storage Default
{
<Data name="QueryWhiteListRespDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>WhiteListRequestFound</Value>
</Value>
<Value name="3">
<Value>WhiteListRequestId</Value>
</Value>
<Value name="4">
<Value>RequestDate</Value>
</Value>
<Value name="5">
<Value>FromAccountNumber</Value>
</Value>
<Value name="6">
<Value>FromDate</Value>
</Value>
<Value name="7">
<Value>ToDate</Value>
</Value>
</Data>
<DataLocation>^WhiteList.BO.QueryWhiteLE1DBD</DataLocation>
<DefaultData>QueryWhiteListRespDefaultData</DefaultData>
<IdLocation>^WhiteList.BO.QueryWhiteLE1DBD</IdLocation>
<IndexLocation>^WhiteList.BO.QueryWhiteLE1DBI</IndexLocation>
<StreamLocation>^WhiteList.BO.QueryWhiteLE1DBS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}