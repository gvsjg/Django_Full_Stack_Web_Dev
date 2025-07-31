pipeline {
    agent any

    environment {
        IMAGE_NAME = 'gvsjg/Django_Full_Stack_Web_Dev'
    }

    stages {
        stage('Checkout') {
            steps {
                // Change 'main' to 'master' if your repo's primary branch is master
                git branch:'master', url: 'https://github.com/gvsjg/Django_Full_Stack_Web_Dev'
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