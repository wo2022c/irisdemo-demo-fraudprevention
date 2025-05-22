# Use the provided base image.
FROM mcr.microsoft.com/devcontainers/python:1-3.12-bullseye

# Set a working directory.
WORKDIR /workspace

# install odbc
#RUN apt-get update && apt-get install -y unixodbc-dev unixodbc iodbc mlocate tdsodbc  
RUN apt-get update && apt-get install -y curl

COPY mock-transaction/mock-generator/requirements.txt .

COPY mock-transaction/mock-generator/intersystems_irispython-3.2.0-py3-none-any.whl . 

RUN pip3 install --user -r requirements.txt
RUN pip3 install --user intersystems_irispython-3.2.0-py3-none-any.whl

CMD ["sleep", "infinity"]