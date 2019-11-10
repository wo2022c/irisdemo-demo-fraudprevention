# Intelligent Interoperability Example with Financial Data

This sample application shows one of the ways IRIS can be used to create a service that:
- Uses Machine Learning to detect suspicious financial transactions. We create the model using Spark/Scala/Zeppelin and export it to PMML to use it inside IRIS
- Calls a CRM to verify if customers are traveling to a place where he/she would not normally do transactions
- Uses business processes and business rules to verify if the transaction should be processed or not
- Calls the back end system to process the transaction
- Store aggregated data about the transactions on a normalized data lake. The data can be used to retrain the ML model
- Shows how applications can be built with IRIS using containers and docker-compose

The following image shows the architecture of the solution:

![Fraud Prevention Example](https://raw.githubusercontent.com/intersystems-community/irisdemo-demo-fraudprevention/master/README.png?raw=true)

## Normalized Data Lake?
To expose this new service, IRIS still relies on other systems such as the core banking system and the CRM. To interoperate with these systems, IRIS uses business process orchestration, business rules and look up tables (for coding system normalization). 

When the service is operating, clean, normalized data starts to flow through IRIS. Instead of throwing this data away, IRIS can easily store it on a normalized data lake. This data can be used to monitor the business in real time, monitor the ML model performance over time and also to train better ML models.

There is no need to do the ETL (Extract, Transform and Load) all over again. Clean data is the side effect of using IRIS to expose your service!

## POS UI written in Angular

The application brings a POS (point of sale) simulator. It is a simple Angular UI that we can use to swipe our cards and simulate transactions.  

## How to run the application

To just run the application on your PC, make sure you have Docker installed on your machine. You can quickly get it up and running with the folloing commands:

```bash
wget https://raw.githubusercontent.com/intersystems-community/irisdemo-demo-fraudprevention/master/docker-compose.yml
docker-compose up
```

You can also clone this repository to you local machine to get the entire source code. You will need git installed and you would need to be on your git folder:

```bash
git clone https://github.com/intersystems-community/irisdemo-demo-fraudprevention
cd irisdemo-demo-fraudprevention
docker-compose up
```

Both techniques should work and should trigger the download of the images that compose this application and it will soon start all the containers. 

When starting, it is going to show you lots of messages from all the containers that are staring. That is fine. Don't worry.

When it is done, it will just hang there, without returning control to you. That is fine too. Just leave this window open. If you CTRL+C on this window, docker compose will stop all the containers (and stop the application!).

After all the containers have started, open the application landing page on [http://localhost:52773/csp/appint/demo.csp](http://localhost:52773/csp/appint/demo.csp).

Use the username **SuperUser** and the password **sys**. This is just a demo application that is running on your machine, so we are using a default password. The landing page has instructions about how to use the demo application.

## Where does the data come from?

The data used on the application comes from an academic work from Edgar Alonzo Lopez-Rojas and Stephan Axelsson. Their [paper](https://www.researchgate.net/publication/265736405_BankSim_A_Bank_Payment_Simulation_for_Fraud_Detection_Research) is an interesting read since it will explain why the simulated data they have produced is valid and useful. It can also be found on [Kaggle](https://www.kaggle.com/ntnu-testimon/banksim1). 

More details on how this application was built can be found [here](Building_the_Demo.md).

# Other demo applications

There are other IRIS demo applications that touch different subjects such as NLP, ML, Integration with AWS services, Twitter services, performance benchmarks etc. Here are some of them:
* [HTAP Demo](https://github.com/intersystems-community/irisdemo-demo-htap) - Hybrid Transaction-Analytical Processing benchmark
* [Twitter Sentiment Analysis](https://github.com/intersystems-community/irisdemo-demo-twittersentiment) - Shows how IRIS can be used to consume Tweets in realtime and use its NLP (natural language processing) and business rules capabilities to evaluate the tweet's sentiment and the metadata to make decisions on when to contact someone to offer support.
* [HL7 Appointments and SMS (text messages) application](https://github.com/intersystems-community/irisdemo-demo-appointmentsms) -  Shows how IRIS for Health can be used to parse HL7 appointment messages to send SMS (text messages) appointment reminders to patients. It also shows real time dashboards based on appointments data stored in a normalized data lake.
* [Fraud Prevention](https://github.com/intersystems-community/irisdemo-demo-fraudprevention) - This demo

# Report any Issues

Please, report any issues on the [Issues section](https://github.com/intersystems-community/irisdemo-demo-htap/issues).
