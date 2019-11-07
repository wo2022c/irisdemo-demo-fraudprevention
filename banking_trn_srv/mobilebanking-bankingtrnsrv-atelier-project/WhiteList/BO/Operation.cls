Include DEMOMACROS

Class WhiteList.BO.Operation extends Ens.BusinessOperation {

Parameter INVOCATION = "Queue";

Method CreateWhiteList(pInput As CreateWhiteListReq, Output pOutput As CreateWhiteListResp) As %Status
{
	Set tSC = $$$OK
	Try
	{
		Set pOutput=##class(CreateWhiteListResp).%New()
		
		Set %objlasterror=$$$OK
		Set oWhiteListReq = ##class(WhiteList.Data.WhiteListRequest).%New(pInput.RequestDate, pInput.FromAccountNumber, pInput.FromDate, pInput.ToDate)
		$$$ThrowStatusExceptionIfError(%objlasterror, "CreateWhiteListRequestException")
		
		Set tSC = oWhiteListReq.%Save()
		If $$$ISERR(tSC)
		{
			If $System.Status.GetErrorCodes(tSC)["5808"
			{
				Set tSC = $$$OK
				Set oWhiteListReq=##class(WhiteList.Data.WhiteListRequest).WhiteListIndexOpen(pInput.FromAccountNumber, pInput.FromDate, pInput.ToDate,,.tSC)
			}
			
			$$$ThrowStatusExceptionIfError(tSC, "SaveWhiteListRequestException")
		}
		
		Set pOutput.WhiteListRequestId = oWhiteListReq.%Id()
	}
	Catch (oException)
	{
		Set tSC = oException.AsStatus()
	}
	
	Quit tSC
}

Method QueryWhiteList(pInput As QueryWhiteListReq, Output pOutput As QueryWhiteListResp) As %Status
{
	Set tSC = $$$OK
	Try
	{
		Set pOutput=##class(WhiteList.BO.QueryWhiteListResp).%New()
		
		Set oRS = ##class(%ResultSet).%New()
		Set tSC = oRS.Prepare("select * from WhiteList_Data.WhiteListRequest where FromAccountNumber=? and current_date between FromDate and ToDate")
		Quit:$System.Status.IsError(tSC)
		
		Set tSC = oRS.Execute(pInput.FromAccountNumber)
		Quit:$System.Status.IsError(tSC)
		
		If oRS.Next()
		{
			Set pOutput.WhiteListRequestFound=1
			Set pOutput.WhiteListRequestId=oRS.Get("ID")
			Set pOutput.FromAccountNumber=pInput.FromAccountNumber
			Set pOutput.FromDate=oRS.Get("FromDate")
			Set pOutput.ToDate=oRS.Get("ToDate")
			Set pOutput.RequestDate=oRS.Get("RequestDate")
		}
	}
	Catch (oException)
	{
		Set tSC = oException.AsStatus()
	}
	
	Quit tSC
}

XData MessageMap {
<MapItems>
    <MapItem MessageType="WhiteList.BO.CreateWhiteListReq">
        <Method>CreateWhiteList</Method>
    </MapItem>
    <MapItem MessageType="QueryWhiteListReq">
        <Method>QueryWhiteList</Method>
    </MapItem>
</MapItems>
}

}