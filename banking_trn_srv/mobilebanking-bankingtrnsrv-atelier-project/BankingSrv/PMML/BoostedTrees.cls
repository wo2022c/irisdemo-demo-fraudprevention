Class BankingSrv.PMML.BoostedTrees Extends %DeepSee.PMML.Definition [ ProcedureBlock ]
{

XData PMML [ XMLNamespace = "http://www.intersystems.com/deepsee/pmml" ]
{
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<PMML xmlns="http://www.dmg.org/PMML-4_3" xmlns:data="http://jpmml.org/jpmml-model/InlineTable" version="4.3">
	<Header>
		<Application name="JPMML-SparkML" version="1.2.12"/>
		<Timestamp>2020-01-15T20:28:21Z</Timestamp>
	</Header>
	<DataDictionary>
		<DataField name="merchant" optype="categorical" dataType="integer">
			<Value value="2.0"/>
			<Value value="5.0"/>
			<Value value="16.0"/>
			<Value value="45.0"/>
			<Value value="48.0"/>
			<Value value="84.0"/>
			<Value value="96.0"/>
			<Value value="107.0"/>
			<Value value="137.0"/>
			<Value value="141.0"/>
			<Value value="160.0"/>
			<Value value="166.0"/>
			<Value value="205.0"/>
			<Value value="222.0"/>
			<Value value="240.0"/>
			<Value value="270.0"/>
			<Value value="274.0"/>
			<Value value="301.0"/>
			<Value value="303.0"/>
			<Value value="333.0"/>
			<Value value="336.0"/>
			<Value value="345.0"/>
			<Value value="370.0"/>
			<Value value="402.0"/>
			<Value value="546.0"/>
			<Value value="630.0"/>
			<Value value="679.0"/>
			<Value value="714.0"/>
			<Value value="746.0"/>
			<Value value="887.0"/>
			<Value value="930.0"/>
			<Value value="1011.0"/>
			<Value value="1138.0"/>
			<Value value="1353.0"/>
			<Value value="1462.0"/>
			<Value value="1720.0"/>
			<Value value="1728.0"/>
			<Value value="2471.0"/>
			<Value value="2516.0"/>
			<Value value="2620.0"/>
			<Value value="2669.0"/>
			<Value value="2742.0"/>
			<Value value="2811.0"/>
			<Value value="2934.0"/>
			<Value value="2952.0"/>
			<Value value="3059.0"/>
			<Value value="3469.0"/>
			<Value value="3485.0"/>
			<Value value="3659.0"/>
			<Value value="3843.0"/>
		</DataField>
		<DataField name="category" optype="categorical" dataType="integer">
			<Value value="1.0"/>
			<Value value="2.0"/>
			<Value value="3.0"/>
			<Value value="4.0"/>
			<Value value="5.0"/>
			<Value value="6.0"/>
			<Value value="7.0"/>
			<Value value="8.0"/>
			<Value value="9.0"/>
			<Value value="10.0"/>
			<Value value="11.0"/>
			<Value value="12.0"/>
			<Value value="13.0"/>
			<Value value="14.0"/>
			<Value value="15.0"/>
		</DataField>
		<DataField name="dollars" optype="continuous" dataType="integer"/>
		<DataField name="fraud" optype="categorical" dataType="integer">
			<Value value="0"/>
			<Value value="1"/>
		</DataField>
	</DataDictionary>
	<TransformationDictionary>
		<DerivedField name="features[2]" optype="categorical" dataType="integer">
			<MapValues outputColumn="data:output">
				<FieldColumnPair field="merchant" column="data:input"/>
				<InlineTable>
					<row>
						<data:input>2.0</data:input>
						<data:output>0</data:output>
					</row>
					<row>
						<data:input>5.0</data:input>
						<data:output>1</data:output>
					</row>
					<row>
						<data:input>16.0</data:input>
						<data:output>2</data:output>
					</row>
					<row>
						<data:input>45.0</data:input>
						<data:output>3</data:output>
					</row>
					<row>
						<data:input>48.0</data:input>
						<data:output>4</data:output>
					</row>
					<row>
						<data:input>84.0</data:input>
						<data:output>5</data:output>
					</row>
					<row>
						<data:input>96.0</data:input>
						<data:output>6</data:output>
					</row>
					<row>
						<data:input>107.0</data:input>
						<data:output>7</data:output>
					</row>
					<row>
						<data:input>137.0</data:input>
						<data:output>8</data:output>
					</row>
					<row>
						<data:input>141.0</data:input>
						<data:output>9</data:output>
					</row>
					<row>
						<data:input>160.0</data:input>
						<data:output>10</data:output>
					</row>
					<row>
						<data:input>166.0</data:input>
						<data:output>11</data:output>
					</row>
					<row>
						<data:input>205.0</data:input>
						<data:output>12</data:output>
					</row>
					<row>
						<data:input>222.0</data:input>
						<data:output>13</data:output>
					</row>
					<row>
						<data:input>240.0</data:input>
						<data:output>14</data:output>
					</row>
					<row>
						<data:input>270.0</data:input>
						<data:output>15</data:output>
					</row>
					<row>
						<data:input>274.0</data:input>
						<data:output>16</data:output>
					</row>
					<row>
						<data:input>301.0</data:input>
						<data:output>17</data:output>
					</row>
					<row>
						<data:input>303.0</data:input>
						<data:output>18</data:output>
					</row>
					<row>
						<data:input>333.0</data:input>
						<data:output>19</data:output>
					</row>
					<row>
						<data:input>336.0</data:input>
						<data:output>20</data:output>
					</row>
					<row>
						<data:input>345.0</data:input>
						<data:output>21</data:output>
					</row>
					<row>
						<data:input>370.0</data:input>
						<data:output>22</data:output>
					</row>
					<row>
						<data:input>402.0</data:input>
						<data:output>23</data:output>
					</row>
					<row>
						<data:input>546.0</data:input>
						<data:output>24</data:output>
					</row>
					<row>
						<data:input>630.0</data:input>
						<data:output>25</data:output>
					</row>
					<row>
						<data:input>679.0</data:input>
						<data:output>26</data:output>
					</row>
					<row>
						<data:input>714.0</data:input>
						<data:output>27</data:output>
					</row>
					<row>
						<data:input>746.0</data:input>
						<data:output>28</data:output>
					</row>
					<row>
						<data:input>887.0</data:input>
						<data:output>29</data:output>
					</row>
					<row>
						<data:input>930.0</data:input>
						<data:output>30</data:output>
					</row>
					<row>
						<data:input>1011.0</data:input>
						<data:output>31</data:output>
					</row>
					<row>
						<data:input>1138.0</data:input>
						<data:output>32</data:output>
					</row>
					<row>
						<data:input>1353.0</data:input>
						<data:output>33</data:output>
					</row>
					<row>
						<data:input>1462.0</data:input>
						<data:output>34</data:output>
					</row>
					<row>
						<data:input>1720.0</data:input>
						<data:output>35</data:output>
					</row>
					<row>
						<data:input>1728.0</data:input>
						<data:output>36</data:output>
					</row>
					<row>
						<data:input>2471.0</data:input>
						<data:output>37</data:output>
					</row>
					<row>
						<data:input>2516.0</data:input>
						<data:output>38</data:output>
					</row>
					<row>
						<data:input>2620.0</data:input>
						<data:output>39</data:output>
					</row>
					<row>
						<data:input>2669.0</data:input>
						<data:output>40</data:output>
					</row>
					<row>
						<data:input>2742.0</data:input>
						<data:output>41</data:output>
					</row>
					<row>
						<data:input>2811.0</data:input>
						<data:output>42</data:output>
					</row>
					<row>
						<data:input>2934.0</data:input>
						<data:output>43</data:output>
					</row>
					<row>
						<data:input>2952.0</data:input>
						<data:output>44</data:output>
					</row>
					<row>
						<data:input>3059.0</data:input>
						<data:output>45</data:output>
					</row>
					<row>
						<data:input>3469.0</data:input>
						<data:output>46</data:output>
					</row>
					<row>
						<data:input>3485.0</data:input>
						<data:output>47</data:output>
					</row>
					<row>
						<data:input>3659.0</data:input>
						<data:output>48</data:output>
					</row>
					<row>
						<data:input>3843.0</data:input>
						<data:output>49</data:output>
					</row>
				</InlineTable>
			</MapValues>
		</DerivedField>
		<DerivedField name="features[3]" optype="categorical" dataType="integer">
			<MapValues outputColumn="data:output">
				<FieldColumnPair field="category" column="data:input"/>
				<InlineTable>
					<row>
						<data:input>1.0</data:input>
						<data:output>0</data:output>
					</row>
					<row>
						<data:input>2.0</data:input>
						<data:output>1</data:output>
					</row>
					<row>
						<data:input>3.0</data:input>
						<data:output>2</data:output>
					</row>
					<row>
						<data:input>4.0</data:input>
						<data:output>3</data:output>
					</row>
					<row>
						<data:input>5.0</data:input>
						<data:output>4</data:output>
					</row>
					<row>
						<data:input>6.0</data:input>
						<data:output>5</data:output>
					</row>
					<row>
						<data:input>7.0</data:input>
						<data:output>6</data:output>
					</row>
					<row>
						<data:input>8.0</data:input>
						<data:output>7</data:output>
					</row>
					<row>
						<data:input>9.0</data:input>
						<data:output>8</data:output>
					</row>
					<row>
						<data:input>10.0</data:input>
						<data:output>9</data:output>
					</row>
					<row>
						<data:input>11.0</data:input>
						<data:output>10</data:output>
					</row>
					<row>
						<data:input>12.0</data:input>
						<data:output>11</data:output>
					</row>
					<row>
						<data:input>13.0</data:input>
						<data:output>12</data:output>
					</row>
					<row>
						<data:input>14.0</data:input>
						<data:output>13</data:output>
					</row>
					<row>
						<data:input>15.0</data:input>
						<data:output>14</data:output>
					</row>
				</InlineTable>
			</MapValues>
		</DerivedField>
	</TransformationDictionary>
	<MiningModel functionName="classification">
		<MiningSchema>
			<MiningField name="fraud" usageType="target"/>
			<MiningField name="merchant"/>
			<MiningField name="dollars"/>
			<MiningField name="category"/>
		</MiningSchema>
		<Segmentation multipleModelMethod="modelChain">
			<Segment id="1">
				<True/>
				<MiningModel functionName="regression">
					<MiningSchema>
						<MiningField name="merchant"/>
						<MiningField name="dollars"/>
						<MiningField name="category"/>
					</MiningSchema>
					<Output>
						<OutputField name="gbtValue" optype="continuous" dataType="double" feature="predictedValue" isFinalResult="false"/>
						<OutputField name="binarizedGbtValue" optype="continuous" dataType="double" feature="transformedValue" isFinalResult="false">
							<Apply function="if">
								<Apply function="greaterThan">
									<FieldRef field="gbtValue"/>
									<Constant dataType="double">0.0</Constant>
								</Apply>
								<Constant dataType="double">-1.0</Constant>
								<Constant dataType="double">1.0</Constant>
							</Apply>
						</OutputField>
					</Output>
					<Segmentation multipleModelMethod="x-weightedSum">
						<Segment id="1">
							<True/>
							<TreeModel functionName="regression" missingValueStrategy="nullPrediction" noTrueChildStrategy="returnLastPrediction" splitCharacteristic="multiSplit">
								<MiningSchema>
									<MiningField name="dollars"/>
									<MiningField name="merchant"/>
								</MiningSchema>
								<Node score="0.9874182067122838">
									<True/>
									<Node score="-1.0">
										<SimpleSetPredicate field="features[2]" booleanOperator="isIn">
											<Array type="int">0 1 4 5 14 23 24 28 29 32 33 34 36 37 40 42 43 46 47 49</Array>
										</SimpleSetPredicate>
									</Node>
									<Node score="0.9254223320972393">
										<SimpleSetPredicate field="features[2]" booleanOperator="isIn">
											<Array type="int">2 7 9 13 15 44</Array>
										</SimpleSetPredicate>
										<Node score="-0.07303182579564489">
											<SimplePredicate field="dollars" operator="lessOrEqual" value="117.0"/>
										</Node>
									</Node>
									<Node score="0.8293888713579468">
										<SimplePredicate field="dollars" operator="lessOrEqual" value="117.0"/>
									</Node>
								</Node>
							</TreeModel>
						</Segment>
						<Segment id="2" weight="0.1">
							<True/>
							<TreeModel functionName="regression" missingValueStrategy="nullPrediction" noTrueChildStrategy="returnLastPrediction" splitCharacteristic="multiSplit">
								<MiningSchema>
									<MiningField name="dollars"/>
									<MiningField name="merchant"/>
								</MiningSchema>
								<Node score="0.4790034605125961">
									<True/>
									<Node score="-0.4466501918704571">
										<SimpleSetPredicate field="features[2]" booleanOperator="isIn">
											<Array type="int">0 1 4 5 7 9 14 23 24 28 29 32 33 34 36 37 40 42 43 46 47 49</Array>
										</SimpleSetPredicate>
										<Node score="-0.4781332814290388">
											<SimplePredicate field="dollars" operator="lessOrEqual" value="93.0"/>
											<Node score="-1.0717993915713253">
												<SimplePredicate field="features[2]" operator="equal" value="7"/>
											</Node>
										</Node>
										<Node score="0.5737245941308714">
											<SimplePredicate field="features[2]" operator="equal" value="9"/>
										</Node>
									</Node>
									<Node score="0.4636819967144003">
										<SimpleSetPredicate field="features[2]" booleanOperator="isIn">
											<Array type="int">2 8 10 12 15 21 25 27 44</Array>
										</SimpleSetPredicate>
										<Node score="-0.21629645185591037">
											<SimplePredicate field="dollars" operator="lessOrEqual" value="195.0"/>
										</Node>
									</Node>
									<Node score="0.3221656150660744">
										<SimplePredicate field="dollars" operator="lessOrEqual" value="50.0"/>
									</Node>
								</Node>
							</TreeModel>
						</Segment>
						<Segment id="3" weight="0.1">
							<True/>
							<TreeModel functionName="regression" missingValueStrategy="nullPrediction" noTrueChildStrategy="returnLastPrediction" splitCharacteristic="multiSplit">
								<MiningSchema>
									<MiningField name="dollars"/>
									<MiningField name="merchant"/>
									<MiningField name="category"/>
								</MiningSchema>
								<Node score="0.4386063897301809">
									<True/>
									<Node score="0.548172431800189">
										<SimpleSetPredicate field="features[2]" booleanOperator="isIn">
											<Array type="int">0 1 4 5 7 9 14 23 24 28 29 32 33 34 36 37 40 42 43 46 47 49</Array>
										</SimpleSetPredicate>
										<Node score="-0.4380904571383047">
											<SimplePredicate field="dollars" operator="lessOrEqual" value="82.0"/>
											<Node score="-0.5901024472753532">
												<SimpleSetPredicate field="features[2]" booleanOperator="isIn">
													<Array type="int">7 9</Array>
												</SimpleSetPredicate>
											</Node>
										</Node>
										<Node score="-0.4181178474687586">
											<SimpleSetPredicate field="features[3]" booleanOperator="isIn">
												<Array type="int">0 1 3 4 6 7 8 10 11 12 13</Array>
											</SimpleSetPredicate>
										</Node>
									</Node>
									<Node score="0.38321778022018693">
										<SimpleSetPredicate field="features[2]" booleanOperator="isIn">
											<Array type="int">2 8 10 12 15 21 25 27 44</Array>
										</SimpleSetPredicate>
										<Node score="-0.24648772129672902">
											<SimplePredicate field="dollars" operator="lessOrEqual" value="150.0"/>
										</Node>
									</Node>
									<Node score="0.2886182337248347">
										<SimplePredicate field="dollars" operator="lessOrEqual" value="56.0"/>
									</Node>
								</Node>
							</TreeModel>
						</Segment>
						<Segment id="4" weight="0.1">
							<True/>
							<TreeModel functionName="regression" missingValueStrategy="nullPrediction" noTrueChildStrategy="returnLastPrediction" splitCharacteristic="multiSplit">
								<MiningSchema>
									<MiningField name="dollars"/>
									<MiningField name="merchant"/>
								</MiningSchema>
								<Node score="0.40200447788243415">
									<True/>
									<Node score="0.592310518198765">
										<SimpleSetPredicate field="features[2]" booleanOperator="isIn">
											<Array type="int">0 1 4 5 7 9 14 23 24 28 29 32 33 34 36 37 40 42 43 46 47 49</Array>
										</SimpleSetPredicate>
										<Node score="0.24738332083778605">
											<SimplePredicate field="features[2]" operator="equal" value="9"/>
											<Node score="-1.0973051154041378">
												<SimplePredicate field="dollars" operator="lessOrEqual" value="30.0"/>
											</Node>
										</Node>
										<Node score="-0.4066663228182316">
											<SimplePredicate field="dollars" operator="lessOrEqual" value="396.0"/>
										</Node>
									</Node>
									<Node score="0.36972071555466846">
										<SimpleSetPredicate field="features[2]" booleanOperator="isIn">
											<Array type="int">2 8 10 12 15 21 25 27 44</Array>
										</SimpleSetPredicate>
										<Node score="-0.19279599562925637">
											<SimplePredicate field="dollars" operator="lessOrEqual" value="167.0"/>
										</Node>
									</Node>
									<Node score="0.24985733570302787">
										<SimplePredicate field="dollars" operator="lessOrEqual" value="49.0"/>
									</Node>
								</Node>
							</TreeModel>
						</Segment>
						<Segment id="5" weight="0.1">
							<True/>
							<TreeModel functionName="regression" missingValueStrategy="nullPrediction" noTrueChildStrategy="returnLastPrediction" splitCharacteristic="multiSplit">
								<MiningSchema>
									<MiningField name="dollars"/>
									<MiningField name="merchant"/>
								</MiningSchema>
								<Node score="0.3760307972501843">
									<True/>
									<Node score="0.5205596517294411">
										<SimpleSetPredicate field="features[2]" booleanOperator="isIn">
											<Array type="int">0 1 4 5 7 9 14 23 24 28 29 32 33 34 36 37 40 42 43 46 47 49</Array>
										</SimpleSetPredicate>
										<Node score="0.22647015986667635">
											<SimplePredicate field="features[2]" operator="equal" value="9"/>
											<Node score="-0.911972611907434">
												<SimplePredicate field="dollars" operator="lessOrEqual" value="31.0"/>
											</Node>
										</Node>
										<Node score="-0.3779014681138808">
											<SimplePredicate field="dollars" operator="lessOrEqual" value="388.0"/>
										</Node>
									</Node>
									<Node score="0.33530046443053196">
										<SimpleSetPredicate field="features[2]" booleanOperator="isIn">
											<Array type="int">2 3 8 10 12 15 20 21 25 27 44 48</Array>
										</SimpleSetPredicate>
										<Node score="-0.11759176325575613">
											<SimplePredicate field="dollars" operator="lessOrEqual" value="140.0"/>
										</Node>
									</Node>
									<Node score="0.2194362113603652">
										<SimplePredicate field="dollars" operator="lessOrEqual" value="25.0"/>
									</Node>
								</Node>
							</TreeModel>
						</Segment>
					</Segmentation>
				</MiningModel>
			</Segment>
			<Segment id="2">
				<True/>
				<RegressionModel functionName="classification" normalizationMethod="logit">
					<MiningSchema>
						<MiningField name="fraud" usageType="target"/>
						<MiningField name="binarizedGbtValue"/>
					</MiningSchema>
					<Output>
						<OutputField name="pmml(prediction)" optype="categorical" dataType="integer" feature="predictedValue"/>
						<OutputField name="prediction" optype="categorical" dataType="double" feature="transformedValue">
							<MapValues outputColumn="data:output">
								<FieldColumnPair field="pmml(prediction)" column="data:input"/>
								<InlineTable>
									<row>
										<data:input>0</data:input>
										<data:output>0</data:output>
									</row>
									<row>
										<data:input>1</data:input>
										<data:output>1</data:output>
									</row>
								</InlineTable>
							</MapValues>
						</OutputField>
					</Output>
					<RegressionTable intercept="0.0" targetCategory="1">
						<NumericPredictor name="binarizedGbtValue" coefficient="-1000.0"/>
					</RegressionTable>
					<RegressionTable intercept="0.0" targetCategory="0"/>
				</RegressionModel>
			</Segment>
		</Segmentation>
	</MiningModel>
</PMML>
}

}
