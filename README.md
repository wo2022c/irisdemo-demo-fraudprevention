# Intelligent Interoperability Example with Financial Data

This sample application shows one of the ways IRIS can be used to create a service that:
- Uses Machine Learning to detect suspicious financial transactions. We create the model using Spark/Scala/Zeppelin and export it to PMML to use it inside IRIS
- Calls a CRM to verify if customers are traveling to a place where he/she would not normally do transactions
- Uses business processes and business rules to verify if the transaction should be processed or not
- Calls the back end system to process the transaction
- Store aggregated data about the transactions on a normalized data lake. The data can be used to retrain the ML model
- Shows how applications can be built with IRIS using containers and docker compose

The following image shows the architecture of the solution:

[![Fraud Prevention Example](https://raw.githubusercontent.com/intersystems-community/irisdemo-demo-fraudprevention/master/README.png?raw=true)](https://youtu.be/hsQPiKXJlX8)

You can see a video of this demo on [YouTube](https://youtu.be/hsQPiKXJlX8).

## Normalized Data Lake?
To expose this new service, IRIS still relies on other systems such as the core banking system and the CRM. To interoperate with these systems, IRIS uses business process orchestration, business rules and look up tables (for coding system normalization). 

When the service is operating, clean, normalized data starts to flow through IRIS. Instead of throwing this data away, IRIS can easily store it on a normalized data lake. This data can be used to monitor the business in real time, monitor the ML model performance over time and also to train better ML models.

There is no need to do the ETL (Extract, Transform and Load) all over again. Clean data is the side effect of using IRIS to expose your service!

## POS UI written in Angular

The application brings a POS (point of sale) simulator. It is a simple Angular UI that we can use to swipe our cards and simulate transactions.  

## How to run the application

To just run the application on your PC, make sure you have git and Docker installed on your machine.

You will need to fork or clone this repository to you local machine to get the entire source code. So, go to your git folder and run the following:

```bash
git clone https://github.com/intersystems-community/irisdemo-demo-fraudprevention
cd irisdemo-demo-fraudprevention
docker compose up
```

That should trigger the download of the images that compose this application and it will soon start all the containers. When starting, it is going to show you lots of messages from all the containers that are staring. That is fine. Don't worry.

When it is done, it will just hang there, without returning control to you. That is fine too. Just leave this window open. If you CTRL+C on this window, docker compose will stop all the containers (and stop the application!).

After all the containers have started, open the application landing page on [http://localhost:9092/csp/appint/demo.csp](http://localhost:9092/csp/appint/demo.csp).

Use the username **SuperUser** and the password **sys**. This is just a demo application that is running on your machine, so we are using a default password. The landing page has instructions about how to use the demo application.

### Why do I need to clone/fork the entire repo to run the app?

You don't need all the source code to run the application. But the application relies on a folder structure that allows:
* Zeppelin to store its configuration and log files outside of the containers
* Zeppelin to read/save the notebooks from/to outside of the containers
* Have a shared folder that allows IRIS to read a ML model exported as PMML

It is just easier to clone the repository and get this folder structure "out of the box" instead of having to recreate it.

# Other Resources

Here are some additional resources:
* [YouTube Video of this demo](https://youtu.be/hsQPiKXJlX8)
* An [academic paper](https://www.researchgate.net/publication/265736405_BankSim_A_Bank_Payment_Simulation_for_Fraud_Detection_Research) writen by Edgar Alonzo Lopez-Rojas and Stephan Axelsson about using simulated data for developing fraud detection solutions. It is an interesting read since it will explain why the simulated data they have produced is valid and useful. We are using their data on this demo. It can also be found on [Kaggle](https://www.kaggle.com/ntnu-testimon/banksim1).
* More details on how this application was built can be found [here](Building_the_Demo.md).

# Other demo applications

There are other IRIS demo applications that touch different subjects such as NLP, ML, Integration with AWS services, Twitter services, performance benchmarks etc. Here are some of them:
* [HTAP Demo](https://github.com/intersystems-community/irisdemo-demo-htap) - Hybrid Transaction-Analytical Processing benchmark. See how fast IRIS can insert and query at the same time. You will notice it is up to 20x faster than AWS Aurora!
* [Kafka Retail Banking Demo](https://github.com/intersystems-community/irisdemo-demo-kafka) - Shows how InterSystems IRIS can be used to import AVRO Schemas from a Kafka's schema registry and consume Kafka events from a simulated retail banking application. It shows how InterSystems IRIS can be used to collate the events into a canonical model, apply data transformation and vocabulary normalization and bring people into the process when issues appear. 
* [Twitter Sentiment Analysis](https://github.com/intersystems-community/irisdemo-demo-twittersentiment) - Shows how IRIS can be used to consume Tweets in realtime and use its NLP (natural language processing) and business rules capabilities to evaluate the tweet's sentiment and the metadata to make decisions on when to contact someone to offer support.
* [HL7 Appointments and SMS (text messages) application](https://github.com/intersystems-community/irisdemo-demo-appointmentsms) -  Shows how IRIS for Health can be used to parse HL7 appointment messages to send SMS (text messages) appointment reminders to patients. It also shows real time dashboards based on appointments data stored in a normalized data lake.
* [The Readmission Demo](https://github.com/intersystems-community/irisdemo-demo-readmission) - Patient Readmissions are said to be the "Hello World of Machine Learning" in Healthcare. On this demo, we use this problem to show how IRIS can be used to **safely build and operationalize** ML models for real time predictions and how this can be integrated into a random application. This **IRIS for Health** demo seeks to show how a full solution for this problem can be built.
* [Fraud Prevention](https://github.com/intersystems-community/irisdemo-demo-fraudprevention) - This demo

# Report any Issues

Please, report any issues on the [Issues section](https://github.com/intersystems-community/irisdemo-demo-htap/issues).
