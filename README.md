## Intelligent Interoperability Example with Financial Data

This demos seeks to show how IRIS can be used on different scenarios:
* Intelligente Interoperability - IRIS is the service gateway that will receive banking transactions,
evaluate it with business rules and AI (PMML) for frauds, and route it to the banking core system or
decline them.
* Normalized Data Lake - IRIS can hold data from different systems in the organization, building a normalized 
data model that can be kept on-line with the business. This opens many possibilites of innovation and it differs from the traditional data lake because data from one system is not simply thrown at it. It is stored and normalized with data form other systems on the organization so that is is immediately useful for reporting, business intelligence, building new innovative applications that can make use of the data and using as the single source of truth for tranining and improving machine learning models with Spark.
* Operational Database - IRIS can be the database of web applications built with modern web libraries and frameworks such as REACT and Angular.

The demo simulates a Bank that is receiveing money transfers transactinos from its Internet Banking application and some of the processes and workflows inside the bank to process these transactions with the required traceability, connecting with the back end systems while detecting frauds with Artificial Intelligente (Intelligent Interoperability). The demo shows how to train the AI model with Spark and Zeppelin notebook, how to export the model as PMML and put it to use on a Business Process. How to use REST, SOAP and JDBC connectors, and many other things.

The data used on the demo comes from an academic work from Edgar Alonzo Lopez-Rojas and Stephan Axelsson. If you are doing this demo, their [paper](https://www.researchgate.net/publication/265736405_BankSim_A_Bank_Payment_Simulation_for_Fraud_Detection_Research) is an interesting read since it will explain why the simulated data they have produced is valid and useful. It can also be found on [Kaggle](https://www.kaggle.com/ntnu-testimon/banksim1). 

Details on how this demo was built can be found [here](Building_the_Demo.md).
