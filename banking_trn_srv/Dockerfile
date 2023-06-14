FROM intersystemsdc/irisdemo-demo-fraudprevention:datalake-version-1.11.0

FROM intersystemsdc/irisdemo-base-irisint-community:version-1.11.0

LABEL maintainer="Amir Samary <amir.samary@intersystems.com>"

# Name of the project folder ex.: my-atelier-project
ARG IRIS_PROJECT_FOLDER_NAME=mobilebanking-bankingtrnsrv-atelier-project

# Changing to root so we can add the files and then use the chown command to 
# change the permissions to irisowner/irisowner 
USER root

# Let's copy the exported file whitelist.csv from the datalake image into our image
COPY --from=0 /tmp/whitelist.csv /tmp/
RUN chown irisowner:irisowner /tmp/whitelist.csv

# Adding source code that will be loaded by the installer
ADD  ./${IRIS_PROJECT_FOLDER_NAME}/ $IRIS_APP_SOURCEDIR
RUN chown -R irisowner:irisowner $IRIS_APP_SOURCEDIR

ADD ./html/pmml.xml $ISC_PACKAGE_INSTALLDIR/csp/appint/
ADD ./html/PaymentDemo.png $ISC_PACKAGE_INSTALLDIR/csp/appint/
ADD ./html/image-map-resizer/js/imageMapResizer.min.js $ISC_PACKAGE_INSTALLDIR/csp/appint/
ADD ./html/image-map-resizer/js/imageMapResizer.map $ISC_PACKAGE_INSTALLDIR/csp/appint/
RUN chown -R irisowner:irisowner $ISC_PACKAGE_INSTALLDIR/csp/appint/

# Now we change back to irisowner so that the RUN command will be run with this user
USER irisowner 

# Running the installer. This will load the source from our project.
RUN /demo/irisdemoinstaller.sh