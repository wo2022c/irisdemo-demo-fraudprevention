Class Datalake.BO.WhiteList.CreateWhiteListReq Extends (%Persistent,Ens.Request)
{
	Property WhiteListRequestId As %String [ Required ];
	
	/// Using UTC time
	Property RequestDate As %TimeStamp [ Required ];
	
	Property FromAccountNumber As %String [ Required ];
	
	Property FromDate As %Date [ Required ];
	
	Property ToDate As %Date [ Required ];

Storage Default
{
<Data name="CreateWhiteListReqDefaultData">
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
<DataLocation>^Datalake.BOF04.CreateWhite24A1D</DataLocation>
<DefaultData>CreateWhiteListReqDefaultData</DefaultData>
<IdLocation>^Datalake.BOF04.CreateWhite24A1D</IdLocation>
<IndexLocation>^Datalake.BOF04.CreateWhite24A1I</IndexLocation>
<StreamLocation>^Datalake.BOF04.CreateWhite24A1S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}