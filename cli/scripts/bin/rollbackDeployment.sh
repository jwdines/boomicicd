#!/bin/bash
source bin/common.sh

# get atom id of the by atom name
# mandatory arguments
ARGUMENTS=(env componentName componentType currentPackageVersion targetPackageVersion listenerStatus)

inputs "$@"
if [ "$?" -gt "0" ]
then
        return 255;
fi

source bin/queryEnvironment.sh env="$env" classification="*"
saveEnvId=${envId}

source bin/queryComponentMetadataName.sh componentName=${componentName} componentType=${componentType}

source bin/queryPackagedComponent.sh componentId=${componentId} componentType=${componentType} packageVersion=${currentPackageVersion}

source bin/queryDeployedPackageActive.sh packageId=${packageId} envId=${saveEnvId} version=${savePackageVersion} active="true"

echov "deploymentId=${deploymentId}"

if [ ${deploymentId} != null ] && [ ! -z ${deploymentId} ] && [ "null" != ${deploymentId} ]
then
	packageId=""
	componentID=""
	componentId=""
	componentType=""
	deploymentId=""

	source bin/deployPackage.sh env=${env} processName=${componentName} packageVersion=${targetPackageVersion} notes="Rollback to version ${targetPackageVersion}" listenerStatus=${listenerStatus}
else
	echoi "Package and version is not currently deployed.  Rollback invalid."
fi

if [ "$ERROR" -gt "0" ]
then
    return 255;
fi

clean
