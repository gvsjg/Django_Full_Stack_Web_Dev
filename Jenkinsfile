pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Test') {
            steps {
                sh 'echo Running tests...'
                sh 'docker-compose run --rm web python manage.py test'
            }
        }

        stage('Build Image') {
            steps {
                sh 'docker-compose build'
            }
        }
    }
}