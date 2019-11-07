Class WhiteList.BS.WhiteListReq Extends (%Persistent, Ens.Request)
{
	/// Using UTC time
	Property RequestDate As %TimeStamp [ InitialExpression = {$ZDateTime($ZTimeStamp, 3)} ];
	
	Property FromAccountNumber As %String [ Required ];
	
	Property FromDate As %Date [ Required ];
	
	Property ToDate As %Date [ Required ];

	ClassMethod CreateNewFromDynamicObj(pDynamicObj As %DynamicObject)
	{
		Set obj = ..%New()
		
		Set obj.FromAccountNumber=pDynamicObj.FromAccountNumber
		Set obj.FromDate=$ZDateH(pDynamicObj.FromDate,3)
		Set obj.ToDate=$ZDateH(pDynamicObj.ToDate,3)
		
		Quit obj
	}
	
Storage Default
{
<Data name="WhiteListReqDefaultData">
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
<DataLocation>^WhiteList.BS.WhiteListReqD</DataLocation>
<DefaultData>WhiteListReqDefaultData</DefaultData>
<IdLocation>^WhiteList.BS.WhiteListReqD</IdLocation>
<IndexLocation>^WhiteList.BS.WhiteListReqI</IndexLocation>
<StreamLocation>^WhiteList.BS.WhiteListReqS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}