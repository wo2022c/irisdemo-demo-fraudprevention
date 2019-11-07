Include DEMOMACROS

Class Datalake.BO.WhiteList.Operation extends Ens.BusinessOperation {

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method CreateWhiteList(pInput As Datalake.BO.WhiteList.CreateWhiteListReq, Output pOutput As Ens.Response) As %Status
{
	Set tSC = $$$OK
	Try
	{
		Set tFromAccountId = ..FindAccountId(pInput.FromAccountNumber)
		
		Set tInsertSQL = "insert into IRISDemo.BS_WHITE_LIST_REQ "_
						 "(BS_WL_REQ_ID, BS_WL_REQ_DATE, BS_WL_ACCOUNT, BS_WL_VALID_FROM, BS_WL_VALID_TO) "_
						 "values (?, ?, ?, TO_DATE(?, 'YYYY-MM-DD'), TO_DATE(?, 'YYYY-MM-DD'))"
		
		Set pInsertParams=5
		Set pInsertParams(1)=pInput.WhiteListRequestId
		Set pInsertParams(2)=pInput.RequestDate
		Set pInsertParams(3)=tFromAccountId
		Set pInsertParams(4)=pInput.FromDate
		Set pInsertParams(5)=pInput.ToDate
		
		Set tSC =  ..Adapter.ExecuteUpdateParmArray(.iNumRowsAffected, tInsertSQL, .pInsertParams)
	}
	Catch (oException)
	{
		Set tSC = oException.AsStatus()
	}
	
	Quit tSC
}

/// Returns the ID of the source account
Method FindAccountId(pAccountNumber As %String) As %String
{
	Set pParams=1
	Set pParams(1)=pAccountNumber
	
	Set tSC = ..Adapter.ExecuteQueryParmArray(.oRS, "select ID from IRISDemo.BC_ACCOUNT where BC_ACC_NUMBER=?", .pParams)
	$$$ThrowStatusExceptionIfError(tSC, "FindSourceAccountIdException")
	
	If oRS.Next()
	{
		Return oRS.GetData(1)
	}

	$$$ThrowException("DataLakeAccountNumberNotFoundException", "pAccountNumber: "_pAccountNumber)
}

XData MessageMap {
<MapItems>
    <MapItem MessageType="Datalake.BO.WhiteList.CreateWhiteListReq">
        <Method>CreateWhiteList</Method>
    </MapItem>
</MapItems>
}

}