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

        stage('echo ') {
            steps {
                echo 'test webhook'
            }
        }
        
        stage('BUILD and run ') {
            steps {
                script {
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ."
                }
            }
        }

        stage('Push sur dockerhub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-dss', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                        sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }
    }
}
