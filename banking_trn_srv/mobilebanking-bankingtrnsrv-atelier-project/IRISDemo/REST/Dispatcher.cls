Include DEMOMACROS

/// As per the documentation on https://docs.intersystems.com/latest/csp/docbook/DocBook.UI.Page.cls?KEY=EREST_service, one
/// should not use EnsLib.REST.Service to create REST business services with IRIS Interoperability. We should use %CSP.REST instead.
/// So, this dispatcher class will serve as an example of how to create a rest service that is calling a business service while
/// a better way of doing it is not available.
Class IRISDemo.REST.Dispatcher Extends %CSP.REST
{

Parameter UseSession = 1;

Parameter CONVERTINPUTSTREAM = 1;

Parameter CHARSET = "utf-8";

Parameter HandleCorsRequest = 1;

ClassMethod HandleDefaultCorsRequest(pUrl As %String) As %Status [ Private ]
{
    Do %response.SetHeader("Access-Control-Allow-Origin","*")
    Do %response.SetHeader("Access-Control-Allow-Credentials","true")
    Do %response.SetHeader("Access-Control-Allow-Methods","GET, PUT, POST, DELETE, PATCH, OPTIONS")
    Do %response.SetHeader("Access-Control-Allow-Headers","Access-Control-*, Content-Type, Authorization, Accept, Accept-Language, X-Requested-With, Origin")
    Quit $$$OK
}

XData UrlMap
{
<Routes>
    <Map Prefix="/transaction" Forward="BankingSrv.BS.Transaction.Service"/>
    <Map Prefix="/whitelist" Forward="WhiteList.BS.Service"/>
  </Routes>
}

}
