pipeline {
    agent any
    options { disableConcurrentBuilds() }
    environment {
        IMAGE_NAME="make-it-cry"
        IMAGE_ADDR="127.0.0.1:5000/${IMAGE_NAME}"
        VERSION_ID="${BUILD_ID}"
    }

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
                docker build -f Dockerfile -t ${IMAGE_NAME}:${VERSION_ID} .
                docker tag ${IMAGE_NAME}:${VERSION_ID} ${IMAGE_ADDR}:${VERSION_ID}
                docker push ${IMAGE_ADDR}:${VERSION_ID}
                docker rmi ${IMAGE_NAME}:${VERSION_ID}
                '''
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh '''
                container_id=`docker ps|grep ${IMAGE_ADDR}|awk '{print $1}'`
                if [ -n "${container_id}" ]; then
                    docker rm -f "${container_id}"
                fi

                old_image=`docker images|grep ${IMAGE_ADDR}`
                if [[ -n $old_image ]]; then
                    old_image_id=`echo ${old_image}|awk '{print $3}'`
                    docker rmi -f ${old_image_id}
                fi

                docker run -d -p 8090:8080 ${IMAGE_ADDR}:${VERSION_ID}
                '''
            }
        }

    }
}