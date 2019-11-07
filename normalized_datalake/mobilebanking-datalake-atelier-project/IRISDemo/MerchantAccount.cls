/// I am using SqlTableName and SqlFieldName to give the impression that this model is
/// totally different from the Banking Core system. This only afects the SQL engine. 
/// As we will be feeding/reading data through JDBC/Spark, this effect will be achieved
/// without having to change a lot of the code we had already written for the banking core.
/// The "BC_" prefix stands for "Banking Core"
Class IRISDemo.MerchantAccount Extends Account [ SqlTableName = "BC_MERCH_ACCOUNT" ]
{
	/// Code is not required here because I will be populating it AFTER we have
	/// loaded all records from the file. We will be following sklearn.preprocessing.LabelEncoder 
	/// encoding method for it.
	Property Code As %Integer [ SqlFieldName = "BC_MERCH_CODE" ];
	
	Property Category As MerchantCategory [ Required, SqlFieldName = "BC_MERCH_CATEGORY" ];
	
	ForeignKey MerchantCategoryFK(Category) References IRISDemo.MerchantCategory();
	
	
Storage Default
{
<Data name="MerchantAccountDefaultData">
<Subscript>"MerchantAccount"</Subscript>
<Value name="1">
<Value>Category</Value>
</Value>
<Value name="2">
<Value>Code</Value>
</Value>
</Data>
<DefaultData>MerchantAccountDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}