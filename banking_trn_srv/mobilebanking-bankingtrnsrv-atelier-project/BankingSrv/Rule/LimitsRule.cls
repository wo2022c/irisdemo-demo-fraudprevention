/// 
Class BankingSrv.Rule.AIRule Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "Ens.Rule.GeneralBusinessRuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="AIRule" context="BankingSrv.BP.Transaction.Process.Context" production="">
<ruleSet name="Evaluate ML Response" effectiveBegin="" effectiveEnd="">
<rule name="Payments" disabled="false">
<when condition="(Request.TransType=&quot;PAYMENT&quot;)&amp;&amp;(ProbabilityOfFraud&gt;0.5)">
<return>1</return>
</when>
</rule>
<rule name="Transfers" disabled="false">
<when condition="(Request.TransType=&quot;TRANSFER&quot;)&amp;&amp;(ProbabilityOfFraud&gt;0.8)">
<return>1</return>
</when>
</rule>
<return>0</return>
</ruleSet>
</ruleDefinition>
}

}
