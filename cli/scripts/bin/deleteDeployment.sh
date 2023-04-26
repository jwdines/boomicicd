#!/bin/bash
source bin/common.sh

# get atom id of the by atom name
# mandatory arguments
ARGUMENTS=(env componentName componentType packageVersion)
OPT_ARGUMENTS=(extractComponentXmlFolder tag)

inputs "$@"
if [ "$?" -gt "0" ]
then
        return 255;
fi

savePackageVersion=${packageVersion}

source bin/queryEnvironment.sh env="$env" classification="*"
saveEnvId=${envId}

source bin/queryComponentMetadataName.sh componentName=${componentName} componentType=${componentType} 

source bin/queryPackagedComponent.sh componentId=${componentId} componentType=${componentType} packageVersion=${packageVersion}

#source bin/queryDeployedComponent.sh envId=${envId} componentId=${componentId}

source bin/queryDeployedPackageActive.sh packageId=${packageId} envId=${saveEnvId} version=${savePackageVersion} active="true"

echov "deploymentId=${deploymentId}"

source bin/deleteDeployedPackage.sh deploymentID=${deploymentID}

if [ "$ERROR" -gt "0" ]
then
  return 255;
fi

clean
