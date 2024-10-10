pipeline {
    agent any

    environment {
        // Replace these with your Azure details
        // AZURE_APP_NAME = 'rgp-react-devx'             // Azure Web App Name
        // AZURE_RG = 'dev-ex-rg'                         // Azure Resource Group Name
        // AZURE_PLAN = 'ASP-gdsclouddevopspoc-8a56' // Azure App Service Plan Name
        // AZURE_REGION = 'eastus'                        // Azure region
        ACR_NAME = 'devexacr02.azurecr.io'            // Azure Container Registry Name
        IMAGE_NAME = 'rgp-book-app-react'               // Docker image name
        IMAGE_TAG = 'latest'                           // Docker image tag (e.g., latest)
        AZURE_APP_NAME = 'TestAppV3'
        AZURE_RG = 'devex-TestAppV3-rg'
        // Jenkins credentials (Azure Service Principal and ACR)
        CLIENT_ID = credentials('azure-client-id') // Service Principal ID
        CLIENT_SECRET = credentials('azure-client-secret') // Service Principal Password
        TENANT_ID = credentials('azure-tenant-id')     // Azure Tenant ID  
        ACR_CREDENTIALS = credentials('acr-sp-credentials')   // ACR Service Principal Username and Password
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout your code from the repository
                // git branch: 'feat/jenkins-cicd', url: 'https://github.com/IN010133303_EYGS/react-webapp-jenkins.git'
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image
                    sh """
                    docker build -t $ACR_NAME/reat-app/$IMAGE_NAME:$IMAGE_TAG .
                    """
                }
            }
        }

        stage('Push to Azure Container Registry') {
            steps {
                script {
                    // Login to Azure Container Registry (ACR)
                    sh """
                    az acr login --name $ACR_NAME \
                    --username $ACR_CREDENTIALS_USR \
                    --password $ACR_CREDENTIALS_PSW
                    """

                    // Push the Docker image to ACR
                    sh """
                    docker push $ACR_NAME/reat-app/$IMAGE_NAME:$IMAGE_TAG
                    """
                }
            }
        }


        stage('Deploy to Azure Web App') {
            steps {
                script {
                    // Login to Azure using Service Principal
                               sh 'az login --service-principal -u $CLIENT_ID -p $CLIENT_SECRET -t $TENANT_ID'
 

                    // Ensure the Web App exists, or create it if necessary
                    // sh '''
                    // az webapp create --resource-group $AZURE_RG --plan $AZURE_PLAN --name $AZURE_APP_NAME \
                    // --deployment-container-image-name $ACR_NAME/reat-app/$IMAGE_NAME:$IMAGE_TAG
                    // '''

                    // Configure Web App to pull the image from ACR
                    withCredentials([usernamePassword(credentialsId: 'acr-sp-credentials', passwordVariable: 'ACR_PASSWORD', usernameVariable: 'ACR_USERNAME')]) {
                        sh '''
                        az webapp config container set --name $AZURE_APP_NAME --resource-group $AZURE_RG \
                        --docker-custom-image-name $ACR_NAME/reat-app/$IMAGE_NAME:$IMAGE_TAG \
                        --docker-registry-server-url https://$ACR_NAME \
                        --docker-registry-server-user $ACR_USERNAME --docker-registry-server-password $ACR_PASSWORD
                        '''
                    }
                }
            }
        }
}


    post {
        always {
            script {
                // Clean up workspace - Ensure this is inside a node block
                node {
                    cleanWs()
                }
            }
        }
    }
}
