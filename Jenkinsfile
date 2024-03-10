pipeline {
    agent any
    environment {
        DOCKERHUB_USERNAME = "domoda" 
        APP_NAME = "devopsgcp"
        IMAGE_TAG = "v1.0.${BUILD_NUMBER}"
        IMAGE_NAME = "${DOCKERHUB_USERNAME}/${APP_NAME}"
    }

    stages {

        stage('echo ') {
            steps {
                echo 'test webhook'
            }
        }
        
        stage('BUILD and run ') {
            steps {
                script {
                    sh "sudo docker build -t ${IMAGE_NAME}:${IMAGE_TAG} /application"
                }
            }
        }

        stage('Push sur dockerhub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub-dss', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "sudo docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                        sh "sudo docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }
    }
}
