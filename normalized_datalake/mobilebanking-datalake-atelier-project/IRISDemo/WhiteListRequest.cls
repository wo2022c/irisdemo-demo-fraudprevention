Class IRISDemo.WhiteListRequest Extends %Persistent [ SqlTableName = "BS_WHITE_LIST_REQ" ]
{
	Property WhiteListRequestId As %String [ Required, SqlFieldName = "BS_WL_REQ_ID" ];
	
	Property RequestDate As %TimeStamp [ InitialExpression = {$ZDateTime($ZTimeStamp, 3)}, Required, SqlFieldName = "BS_WL_REQ_DATE" ];
	
	Property FromAccountNumber As IRISDemo.CustomerAccount [ Required, SqlFieldName = "BS_WL_ACCOUNT" ];
	
	ForeignKey FromAccountNumberFK(FromAccountNumber) References IRISDemo.CustomerAccount();
	
	Property FromDate As %Date [ Required, SqlFieldName = "BS_WL_VALID_FROM" ];
	
	Property ToDate As %Date [ Required, SqlFieldName = "BS_WL_VALID_TO" ];
	
	Index WhiteListIndex On (FromAccountNumber, FromDate, ToDate) [ Unique ];
	
	Index WhiteListPK On WhiteListRequestId [ Unique ];
	
	Method %OnNew(pRequestDate As %TimeStamp, pFromAccountNumber As IRISDemo.CustomerAccount, pFromDate As %Date, pToDate As %Date, pWhiteListRequestId As %String = "") As %Status
	{ 
		// This is just for the demo. We would never need to do this on production
		If pWhiteListRequestId="" Set pWhiteListRequestId=$Increment(^IRISDemo("WhiteListReqId"))
		
		Set ..WhiteListRequestId=pWhiteListRequestId
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
<Value name="6">
<Value>WhiteListRequestId</Value>
</Value>
</Data>
<DataLocation>^IRISDemo.WhiteListRequestD</DataLocation>
<DefaultData>WhiteListRequestDefaultData</DefaultData>
<IdLocation>^IRISDemo.WhiteListRequestD</IdLocation>
<IndexLocation>^IRISDemo.WhiteListRequestI</IndexLocation>
<StreamLocation>^IRISDemo.WhiteListRequestS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}