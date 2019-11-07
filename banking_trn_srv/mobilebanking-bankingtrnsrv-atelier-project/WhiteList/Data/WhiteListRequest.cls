Class WhiteList.Data.WhiteListRequest Extends %Persistent
{

	Property RequestDate As %TimeStamp [ InitialExpression = {$ZDateTime($ZTimeStamp, 3)} ];
	
	Property FromAccountNumber As %String [ Required ];
	
	Property FromDate As %Date [ Required ];
	
	Property ToDate As %Date [ Required ];
	
	Index WhiteListIndex On (FromAccountNumber, FromDate, ToDate) [ Unique ];
	
	Method %OnNew(pRequestDate As %TimeStamp, pFromAccountNumber As %String, pFromDate As %Date, pToDate As %Date) As %Status
	{
		Set ..RequestDate = pRequestDate
		Set ..FromAccountNumber = pFromAccountNumber
		Set ..FromDate = pFromDate
		Set ..ToDate = pToDate
		
		Quit $$$OK
	}
	
Storage Default
{
<Data name="WhiteListRequestDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>RequestDate</Value>
</Value>
<Value name="3">
<Value>FromAccountNumber</Value>
</Value>
<Value name="4">
<Value>FromDate</Value>
</Value>
<Value name="5">
<Value>ToDate</Value>
</Value>
</Data>
<DataLocation>^WhiteList8E59.WhiteListReABA5D</DataLocation>
<DefaultData>WhiteListRequestDefaultData</DefaultData>
<IdLocation>^WhiteList8E59.WhiteListReABA5D</IdLocation>
<IndexLocation>^WhiteList8E59.WhiteListReABA5I</IndexLocation>
<StreamLocation>^WhiteList8E59.WhiteListReABA5S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}