#!/bin/bash

webAppName='TestAppV3'
resourceGroupName='devex-TestAppV3-rg'
appName='TestAppV3'
location="eastus"
az login --service-principal -u $CID -p $CSECRET --tenant $TID
appInsights=$(az monitor app-insights component create --app $appName --location ${location} --resource-group $resourceGroupName --application-type web --query instrumentationKey -o tsv)
appInsightsConnection=$(az monitor app-insights component show --app $appName --resource-group $resourceGroupName --query connectionString -o tsv)
echo "Application Insights resource created with Instrumentation Key: $appInsights"
# Link Application Insights to the Web App
echo "Linking Application Insights to Web App..."
az webapp config appsettings set \
  --name $webAppName \
  --resource-group $resourceGroupName \
  --settings APPINSIGHTS_INSTRUMENTATIONKEY=$appInsights APPINSIGHTS_PROFILERFEATURE_VERSION=1.0.0 APPINSIGHTS_SNAPSHOTFEATURE_VERSION=1.0.0 APPLICATIONINSIGHTS_CONNECTION_STRING=$appInsightsConnection ApplicationInsightsAgent_EXTENSION_VERSION=~2
