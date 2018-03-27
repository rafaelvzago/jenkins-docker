# Set the base image to Ubuntu
FROM ubuntu:16.04
  
# Set the maintainer
MAINTAINER Rafael Zago
 
# Jenkins user is needed for the ssh access
RUN echo "root:password" | chpasswd
RUN useradd jenkins
RUN echo "jenkins:jenkins" | chpasswd && mkdir -p /home/jenkins/jenkins_home && chown -R jenkins /home/jenkins
 
# update the yum
RUN apt-get update \
	&& apt-get install -y\
	unzip\
	subversion \
	git\
	openjdk-8-jdk\
	wget\
	maven\
    curl\
    software-properties-common\
 	&& apt-get clean

# Copping and configuring jenkins
RUN wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war -P /home/jenkins
ENV JENKINS_HOME="/home/jenkins/jenkins_home"

USER jenkins
 
WORKDIR /home/jenkins/

# expose the web port
EXPOSE 8080