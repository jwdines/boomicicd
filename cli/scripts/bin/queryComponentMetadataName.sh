#!/bin/bash
source bin/common.sh

unset _saveComponentId _saveComponentType _saveComponentName _saveComponentVersion exportVariable
# mandatory arguments
OPT_ARGUMENTS=(componentType componentName deleted currentVersion)
ARGUMENTS=()
inputs "$@"

if [ "$?" -gt "0" ]
then
   return 255;
fi

if [ -z "${componentName}" ]
then
  export ERROR_MESSAGE="ComponentName must be used to query componentMetadata"
  export ERROR=255
  return ${ERROR}
else
	unset ERROR_MESSAGE ERROR
fi
   
# set defaults
if [ -z "${currentVersion}" ] 
then
	export currentVersion="true"
fi

if [ -z "${deleted}" ] 
then
	export deleted="false"
fi

ARGUMENTS=(componentName componentType deleted currentVersion)
JSON_FILE=json/queryComponentMetadataComponentName

JSON_FILE="${JSON_FILE}.json"
URL=$baseURL/ComponentMetadata/query
createJSON

callAPI

extract result[0].componentId _saveComponentId
extract result[0].name _saveComponentName
extract result[0].version _saveComponentVersion
extract result[0].type _saveComponentType

clean

if [ "$ERROR" -gt "0" ]
then
   return 255;
fi

export componentId="${_saveComponentId}"
export componentType="${_saveComponentType}"
export componentName="${_saveComponentName}"
export componentVersion="${_saveComponentVersion}"
unset _saveComponentId _saveComponentType _saveComponentName _saveComponentVersion
