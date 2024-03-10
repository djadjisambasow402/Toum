pipeline {
    agent any
    environment {
        DOCKERHUB_USERNAME = "domoda" 
        APP_NAME = "cd-projet"
        IMAGE_TAG = "v1.0.${BUILD_NUMBER}"
        IMAGE_NAME = "${DOCKERHUB_USERNAME}/${APP_NAME}"
        DEPLOYMENT_FILE = "deploiement.yaml"
        TEMPLATE_FILE = "/opt/template/html.tpl"
        DEPLOYMENT_FOLDER= "/var/lib/jenkins/deploiement"
    }
    //tools {
      //  maven 'maven3'
    //}
    // CI Pipline
    stages {
        stage('echo et teste unitaire') {
                stage('version') {
                    steps {
                        echo 'test'
                    }
                }
   
        }
    }
}
