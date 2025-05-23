# Structure of the Demo

This demo shows how to combine distinct IRIS services to build a fraud prevention service with intelligent interoperability:

* banking_core - Is a service that reproduces the basic functionality of a core checking account banking system. It is based on IRIS Database and exposes SOAP services to be consumed by the banking_trn_srv service.
  * Management Portal: http://localhost:9090/csp/sys/UtilHome.csp
* banking_trn_srv - Is a service that will receive REST requests from the mobile application and filter them to avoid frauds. If a request is genuine, it will be passsed to the banking_core service to be processed. This is based on IRIS Interoperability. Successful transactions will also be sent to the normalized_datalake service where it will be merged
with data from the banking_crm_srv and banking_crm. In particular, customer complaints about frauds will be used to detect new fraudulent behaviours and andapt our AI model to continue
keeping our customers safe.
  * Management Portal: http://localhost:9092/csp/sys/UtilHome.csp
* banking_crm - This is the bank's CRM system. This is an old system that doesn't have many interoperability capabilities. 
We have requested the CRM vendor to generate us a file with every new customer fraud complaint so we can populate our 
normalized data lake with this information. The normalized data lake can then be used by our data scientists and business analyst to
find new cases of fraud, monitor the business, etc. You won't find this service on the docker compose file. There will only be a 
folder on the shared volume of the banking_crm_srv where we will be putting the files for the complaints.
* banking_crm_srv - This service will be responsible for capturing the stream of files generated by the CRM system
in real time and populate the normalized data lake with the relevant information. A business service will be
observing a remote file system (belonging to the CRM system) and will be capturing any file generated there.
* normalized_datalake - This is where data from several applications on the organization is stored in a normalized, SQL accessible, way. This is based on IRIS Database. We would use sharding for this, but this is a demo so we have restricted it to a single instance. In this demo, we will be consolidating data from the banking core and the CRM systems.
  * Management Portal: http://localhost:9094/csp/sys/UtilHome.csp
* advanced_analytics - This service includes a Zeppelin notebook with a spark cluster, all in a single image. The correct thing to do would be to have an instance/image for Zeppelin and a set of instances/images for the Spark cluster. But as this is a demo, we have combined both on a single image so it won't require a lot of resources. This will be used to explore the data on the normalized data lake using Spark and/or JDBC using Zeppelin.
  * Zeppelin Portal: http://localhost:9096/
  * Spark Master Portal: http://localhost:9097/
  * Zeppelin Portal: http://localhost:9098/

# Baking Core (banking_core)

This service is based on irisdemodb image.

## Preparing the Transactional Data

The file bs140513_032310.csv was dowloaded from [Kaggle][KagglePaySim]

It has 594.644 records (including the header) and weights 46Mb. I took 500K records from it.
This will be pre-loaded into the demo (banking_core and data lake) and will be used to train the model. We will consider it as past data. 

I converted the EOL sequence from CR/LF to LF and used the following commands to split it:

``` shel 
head -n 500001 ././bs140513_032310.csv >> training_set.csv
head -n 1 ././bs140513_032310.csv >> testing_set.csv
tail -n +500002 ./bs140513_032310.csv >> testing_set.csv
wc -l training_set.csv
  500001 training_set.csv
wc -l testing_set.csv
   94644 testing_set.csv
head -n 2 ./training_set.csv
step,customer,age,gender,zipcodeOri,merchant,zipMerchant,category,amount,fraud
0,'C1093826151','4','M','28007','M348934600','28007','es_transportation',4.55,0

head -n 2 ./testing_set.csv
step,customer,age,gender,zipcodeOri,merchant,zipMerchant,category,amount,fraud
154,'C546957379','5','M','28007','M348934600','28007','es_transportation',0.18,0

rm ./bs140513_032310.csv
tar -czf ./banksim_data.tar.gz ./*.csv
rm ./*.csv
```

I have removed bs140513_032310.csv from the Git repository to keep it small. I have also compressed both csv
files into a single tar.gz. This is the file that the Dockerfile will be adding to our images.

The atelier project "bankingcore-atelier-project" in *banking_core* instance has several classes including:
* IRISConfig.Installer - This class is run when the image is built. It will call method *LoadTransactionalData* to load training_set.csv into table IRISDemo.CheckingTrans.
* IRISDemo.CheckingTrans - This is the table that will hold the transactional data. It points to an Account table as well.

## Creating the IRISDemo.CheckingTrans class

There is a very simple mapping between the columns on training_set.csv and the properties on IRISDemo.CheckingTrans.
The property *step* is transformed into a date and time. Each step represent a day so we have to come up with a random
time.

I had also to reverse engineer the age group feature into a random date of birth inside the age group range. 

This class has a class method called CreateTransaction. It is used on two situations:

* It is exposed as a SOAP service to be called by banking_trn_srv when new transactions are coming in.
* It is called by another method on the same class, called LoadFullDataFromCSVFile() to load the training_set.csv file. 
The method LoadFullDataFromCSVFile() is called by method LoadTransactionalData() on class IRISConfig.Installler


[KagglePaySim]: https://www.kaggleclipeclipcom/ntnu-testimon/banksim1

## Exposing the SOAP Service

As this is suposedly a legacy system inside the organization, this service exposes its functionality through SOAP.

The service WSDL is available on:

http://localhost:9090/csp/app/soap//IRISDemo.SOAP.TransactionServices.cls?wsdl=1

The class IRISDemo.SOAP.TransactionServices tries to suggest good practices on handling and reporting errors to the caller.

This service will be callled by the banking_trn_srv service.

We are using the default CSP application for SOAP services created by the base image irisdemoint. It will require basic authentication and the SuperUser/sys password should be used. On real world scenarios, each SOAP service should have its own CSP application, with Permitted Classes configured to limit the application to the class of the service. Also, it should either require SSL or be configured with a SOAP Security Config to require other mechanisms of security such as encryption/signing of the body, header, etc.

# Baking Transactional Services (banking_trn_srv)

This service is based on irisdemoint image. It will expose a REST service on /csp/appint/rest/ CSP application so that a mobile APP can send transactions. These transactions will be evaluated in real time and, if valid, the service will call the SOAP service on the core banking system to process them.

You can look at the production here:

http://localhost:9092/csp/appint/EnsPortal.ProductionConfig.zen?$NAMESPACE=APPINT

## Creating the Banking Core Transaction Operation

This Business Operation was created by using IRIS Interoperability SOAP assistant add-on. It is completely generated based on the WSDL of the service.

I have added it to the production and configured it with the BankingCore credential. This credential is automatically created by our IRISConfig.Installer manifest. After configuring these settings, I went back to Atelier and did a dummy change on my production class just for it to show me a conflict when trying to save my production class. I then chose to keep the *server* version of it so it could be saved outsife of the container and on GitHub.

## Creating the Banking Transaction Service

As this production is based on irisdemoint image, there is a CSP application named /csp/appint/rest that is already configured with the EnsLib.REST.Dispatcher REST dispatcher. Our new BankingSrv.Transaction.Service REST service class will inherit from this class.

This CSP application requires authentication too. So, when calling this REST service, you should use Basic HTTP authentication.

I installed on my Eclipse a Plugin called [http4e](http://www.nextinterfaces.com/http4e-eclipse/eclipse-restful-http-client-plugin-install/). This plugin allows me to send quick test REST calls to my new service. I had to add the following HTTP headers on my REST calls to be correctly authenticated:

``` YAML
Content-Type=application/json; charset=utf-8
Authorization=Basic U3VwZXJVc2VyOnN5cw==
```

The Base64 code above was generated as follows:

```
USER>Write $System.Encryption.Base64Encode("SuperUser:sys")
U3VwZXJVc2VyOnN5cw==
```

# Normalized Data Lake

I copied the entire *banking_core* folder into the *normalized_datalake* folder and did some changes to the data model
so it would contain the relationship between CheckingTransactions and Customer Complaints about those transactions.

The customer gender on the data lake uses a different coding system (from the CRM system) that is 1 for male and 2
for female (instead of M and F). That is just to show a data lookup in action on the banking_trn_srv service.

Communication between the banking_trn_srv and the normalized_datalake will be through JDBC to show yet another adapter 
on banking_trn_srv production.