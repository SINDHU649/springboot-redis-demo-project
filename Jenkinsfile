pipeline {
    agent any

    environment {
        DOCKER_COMPOSE = "docker-compose"
    }

    stages {

        stage('Clean Workspace') {
            steps {
                deleteDir()   // ensures a fresh workspace
            }
        }

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Maven JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
                sh 'ls -al target'   // verify jar exists
            }
        }

        stage('Docker Compose Down (Remove Old Dev Env)') {
            steps {
                dir("${WORKSPACE}") {
                    sh 'echo "Stopping Previous Containers..."'
                    sh "${DOCKER_COMPOSE} down || true"
                }
            }
        }

        stage('Docker Compose Up (Run Dev Environment)') {
            steps {
                dir("${WORKSPACE}") {
                    sh 'echo "Starting New Dev Environment..."'
                    sh "${DOCKER_COMPOSE} up -d --build"
                }
            }
        }

    }

    post {
        failure {
            echo "Pipeline failed! Check logs."
        }
        success {
            echo "Dev Environment started successfully with Docker Compose!"
        }
    }
}
