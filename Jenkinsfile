pipeline {
    agent any
    
    tools {
        nodejs 'node25'
        dockerTool 'docker' 
    }
    

    environment {
        DOCKER_USER = 'samsantech'
        DOCKER_REPO  = 'cicd.epam'
        DOCKER_HUB_CREDS = credentials('docker-hub-token')
    }
    
    stages {
        stage('Git Checkout') {
            steps { checkout scm }
        }
        stage('Application Build') {
            steps {
                sh 'chmod +x scripts/build.sh'
                sh './scripts/build.sh'
            }
        }
        stage('Tests') {
            steps {
                sh 'chmod +x scripts/test.sh'
                sh './scripts/test.sh'
            }
        }
        stage('Docker Image Build') {
            steps {
                sh "docker build -t ${DOCKER_USER}/${DOCKER_REPO}:${env.BUILD_NUMBER} ."
            }
        }
        stage('Docker Image Push') {
            steps {
                sh "echo ${DOCKER_HUB_CREDS} | docker login -u ${DOCKER_USER} --password-stdin"
                sh "docker push ${DOCKER_USER}/${DOCKER_REPO}:${env.BUILD_NUMBER}"
            }
        }
    }
}
