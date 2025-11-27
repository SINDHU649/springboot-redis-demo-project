pipeline {
    agent any

    environment {
        PROJECT_NAME = 'spring_redis_sak_app'
        DOCKERHUB_USERNAME = 'sindhu2002'
    }
    parameters {
        choice(name: 'ENVIRONMENT', choices: ['dev', 'qa', 'prod'], description: 'Select deployment environment')
        choice(name: 'STATUS', choices: ['run', 'stop', 'remove'], description: 'Select whether to run or stop or remove the Docker container')
    }

    stages {
        stage("check docker is installed or not") {
            steps {
                script {
                    def dockerExists = sh(script: 'which docker', returnStatus: true) == 0
                    if (dockerExists) {
                        echo "Docker is installed."
                    } else {
                        error "Docker is not installed. Please install Docker to proceed."
                    }
                }
            }
        }
        stage('Run Docker Container Dev Env using docker-compose') {
            when {
                allOf {
                    expression { return params.ENVIRONMENT == 'dev' }
                    expression { return params.STATUS == 'run' }
                }
            }
            steps {
                script {
                    echo "Running Docker container Dev Env using docker-compose"
                    sh """
                        sudo docker-compose down
                        sudo docker-compose build --no-cache
                        sudo docker-compose up -d
                    """
                }
            }
        }
        stage('Remove Docker Container Dev Env using docker-compose') {
            when {
                allOf {
                    expression { return params.ENVIRONMENT == 'dev' }
                    expression { return params.STATUS == 'remove' }
                }
            }
            steps {
                script {
                    echo "Stopping Docker container locally using docker-compose"
                    sh "sudo docker-compose down -v"
                    sh "sudo docker system prune -af"
                }
            }
        }
    }
    post {
        always {
            echo "Pipeline completed."
        }
        success {
            echo "Pipeline succeeded."
        }
        failure {
            echo "Pipeline failed."
        }
    }
}