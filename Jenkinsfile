pipeline {
    agent any
    options { disableConcurrentBuilds() }
    stages {
        stage('Build') {
            steps {
                sh './mvnw package'
            }
        }
        stage('Publish') {
            steps {
                sh './mvnw deploy'
            }
        }
        stage('Deploy DEV') {
            steps {
                sh 'mkdir wangshuai'
                dir('wangshuai') {
                    sh 'kill -9 $(lsof -t -i:8000)'
                    sh 'curl -O http://47.96.237.96:8082/artifactory/libs-release/sample/make-it-cry/1.0/make-it-cry-1.0-SNAPSHOT.war'
                    sh 'SERVER_PORT=8000 java -jar make-it-cry.war'
                }
            }
        }
    }
}