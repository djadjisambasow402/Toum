pipeline {
    agent any
    environment {
        DOCKERHUB_USERNAME = "domoda" 
        APP_NAME = "devopsgcp"
        IMAGE_TAG = "v1.0.${BUILD_NUMBER}"
        IMAGE_NAME = "${DOCKERHUB_USERNAME}/${APP_NAME}"
        DEPLOYMENT_FILE = "deploiement.yaml"
        DEPLOYMENT_FOLDER= "/var/lib/jenkins/workspace/devops1"
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
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} application/."
                }
            }
        }

        stage('Push sur dockerhub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'dockerhub', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                        sh "docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD"
                        sh "docker push ${IMAGE_NAME}:${IMAGE_TAG}"
                    }
                }
            }
        }
        stage('deploiement ') {
            steps {
                script {   
                    dir("${DEPLOYMENT_FOLDER}/deploiement"){
                      sh "cat ${DEPLOYMENT_FILE}"
                      sh "sed -i 's/${APP_NAME}.*/${APP_NAME}:${IMAGE_TAG}/g' ${DEPLOYMENT_FILE}"
                      sh "cat ${DEPLOYMENT_FILE}"
                    }                    
                    sshagent(['ssh-agent']) {
                    sh 'ssh -o StrictHostKeyChecking=no diadji402@10.128.0.14 cd /home/diadji402'
                    sh "scp ${DEPLOYMENT_FOLDER}/deploiement/* diadji402@10.128.0.14:/home/diadji402"
                   // ansiblePlaybook become: true, installation: 'ansible', inventory: 'ansible/host', playbook: 'ansible/playbook.yaml'
                    //ansiblePlaybook become: true, becomeUser: 'diadji402', credentialsId: 'ssh-agent', installation: 'ansible', inventory: 'ansible/host', playbook: 'ansible/playbook.yaml' 
                }
            }
        }
        
        }
        stage('test') {
          steps {
            withCredentials([file(credentialsId: 'gke', variable: 'GCLOUD_CREDS')]) {
              sh '''
                gcloud version
                gcloud auth activate-service-account --key-file="$GCLOUD_CREDS"
                gcloud container clusters get-credentials k8s-cluster --zone us-central1-c --project terraform-project-411319
              '''
            }
          }
        }
    }
}
