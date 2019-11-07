Class BankingSrv.DTL.BuildFeatures Extends Ens.DataTransformDTL [ DependsOn = (BankingSrv.BS.Transaction.NewTransactionReq) ]
{
 
XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='BankingSrv.BS.Transaction.NewTransactionReq' targetClass='IRISDemo.BO.PMML.ExecuteModelReq' create='new' language='objectscript' >
<assign value='source.Amount' property='target.ModelData' action='set' key='"amount"' />
<assign value='..Lookup("Merchant_Category_Feature",source.ToAccountNumber,-1,-1)' property='target.ModelData' action='set' key='"category"' />
<assign value='..Lookup("Merchant_Feature",source.ToAccountNumber,-1,-1)' property='target.ModelData' action='set' key='"merchant"' />
</transform>
}

}
