Class BankingSrv.PMML.FraudPrevModel Extends %DeepSee.PMML.Definition
{
XData PMML [ XMLNamespace = "http://www.intersystems.com/deepsee/pmml" ]
{
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<PMML xmlns="http://www.dmg.org/PMML-4_3" xmlns:data="http://jpmml.org/jpmml-model/InlineTable" version="4.3">
	<Header>
		<Application name="JPMML-SkLearn" version="1.5.4"/>
		<Timestamp>2018-08-14T23:33:25Z</Timestamp>
	</Header>
	<!--MiningBuildTask>
		<Extension>PMMLPipeline(steps=[('dtc', DecisionTreeClassifier(class_weight='balanced', criterion='gini',
            max_depth=None, max_features=None, max_leaf_nodes=10,
            min_impurity_decrease=0.0, min_impurity_split=None,
            min_samples_leaf=1, min_samples_split=2,
            min_weight_fraction_leaf=0.0, presort=False, random_state=0,
            splitter='best'))])</Extension>
	</MiningBuildTask-->
	<DataDictionary>
		<DataField name="fraud" optype="categorical" dataType="string">
			<Value value="0"/>
			<Value value="1"/>
		</DataField>
		<DataField name="merchant" optype="continuous" dataType="float"/>
		<DataField name="category" optype="continuous" dataType="float"/>
		<DataField name="amount" optype="continuous" dataType="float"/>
	</DataDictionary>
	<TransformationDictionary>
		<DerivedField name="doubleamount" optype="continuous" dataType="double">
			<FieldRef field="amount"/>
		</DerivedField>
		<DerivedField name="doublecategory" optype="continuous" dataType="double">
			<FieldRef field="category"/>
		</DerivedField>
		<DerivedField name="doublemerchant" optype="continuous" dataType="double">
			<FieldRef field="merchant"/>
		</DerivedField>
	</TransformationDictionary>
	<TreeModel functionName="classification" missingValueStrategy="nullPrediction" splitCharacteristic="multiSplit">
		<MiningSchema>
			<MiningField name="fraud" usageType="target"/>
			<MiningField name="doubleamount"/>
			<MiningField name="doublecategory"/>
			<MiningField name="doublemerchant"/>
		</MiningSchema>
		<Output>
			<OutputField name="probability(0)" optype="continuous" dataType="double" feature="probability" value="0"/>
			<OutputField name="probability(1)" optype="continuous" dataType="double" feature="probability" value="1"/>
		</Output>
		<Node>
			<True/>
			<Node>
				<SimplePredicate field="doubleamount" operator="lessOrEqual" value="77.00098419189453"/>
				<Node>
					<SimplePredicate field="doublecategory" operator="lessOrEqual" value="11.999605178833008"/>
					<Node score="0" recordCount="20451.0">
						<SimplePredicate field="doublecategory" operator="lessOrEqual" value="3.0052456855773926"/>
						<ScoreDistribution value="0" recordCount="18363.0"/>
						<ScoreDistribution value="1" recordCount="2088.0"/>
					</Node>
					<Node score="0" recordCount="1659.0">
						<SimplePredicate field="doublemerchant" operator="lessOrEqual" value="5.031520843505859"/>
						<ScoreDistribution value="0" recordCount="1633.5"/>
						<ScoreDistribution value="1" recordCount="25.5"/>
					</Node>
					<Node score="1" recordCount="36267.0">
						<True/>
						<ScoreDistribution value="0" recordCount="6318.0"/>
						<ScoreDistribution value="1" recordCount="29949.0"/>
					</Node>
				</Node>
				<Node score="1" recordCount="6859.5">
					<SimplePredicate field="doublemerchant" operator="lessOrEqual" value="17.0"/>
					<ScoreDistribution value="0" recordCount="1206.0"/>
					<ScoreDistribution value="1" recordCount="5653.5"/>
				</Node>
				<Node score="0" recordCount="269520.0">
					<True/>
					<ScoreDistribution value="0" recordCount="268071.0"/>
					<ScoreDistribution value="1" recordCount="1449.0"/>
				</Node>
			</Node>
			<Node score="0" recordCount="1940.25">
				<SimplePredicate field="doublemerchant" operator="lessOrEqual" value="1.5"/>
				<ScoreDistribution value="0" recordCount="1940.25"/>
				<ScoreDistribution value="1" recordCount="0.0"/>
			</Node>
			<Node>
				<SimplePredicate field="doubleamount" operator="lessOrEqual" value="118.00061798095703"/>
				<Node score="0" recordCount="2751.0">
					<SimplePredicate field="doublecategory" operator="lessOrEqual" value="3.001321315765381"/>
					<ScoreDistribution value="0" recordCount="2091.0"/>
					<ScoreDistribution value="1" recordCount="660.0"/>
				</Node>
				<Node score="1" recordCount="16555.5">
					<SimplePredicate field="doublecategory" operator="lessOrEqual" value="11.99929428100586"/>
					<ScoreDistribution value="0" recordCount="1851.0"/>
					<ScoreDistribution value="1" recordCount="14704.5"/>
				</Node>
				<Node score="0" recordCount="5384.25">
					<True/>
					<ScoreDistribution value="0" recordCount="2789.25"/>
					<ScoreDistribution value="1" recordCount="2595.0"/>
				</Node>
			</Node>
			<Node score="1" recordCount="255433.5">
				<True/>
				<ScoreDistribution value="0" recordCount="4147.5"/>
				<ScoreDistribution value="1" recordCount="251286.0"/>
			</Node>
		</Node>
	</TreeModel>
</PMML>
}

}