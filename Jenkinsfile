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
                dir('django-Docker') {
                    sh 'echo Running tests...'
                    sh 'docker-compose run --rm web python manage.py test'
                }
            }
        }

        stage('Build Image') {
            steps {
                dir('django-Docker') {
                    sh 'docker build -t my-django-app .'
                }
            }
        }
    }
}