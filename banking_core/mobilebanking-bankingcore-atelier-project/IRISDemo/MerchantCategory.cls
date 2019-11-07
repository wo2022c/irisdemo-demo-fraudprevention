Class IRISDemo.MerchantCategory Extends (%Persistent, IRISDemo.Util.BaseCodeDesc)
{

Index CodeIndex On Code [ Unique ];

Storage Default
{
<Data name="MerchantCategoryDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Description</Value>
</Value>
<Value name="3">
<Value>Code</Value>
</Value>
</Data>
<DataLocation>^IRISDemo.MerchantCategoryD</DataLocation>
<DefaultData>MerchantCategoryDefaultData</DefaultData>
<IdLocation>^IRISDemo.MerchantCategoryD</IdLocation>
<IndexLocation>^IRISDemo.MerchantCategoryI</IndexLocation>
<StreamLocation>^IRISDemo.MerchantCategoryS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}