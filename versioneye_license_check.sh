#!/bin/bash 

VERSIONEYE_SERVER=https://www.versioneye.com
API_KEY=<YOUR_SECRET_API_KEY> # Get it from here: https://www.versioneye.com/settings/api
ORGA_NAME=<YOUR_ORGANISATION_NAME>

json=$( curl -F name=upload -F orga_name=${ORGA_NAME} -F upload=@$1 "${VERSIONEYE_SERVER}/api/v2/projects?api_key=${API_KEY}" )

project_id=$(echo $json | jq '.id' | sed 's/"//g' )
violations=$(echo $json | jq '.licenses_red')

echo ""
echo "License violations: $violations"

echo ""
echo "Delete project ${project_id}" 

curl -X DELETE "${VERSIONEYE_SERVER}/api/v2/projects/${project_id}?api_key=${API_KEY}"
