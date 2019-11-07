Class IRISDemo.CustomerAccount Extends Account
{
	Property Gender As %String (VALUELIST=",M,F,U", DISPLAYLIST=",Male,Female,Unknown") [ Required ];
	
	Property DateOfBirth As %Date;
	
	Property Age As %Integer [ SqlComputed, SqlComputeCode = { Set {*}=($H-{DateOfBirth})/365 }, Transient ];
	
Storage Default
{
<Data name="CustomerAccountDefaultData">
<Subscript>"CustomerAccount"</Subscript>
<Value name="1">
<Value>Gender</Value>
</Value>
<Value name="2">
<Value>DateOfBirth</Value>
</Value>
</Data>
<DefaultData>CustomerAccountDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}