pipeline {
    agent any

    environment {
        IMAGE_NAME = 'gvsjg/Django_Full_Stack_Web_Dev'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch:'master', url: 'https://github.com/gvsjg/Django_Full_Stack_Web_Dev'
            }
        }

        stage('Prepare Docker Socket Permissions') { // <<< THIS STAGE IS CRITICAL NOW
            steps {
                // This command will run inside the Jenkins container
                // It makes the docker.sock globally writable for this pipeline execution
                sh 'sudo chmod 666 /var/run/docker.sock || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME}:latest ."
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh """
                    echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin
                    docker push ${IMAGE_NAME}:latest
                    docker logout
                    """
                }
            }
        }
    }
    post {
        failure {
            echo '❌ Build failed!'
        }
        success {
            echo '✅ Build successful!'
        }
    }
}