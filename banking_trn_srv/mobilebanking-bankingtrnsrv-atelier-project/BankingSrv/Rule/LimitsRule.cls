/// 
Class BankingSrv.Rule.AIRule Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "Ens.Rule.GeneralBusinessRuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="AIRule" context="BankingSrv.BP.Transaction.Process.Context" production="">
<ruleSet name="Evaluate ML Response" effectiveBegin="" effectiveEnd="">
<rule name="Unsuspicious Transaction" disabled="false">
<when condition="(FraudPrediction=0) || ((FraudPrediction=1)&amp;&amp;(Request.Amount &lt;= 50))">
<return>0</return>
</when>
</rule>
<rule name="Suspicious Transaction" disabled="false">
<when condition="(FraudPrediction=1)&amp;&amp;(Request.Amount &gt; 50)">
<return>1</return>
</when>
</rule>
<return>0</return>
</ruleSet>
</ruleDefinition>
}

}
