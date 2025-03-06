pipeline {
    agent any
    environment {
        // Docker Hub credentials and repo details
        DOCKERHUB_CREDENTIALS_ID = 'Docker_Hub'
        DOCKERHUB_REPO = 'ibudaa/tripcostcalculator'
        DOCKER_IMAGE_TAG = 'latest'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/BudaOP/TripCostCalculator.git'
            }
        }
        stage('Build') {
            steps {
                bat 'mvn clean install'
            }
        }
        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }
        stage('Code Coverage') {
            steps {
                bat 'mvn jacoco:report'
            }
        }
        stage('Publibat Test Results') {
            steps {
                junit '**/target/surefire-reports/*.xml'
            }
        }
        stage('Publibat Coverage Report') {
            steps {
                jacoco()
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKERHUB_REPO}:${DOCKER_IMAGE_TAG}", ".")
                }
            }
        }
        stage('Pubat Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKERHUB_CREDENTIALS_ID) {
                        docker.image("${DOCKERHUB_REPO}:${DOCKER_IMAGE_TAG}").pubat()
                    }
                }
            }
        }
stage('Deploy to Server') {  
    steps {
        script {
            bat '''
            # Stop and remove any existing container
            docker stop tripcostcalculator || true
            docker rm tripcostcalculator || true
            
            # Run the new container on port 8081
            docker run -d --name tripcostcalculator -p 8081:8080 ${DOCKERHUB_REPO}:${DOCKER_IMAGE_TAG}
            '''
        }
    }
}
    }

    post {
        success {
            echo 'Pipeline execution successful!'
        }
        failure {
            echo 'Pipeline failed! Check the logs for details.'
        }
    }
}
