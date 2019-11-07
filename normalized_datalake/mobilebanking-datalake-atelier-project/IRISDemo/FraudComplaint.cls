/// The "CS_" prefix stands for "Customer Services"
Class IRISDemo.FraudComplaint Extends %Persistent [ SqlTableName = "CS_FRAUD_COMPLAINT" ]
{
	Property CustomerAccount As IRISDemo.CustomerAccount [ Required, SqlFieldName="CS_FRAUD_COMP_CUST_ACCOUNT" ];
	
	ForeignKey CustomerAccountFK(CustomerAccount) References IRISDemo.CustomerAccount();
	
	Property Transaction As IRISDemo.CheckingTrans [ Required, SqlFieldName="CS_FRAUD_COMP_TRANSACTION" ];
	
	ForeignKey TransactionFK(Transaction) References IRISDemo.CheckingTrans();
	
	Property ComplaintDate As %Date [ Required, SqlFieldName = "CS_FRAUD_COMP_DATE", InitialExpression = {+$ZTimeStamp} ];
	
	Property Confirmed As %Boolean [ InitialExpression = 0, Required, SqlFieldName = "CS_FRAUD_COMP_CONFIRMED" ];
	
	Index TransactionIndex On Transaction;
	
Storage Default
{
<Data name="FraudComplaintDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>CustomerAccount</Value>
</Value>
<Value name="3">
<Value>Transaction</Value>
</Value>
<Value name="4">
<Value>ComplaintDate</Value>
</Value>
<Value name="5">
<Value>Confirmed</Value>
</Value>
</Data>
<DataLocation>^IRISDemo.FraudComplaintD</DataLocation>
<DefaultData>FraudComplaintDefaultData</DefaultData>
<IdLocation>^IRISDemo.FraudComplaintD</IdLocation>
<IndexLocation>^IRISDemo.FraudComplaintI</IndexLocation>
<StreamLocation>^IRISDemo.FraudComplaintS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}