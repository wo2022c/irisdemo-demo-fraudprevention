FROM intersystemsdc/irisdemo-base-irisdb-community:version-1.8.1

LABEL maintainer="Amir Samary <amir.samary@intersystems.com>"

# Name of the project folder ex.: my-atelier-project
ARG IRIS_PROJECT_FOLDER_NAME=mobilebanking-datalake-atelier-project

# Adding source code that will be loaded by the installer
ADD --chown=irisowner:irisuser ./${IRIS_PROJECT_FOLDER_NAME}/ $IRIS_APP_SOURCEDIR

# This file will be loaded into the APP namespace and deleted by the IRISConfig.Installer
# I downloaded this file from Kaggle (https://www.kaggle.com/ntnu-testimon/banksim1)
# I opened it to convert it from CR/LF to LF and compressed it into a tar.gz file
ADD --chown=irisowner:irisuser ./banksim_data.tar.gz /tmp/

# IRIS Global buffers and Routine Buffers
# ENV IRIS_GLOBAL_BUFFERS=256
# ENV IRIS_ROUTINE_BUFFERS=64

# Running the installer. This will load the source from our project.
RUN /usr/irissys/demo/irisdemoinstaller.sh 

USER root
RUN rm /tmp/testing_set.csv && \
    rm /tmp/training_set.csv

USER irisowner