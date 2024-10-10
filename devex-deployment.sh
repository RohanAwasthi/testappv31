#!/bin/bash

repo_name=$(git config --get remote.origin.url | sed 's/.*\///;s/.git$//')

az login --service-principal -u $CID -p $CSECRET --tenant $TID

terraform init
curl -X POST -H 'Content-Type: application/json' -d "{\"trackId\": \"$repo_name\", \"status\": \"InProgress\"}"  ${COPILOTAPI}/api/v2/updatestatus
terraform plan
terraform apply -auto-approve
curl -X POST -H 'Content-Type: application/json' -d "{\"trackId\": \"$repo_name\", \"status\": \"Success\"}"  ${COPILOTAPI}/api/v2/updatestatus
