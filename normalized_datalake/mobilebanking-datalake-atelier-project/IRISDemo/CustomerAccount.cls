/// I am using SqlTableName and SqlFieldName to give the impression that this model is
/// totally different from the Banking Core system. This only afects the SQL engine. 
/// As we will be feeding/reading data through JDBC/Spark, this effect will be achieved
/// without having to change a lot of the code we had already written for the banking core.
/// The "BC_" prefix stands for "Banking Core"
Class IRISDemo.CustomerAccount Extends Account [ SqlTableName = BC_CUST_ACCOUNT ]
{
	Property Gender As %String (VALUELIST=",1,2,3", DISPLAYLIST=",Male,Female,Unknown") [ Required, SqlFieldName = "BC_ACC_CUST_GENDER" ];
	
	Property DateOfBirth As %Date [ SqlFieldName = "BC_ACC_CUST_DATEOFBIRTH" ];
	
	Property Age As %Integer [ SqlComputed, SqlComputeCode = { Set {*}=($H-{BC_ACC_CUST_DATEOFBIRTH})/365 }, Transient, SqlFieldName = "BC_ACC_CUST_AGE" ];
	
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