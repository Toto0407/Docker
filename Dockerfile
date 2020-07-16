FROM ubuntu:18.04
MAINTAINER Yurii Bakhur "yurabahur@gmail.com"
ENV MAVEN_OPTS "-Xmx1024m"

#Install Git and clone repo
RUN apt-get update -y && apt-get install -y git && git clone -b release/1.0.0 https://github.com/WiseHands/FootGo.git
RUN apt-get install -y openjdk-8-jdk

#Install MySql and add user
RUN apt-get -y install sudo

#RUN apt-get install -y mysql-server 
ADD mysqlscript.sh /FootGo
WORKDIR /FootGo
RUN chmod +x mysqlscript.sh
RUN ./mysqlscript.sh 

#Install Maven and build app
RUN apt-get install -y maven   
WORKDIR /FootGo
RUN mvn package

#Open port and start app
EXPOSE 8080
WORKDIR /FootGo/target
ENTRYPOINT service mysql start && java -jar ROOT.war




