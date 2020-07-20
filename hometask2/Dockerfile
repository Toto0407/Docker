#Stage 1
FROM alpine:latest as build
MAINTAINER Yurii Bakhur "yurabahur@gmail.com"
ENV MAVEN_OPTS "-Xmx1024m"

#Install Git and clone repo
RUN apk add --no-cache bash
RUN apk add bash-completion
RUN apk update && apk add git && git clone -b release/1.0.0 https://github.com/WiseHands/FootGo.git 
#RUN /bin/bash -c apt-get update -y && apt-get install -y git && git clone -b release/1.0.0 https://github.com/WiseHands/FootGo.git
RUN cp /FootGo/src/main/resources/application.properties.example /FootGo/src/main/resources/application.properties
#Install Maven and JDK 
RUN apk add openjdk8 
RUN apk add maven
#Build FootGo app
WORKDIR /FootGo
RUN mvn package

#Stage 2
FROM alpine:latest as prod

#install JDK for start app
RUN apk add openjdk8
RUN mkdir /home/webapp
WORKDIR /home/webapp

#Copy ROOT.war to WORKDIR
COPY --from=build /FootGo/target .
WORKDIR /home/webapp
ENTRYPOINT java -jar ROOT.war
