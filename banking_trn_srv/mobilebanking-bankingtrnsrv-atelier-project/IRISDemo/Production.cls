Class IRISDemo.Production Extends IRISDemo.BaseProduction
{

XData ProductionDefinition
{
<Production Name="IRISDemo.Production" TestingEnabled="true" LogGeneralTraceEvents="true">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Banking Core Transaction Operation" Category="Banking Core" ClassName="BankingCore.Transaction.TransactionServicesSoap" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="SOAPCredentials">BankingCore</Setting>
    <Setting Target="Host" Name="SendSuperSession">0</Setting>
    <Setting Target="Adapter" Name="WebServiceURL">http://bankingcore:52773/csp/app/soap/IRISDemo.SOAP.TransactionServices.cls</Setting>
  </Item>
  <Item Name="Banking Transaction Service" Category="Banking Tran. Srv." ClassName="BankingSrv.BS.Transaction.Service" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Transaction Process" Category="Banking Core,Banking Tran. Srv." ClassName="BankingSrv.BP.Transaction.AIProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="RuleLogging">a</Setting>
  </Item>
  <Item Name="White List Service" Category="White List" ClassName="WhiteList.BS.Service" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="White List Operation" Category="White List" ClassName="WhiteList.BO.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Datalake Transaction Operations" Category="Datalake" ClassName="Datalake.BO.Transaction.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="Credentials">Datalake</Setting>
    <Setting Target="Adapter" Name="DSN">jdbc:IRIS://datalake:51773/APP</Setting>
    <Setting Target="Adapter" Name="JDBCDriver">com.intersystems.jdbc.IRISDriver</Setting>
    <Setting Target="Adapter" Name="JGService">Java Gateway Service</Setting>
    <Setting Target="Adapter" Name="StayConnected">30</Setting>
    <Setting Target="Host" Name="FailureTimeout">-1</Setting>
    <Setting Target="Host" Name="ReplyCodeActions">E=R</Setting>
  </Item>
  <Item Name="Java Gateway Service" Category="Datalake" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Create White List Process" Category="White List" ClassName="WhiteList.BP.CreateWLReq.Process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Datalake White List Operation" Category="Datalake,White List" ClassName="Datalake.BO.WhiteList.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Adapter" Name="JGService">Java Gateway Service</Setting>
    <Setting Target="Adapter" Name="Credentials">Datalake</Setting>
    <Setting Target="Adapter" Name="DSN">jdbc:IRIS://datalake:51773/APP</Setting>
    <Setting Target="Adapter" Name="JDBCDriver">com.intersystems.jdbc.IRISDriver</Setting>
    <Setting Target="Host" Name="FailureTimeout">-1</Setting>
    <Setting Target="Host" Name="ReplyCodeActions">E=R</Setting>
    <Setting Target="Host" Name="RetryInterval">30</Setting>
    <Setting Target="Adapter" Name="StayConnected">10</Setting>
  </Item>
  <Item Name="Populate Lookup Table Service" Category="Datalake" ClassName="IRISDemo.BS.LookupTable.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="true" Schedule="">
    <Setting Target="Host" Name="LookupTableLoadingSpec"><![CDATA[Merchant_Category_Feature, IRISDemo.BC_MERCH_ACCOUNT, BC_ACC_NUMBER, BC_MERCH_CATEGORY->BC_MERCH_CAT_CODE
Merchant_Feature, IRISDemo.BC_MERCH_ACCOUNT, BC_ACC_NUMBER, BC_MERCH_CODE]]></Setting>
    <Setting Target="Host" Name="DownloadBusinessOperation">Datalake Lookup Table Download Operation</Setting>
  </Item>
  <Item Name="Datalake Lookup Table Download Operation" Category="Datalake" ClassName="IRISDemo.BO.LookupTable.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Credentials">Datalake</Setting>
    <Setting Target="Adapter" Name="DSN">jdbc:IRIS://datalake:51773/APP</Setting>
    <Setting Target="Adapter" Name="JGService">Java Gateway Service</Setting>
    <Setting Target="Adapter" Name="StayConnected">-1</Setting>
    <Setting Target="Adapter" Name="JDBCDriver">com.intersystems.jdbc.IRISDriver</Setting>
    <Setting Target="Host" Name="ReplyCodeActions">E=R</Setting>
    <Setting Target="Host" Name="FailureTimeout">-1</Setting>
  </Item>
  <Item Name="Fraud Prediction ML Model Executor" Category="" ClassName="ML.Model.BO.Executor.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="PMML">BankingSrv.PMML.FraudPreventionBoostedTreeModel</Setting>
  </Item>
  <Item Name="PMML File Loader" Category="" ClassName="ML.PMML.BS.Loader.File.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="ArchivePath">/common_shared/imported_pmml</Setting>
    <Setting Target="Adapter" Name="FilePath">/common_shared/pmml/</Setting>
    <Setting Target="Adapter" Name="FileSpec">*.pmml</Setting>
  </Item>
</Production>
}

}
