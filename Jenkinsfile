pipeline {
    agent any
    options { disableConcurrentBuilds() }
    stages {
        stage('Test') {
            steps {
                sh './mvnw clean test'
            }
        }
        stage('Build Image') {
            steps {
                sh '''
                ./mvnw package
                docker build -f Dockerfile -t make-it-cry .
                docker tag make-it-cry:latest 127.0.0.1:5000/make-it-cry:latest
                docker push 127.0.0.1:5000/make-it-cry:latest
                docker rmi make-it-cry:latest
                '''
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh '''
                docker run -d -p 8090:8090 127.0.0.1:5000/make-it-cry:latest
                '''
            }
        }

    }
}