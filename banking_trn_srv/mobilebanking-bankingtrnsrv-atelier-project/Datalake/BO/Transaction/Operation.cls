Include DEMOMACROS

Class Datalake.BO.Transaction.Operation extends Ens.BusinessOperation {

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

Method NewTransaction(pInput As Datalake.BO.Transaction.NewTransactionReq, Output pOutput As Ens.Response) As %Status
{
	Set tSC = $$$OK
	Try
	{
		$$$TRACE("Set Auto Commit to OFF")
		Set tSC = ..Adapter.SetAutoCommit(0)
		Quit:$System.Status.IsError(tSC)
		
		$$$TRACE("Finding source account ID...")
		Set tSourceAccountId = ..FindAccountId(pInput.FromAccountNumber)
		
		$$$TRACE("Finding destination account ID...")
		Set tDestinationAccountId = ..FindAccountId(pInput.ToAccountNumber)
		
		$$$TRACE("Inserting new transaction.")
		Set tSC = ..InsertTransaction(tSourceAccountId, tDestinationAccountId, pInput)
		Quit:$System.Status.IsError(tSC)
		
		if pInput.TransactionAllowed
		{
			$$$TRACE("Updating source account balance")
			Set tSC = ..UpdateAccountBalance(tSourceAccountId, pInput.FromAccountNewBalance)
			Quit:$System.Status.IsError(tSC)
	
			$$$TRACE("Updating destination account balance")
			Set tSC = ..UpdateAccountBalance(tDestinationAccountId, pInput.ToAccountNewBalance) 
			Quit:$System.Status.IsError(tSC)
		}

	}
	Catch (oException)
	{
		Set tSC = oException.AsStatus()
	}
	
	If $System.Status.IsError(tSC)
	{
		$$$TRACE("Rolling back the transaction.")
		Set tSC2 = ..Adapter.Rollback()
	}
	Else
	{
		$$$TRACE("Commiting the transaction")
		Set tSC2 = ..Adapter.Commit()
	}
	
	If $System.Status.IsError(tSC2)
	{
		Set tSC = $System.Status.AppendStatus(tSC, tSC2)
	}
	
	Quit tSC
}

Method InsertTransaction(pSourceAccountId As %Integer, pDestinationAccountId As %Integer, pInput As Datalake.BO.Transaction.NewTransactionReq) As %Status
{
	Set tSC = $$$OK
	Try
	{		
		Set tInsertSQL = "insert into IRISDemo.BC_TRANSACTIONS "_
						 "(BC_TRANS_NUM, BC_TRANS_DATE, BC_TRANS_TYPE, BC_TRANS_AMOUNT, BC_TRANS_SRC_ACC, BC_TRANS_SRC_ACC_OLD_BAL, "_
						 "BC_TRANS_SRC_ACC_NEW_BAL, BC_TRANS_DEST_ACC, BC_TRANS_DEST_ACC_OLD_BAL, BC_TRANS_DEST_ACC_NEW_BAL, "_
						 "BC_TRANS_WHITELISTED_BY, BC_TRANS_WAS_BLOCKED) "_
						 "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
		
		Set pInsertParams=11
		
		Set pInsertParams(1)=pInput.TransactionNumber
		Set pInsertParams(2)=pInput.TransDateTime
		Set pInsertParams(3)=pInput.TransType
		Set pInsertParams(4)=pInput.Amount
		Set pInsertParams(5)=pSourceAccountId
		Set pInsertParams(6)=pInput.FromAccountOldBalance 
		Set pInsertParams(7)=pInput.FromAccountNewBalance
		Set pInsertParams(8)=pDestinationAccountId
		Set pInsertParams(9)=pInput.ToAccountOldBalance
		Set pInsertParams(10)=pInput.ToAccountNewBalance
		Set pInsertParams(11)=pInput.WhiteListRequestId
		Set pInsertParams(12)='pInput.TransactionAllowed
		
		Set tSC =  ..Adapter.ExecuteUpdateParmArray(.iNumRowsAffected, tInsertSQL, .pInsertParams)
	}
	Catch (oException)
	{
		Set tSC = oException.AsStatus()
	}
	
	Quit tSC
}

Method UpdateAccountBalance(pAccountId As %Integer, pBalance As %Decimal) As %Status
{
	Set tSC = $$$OK
	Try
	{		
		Set tUpdateSQL = "update IRISDemo.BC_ACCOUNT set BC_ACC_BALANCE=? where ID=?"
		
		Set pUpdateParams=2
		
		Set pUpdateParams(1)=pBalance
		Set pUpdateParams(2)=pAccountId

		Set tSC =  ..Adapter.ExecuteUpdateParmArray(.iNumRowsAffected, tUpdateSQL, .pUpdateParams)
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
    <MapItem MessageType="Datalake.BO.Transaction.NewTransactionReq">
        <Method>NewTransaction</Method>
    </MapItem>
</MapItems>
}

}