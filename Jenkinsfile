pipeline {
    agent any
    options { disableConcurrentBuilds() }
    environment {
        IMAGE_NAME="make-it-cry-wang"
        PORT="8091"
        IMAGE_ADDR="127.0.0.1:5000/${IMAGE_NAME}"
        VERSION_ID="${BUILD_ID}"
    }

    stages {
        stage('Run Test') {
            steps {
                sh 'chmod u+x mvnw'
                sh './mvnw clean test'
            }
        }
        stage('Build Image') {
            steps {
                sh '''
                ./mvnw package
                docker build -f Dockerfile -t ${IMAGE_NAME}:${VERSION_ID} .
                docker tag ${IMAGE_NAME}:${VERSION_ID} ${IMAGE_ADDR}:${VERSION_ID}
                docker push ${IMAGE_ADDR}:${VERSION_ID}
                docker rmi ${IMAGE_NAME}:${VERSION_ID}
                '''
            }
        }
        stage('Develop') {
            steps {
                echo 'Deploying....'
                sh '''
                container_id=`docker ps|grep ${IMAGE_ADDR}|awk '{print $1}'`
                if [ -n "${container_id}" ]; then
                    docker rm -f "${container_id}"
                fi

                docker run -d -p ${PORT}:8080 ${IMAGE_ADDR}:${VERSION_ID}
                '''
            }
        }
        stage('Test') {
            steps {
                echo 'Test'
            }
        }
        stage('UAT') {
            steps {
                echo 'UAT'
            }
        }
        stage('PROD') {
            steps {
                echo 'PROD'
            }
        }

    }
}