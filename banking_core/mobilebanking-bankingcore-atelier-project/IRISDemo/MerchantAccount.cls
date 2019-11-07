Class IRISDemo.MerchantAccount Extends Account
{
	Property Category As MerchantCategory [ Required ];
	
	ForeignKey MerchantCategoryFK(Category) References IRISDemo.MerchantCategory();
	
Storage Default
{
<Data name="MerchantAccountDefaultData">
<Subscript>"MerchantAccount"</Subscript>
<Value name="1">
<Value>Category</Value>
</Value>
</Data>
<DefaultData>MerchantAccountDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}