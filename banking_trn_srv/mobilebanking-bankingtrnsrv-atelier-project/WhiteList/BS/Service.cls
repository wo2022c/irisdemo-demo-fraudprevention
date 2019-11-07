Class WhiteList.BS.Service extends IRISDemo.BS.REST.Service 
{ 
	
	XData UrlMap
	{ 
	  <Routes>
	    <Route Url="/" Method="POST" Call="WhiteListRequest" />
	  </Routes>
	} 
	
	ClassMethod WhiteListRequest() As %Status
	{
		Set tSC = $$$OK
		Try
		{
			Set doResponse={}
			Set doResponse.RequestResult={}

			Set %response.ContentType=..#CONTENTTYPEJSON
			Set doWhiteListRequest=##class(%DynamicObject).%FromJSON(%request.Content)
			
			Set oRequest = ##class(WhiteList.BS.WhiteListReq).CreateNewFromDynamicObj(doWhiteListRequest)
			
			// I can't call ProcessInput directly because I am running on a class method that was called
			// by the dispatcher. The Business Service's instance hasn't been created yet. This method will
			// create it for me and call ProcessInput:
			Do ..DispatchTo("Create White List Process", oRequest, .oResponse)

			Set doResponse.RequestResult.Status="OK"
			Set doResponse.RequestResult.WhiteListRequestId=oResponse.WhiteListRequestId
		}
		Catch (oException)
		{
			Set doResponse.RequestResult.Status="Error"
			Set doResponse.RequestResult.Exception=$$$ExceptionAsJSON(oException)
		}
		
		Write doResponse.%ToJSON()
		
		Quit $$$OK
	}

}