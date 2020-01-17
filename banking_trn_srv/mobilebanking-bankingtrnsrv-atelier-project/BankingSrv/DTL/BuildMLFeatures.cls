Class BankingSrv.DTL.BuildMLFeatures Extends Ens.DataTransformDTL [ DependsOn = (BankingSrv.BS.Transaction.NewTransactionReq, ML.Model.BO.Executor.ExecuteModelReq) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='BankingSrv.BS.Transaction.NewTransactionReq' targetClass='ML.Model.BO.Executor.ExecuteModelReq' create='new' language='objectscript' >
<assign value='source.Amount' property='target.ModelData' action='set' key='"amount"' />
<assign value='..Lookup("Merchant_Feature",source.ToAccountNumber,-1,-1)' property='target.ModelData' action='set' key='"merchant"' />
</transform>
}

}
