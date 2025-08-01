pipeline {
    agent any

    environment {
        IMAGE_NAME = 'gvsjg/django-full-stack-web-dev'
    }

    stages {
        // REMOVE THIS ENTIRE STAGE!
        /*
        stage('Checkout') {
            steps {
                git branch:'master', url: 'https://github.com/gvsjg/Django_Full_Stack_Web_Dev'
            }
        }
        */

        stage('Prepare Docker Socket Permissions') {
            steps {
                // This command will now execute as root inside the container
                // and should succeed in setting permissions.
                sh 'chmod 666 /var/run/docker.sock || true'
            }
        }

        stage('Build Docker Image') {
            steps {
                // CHANGE THIS LINE: Add the folder path before the dot
                sh "docker build -t ${IMAGE_NAME}:latest ./django-Docker"
                // The `./django-Docker` here means:
                // 1. Set the build context to the 'django-Docker' folder.
                // 2. Look for a Dockerfile (named 'Dockerfile') inside that context.
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