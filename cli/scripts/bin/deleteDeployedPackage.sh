#!/bin/bash

source bin/common.sh 
# Query processattachment id before creating it
echov "$@"


# mandatory arguments
ARGUMENTS=(deploymentId)
JSON_FILE=json/deleteDeployedPackage.json
URL=$baseURL/DeployedPackage/${deploymentId}
id=deploymentId
inputs "$@"
if [ "$?" -gt "0" ]
then
        return 255;
fi
 
deleteAPI

clean
if [ "$ERROR" -gt "0" ]
then
   return 255;
fi
