pipeline {
    agent any
    options { disableConcurrentBuilds() }
    stages {
        stage('Build') {
            steps {
                sh 'mvn package'
            }
        }
        stage('Publish') {
            steps {
                sh 'mvn deploy'
            }
        }
        stage('Deploy DEV') {
            environment {
                //change here
                SERVER_PORT = "8000"
                GROUP_ID = "sample"
                //---------------

                ARTIFACT_ID = "make-it-cry"
                VERSION = "1.0-SNAPSHOT"
            }
            steps {
                sh '''
                    if [ "$(lsof -t -i:${SERVER_PORT})" ];then
                        kill -9 $(lsof -t -i:${SERVER_PORT})
                    fi
                '''

                sh '''
                    mvn dependency:get \
                    -DremoteRepositories=http://47.96.237.96:8082/artifactory/libs-snapshot \
                    -DgroupId=${GROUP_ID} \
                    -DartifactId=${ARTIFACT_ID} \
                    -Dversion=${VERSION} \
                    -Dpackaging=war \
                    -Dtransitive=false

                    mvn dependency:copy \
                    -Dartifact=${GROUP_ID}:${ARTIFACT_ID}:${VERSION}:war \
                    -DoutputDirectory=.
                '''
                sh 'JENKINS_NODE_COOKIE=dontKillMe nohup java -jar ${ARTIFACT_ID}-${VERSION}.war &'
            }
        }
    }
}