pipeline {
    agent any
    options { disableConcurrentBuilds() }
    stages {
        stage('Build') {
            steps {
                sh 'chmod u+x mvnw'
                sh './mvnw package'
            }
        }
        stage('Build Image') {
            steps {
                sh '''
                docker build -f Dockerfile -t make-it-cry .
                docker tag make-it-cry:latest 127.0.0.1:5000/make-it-cry:latest
                docker push 127.0.0.1:5000/make-it-cry:latest
                docker rmi make-it-cry:latest
                '''
            }
        }
//         stage('Deploy DEV') {
//             environment {
//                 //change here
//                 SERVER_PORT = "8000"
//                 GROUP_ID = "sample"
//                 //---------------
//
//                 ARTIFACT_ID = "make-it-cry"
//                 VERSION = "1.0-SNAPSHOT"
//             }
//             steps {
//                 sh '''
//                     if [ "$(lsof -t -i:${SERVER_PORT})" ];then
//                         kill -9 $(lsof -t -i:${SERVER_PORT})
//                     fi
//                 '''
//
//                 sh '''
//                     mvn dependency:get \
//                     -DremoteRepositories=http://47.96.237.96:8082/artifactory/libs-snapshot \
//                     -DgroupId=${GROUP_ID} \
//                     -DartifactId=${ARTIFACT_ID} \
//                     -Dversion=${VERSION} \
//                     -Dpackaging=war \
//                     -Dtransitive=false
//
//                     mvn dependency:copy \
//                     -Dartifact=${GROUP_ID}:${ARTIFACT_ID}:${VERSION}:war \
//                     -DoutputDirectory=.
//                 '''
//                 sh 'JENKINS_NODE_COOKIE=dontKillMe nohup java -jar ${ARTIFACT_ID}-${VERSION}.war &'
//             }
//         }
    }
}