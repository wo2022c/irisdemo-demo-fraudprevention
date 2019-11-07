/// 
Class WhiteList.BP.CreateWLReq.Process Extends Ens.BusinessProcessBPL [ ClassType = persistent, ProcedureBlock ]
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='WhiteList.BS.WhiteListReq' response='WhiteList.BS.WhiteListResp' height='2150' width='2000' >
<sequence xend='200' yend='450' >
<call name='Create White List' target='White List Operation' async='0' xpos='200' ypos='250' >
<request type='WhiteList.BO.CreateWhiteListReq' >
<assign property="callrequest.RequestDate" value="request.RequestDate" action="set" />
<assign property="callrequest.FromAccountNumber" value="request.FromAccountNumber" action="set" />
<assign property="callrequest.FromDate" value="request.FromDate" action="set" />
<assign property="callrequest.ToDate" value="request.ToDate" action="set" />
</request>
<response type='WhiteList.BO.CreateWhiteListResp' >
<assign property="response.WhiteListRequestId" value="callresponse.WhiteListRequestId" action="set" />
</response>
</call>
<call name='Update Datalake' target='Datalake White List Operation' async='1' xpos='200' ypos='350' >
<request type='Datalake.BO.WhiteList.CreateWhiteListReq' >
<assign property="callrequest.RequestDate" value="request.RequestDate" action="set" />
<assign property="callrequest.FromAccountNumber" value="request.FromAccountNumber" action="set" />
<assign property="callrequest.FromDate" value="request.FromDate" action="set" />
<assign property="callrequest.ToDate" value="request.ToDate" action="set" />
<assign property="callrequest.WhiteListRequestId" value="response.WhiteListRequestId" action="set" />
</request>
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
