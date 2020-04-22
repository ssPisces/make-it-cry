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
//                 docker build -f Dockerfile -t make-it-cry .
                docker build -f Dockerfile -t ${IMAGE_NAME}:${VERSION_ID} .
                new_image_id=`docker images|grep ${IMAGE_NAME}|grep ${VERSION_ID}|awk '{print $3}'`
                docker tag ${new_image_id} ${IMAGE_ADDR}:${VERSION_ID}
                docker push ${IMAGE_ADDR}:${VERSION_ID}
                docker rmi ${new_image_id}

//                 docker tag make-it-cry:latest 127.0.0.1:5000/make-it-cry:latest
//                 docker push 127.0.0.1:5000/make-it-cry:latest
//                 docker rmi make-it-cry:latest
                '''
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
                sh '''
                container_id=`docker ps|grep ${IMAGE_ADDR}:${VERSION_ID}|awk '{print $1}'`
                if [ -n "${container_id}" ]; then
                    docker rm -f "${container_id}"
                fi

                old_image=`docker images|grep ${IMAGE_ADDR}|grep ${VERSION_ID}`
                if [[ -n $old_image ]]; then
                    old_image_id=`echo ${old_image}|awk '{print $3}'`
                    docker rmi -f ${old_image_id}
                fi

                docker run -d -p 8090:8080 ${IMAGE_ADDR}:${VERSION_ID}
//                 docker run -d -p 8090:8080 127.0.0.1:5000/make-it-cry:latest
                '''
            }
        }

    }
}