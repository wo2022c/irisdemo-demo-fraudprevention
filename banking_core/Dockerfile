FROM intersystemsdc/irisdemo-base-irisdb-community:version-1.9.3

LABEL maintainer="Amir Samary <amir.samary@intersystems.com>"

# Name of the project folder ex.: my-atelier-project
ARG IRIS_PROJECT_FOLDER_NAME=mobilebanking-bankingcore-atelier-project

# Changing to root so we can add the files and then use the chown command to 
# change the permissions to irisowner/irisowner 
USER root

# Adding source code that will be loaded by the installer
ADD  ./${IRIS_PROJECT_FOLDER_NAME}/ $IRIS_APP_SOURCEDIR
RUN chown -R irisowner:irisowner $IRIS_APP_SOURCEDIR

# This file will be loaded into the APP namespace and deleted by the IRISConfig.Installer
# I downloaded this file from Kaggle (https://www.kaggle.com/ntnu-testimon/banksim1)
# I opened it to convert it from CR/LF to LF and compressed it into a tar.gz file
ADD ./banksim_data.tar.gz /tmp/
RUN chown irisowner:irisowner /tmp/training_set.csv

# Now we change back to irisowner so that the RUN command will be run with this user
USER irisowner 

# Running the installer. This will load the source from our project.
RUN /demo/irisdemoinstaller.sh