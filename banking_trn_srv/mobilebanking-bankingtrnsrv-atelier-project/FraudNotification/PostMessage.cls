/// As a base class you can use Ens.Request or Grongier.JsonTraceViewer.Request
///
/// With Ens.Request you will see messages in xml format in Message Viewer
/// With Grongier.JsonTraceViewer.Request you will see messages in json format
///
/// Class Grongier.JsonTraceViewer.Request - is one of the classes from package "objectscript-json-trace-viewer" (published on https://openexchange.intersystems.com/package/JsonTraceViewer)
/// Classes from "objectscript-json-trace-viewer" package are designed to show Request and Response messages in json format.

Class FraudNotification.EmailReq Extends Ens.Request
{
Property AccountId As %Integer;
Property EmailAddress As %String(MAXLEN=320);
Property TransactionNumber As %Integer;
Property Amount As %Double;
Property TransDateTime As %TimeStamp;
Property FraudReason As %String(MAXLEN=256);

Storage Default
{
<Data name="EmailReqDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>AccountId</Value>
</Value>
<Value name="3">
<Value>EmailAddress</Value>
</Value>
<Value name="4">
<Value>TransactionNumber</Value>
</Value>
<Value name="5">        
<Value>Amount</Value>
</Value>
<Value name="6">
<Value>TransDateTime</Value>
</Value>
<Value name="7">
<Value>FraudReason</Value>
</Value>
</Data>
<DefaultData>EmailReqDefaultData</DefaultData>
<DataLocation>^FraudNotification.EmailReq</DataLocation>
<Type>%Storage.Persistent</Type>    
}

// Class dc.Demo.PostMessage Extends Grongier.JsonTraceViewer.Request
// {

// Property ToEmailAddress As %String;

// Property Found As %String;

// Property Post As dc.Reddit.Post;

// Storage Default
// {
// <Data name="PostMessageDefaultData">
// <Subscript>"PostMessage"</Subscript>
// <Value name="1">
// <Value>ToEmailAddress</Value>
// </Value>
// <Value name="2">
// <Value>Post</Value>
// </Value>
// <Value name="3">
// <Value>Found</Value>
// </Value>
// </Data>
// <DefaultData>PostMessageDefaultData</DefaultData>
// <Type>%Storage.Persistent</Type>
// }

// }
}