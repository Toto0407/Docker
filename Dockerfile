FROM ubuntu:18.04
MAINTAINER Yurii Bakhur "yurabahur@gmail.com"


#Install Java and Git and copy repo FootGo
RUN apt-get update && apt-get install -y openjdk-11-jdk && apt-get install -y git && git clone -b release/1.0.0 https://github.com/WiseHands/FootGo.git


#Install MySql and add user
RUN apt-get -y install sudo
RUN apt-get install -y mysql-server 
ADD mysqlscript.sh /FootGo
WORKDIR /FootGo
RUN chmod +x mysqlscript.sh
RUN ./mysqlscript.sh


#Install Maven
RUN apt-get install -y maven
WORKDIR /FootGo
RUN mv pom.xml pom_old.xml
ADD /FootGo/pom.xml /FootGo   
WORKDIR /FootGo
#RUN mvn package


 



