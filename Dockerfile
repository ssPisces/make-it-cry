FROM openjdk:8u222-jdk-slim

# RUN mkdir /app

COPY target/make-it-cry-1.0-SNAPSHOT.war /opt/app/make-it-cry.war

EXPOSE  8080

WORKDIR /opt/app
CMD java -jar make-it-cry.war
