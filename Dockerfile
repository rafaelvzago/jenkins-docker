# Set the base image to Ubuntu
FROM ubuntu:16.04
  
# Set the maintainer
MAINTAINER Rafael Zago
 
# Jenkins user is needed for the ssh access
RUN echo "root:password" | chpasswd
RUN useradd jenkins
RUN echo "jenkins:jenkins" | chpasswd && mkdir /home/jenkins && chown jenkins /home/jenkins
 
# update the yum
RUN apt-get update \
	&& apt-get install -y\
	unzip\
	subversion \
	git\
	openssh-server\
	openjdk-8-jdk\
	wget\
	maven\
 	&& apt-get clean

# Copping and configuring jenkins
ADD jenkins.war /home/jenkins
ENV JENKINS_HOME="/home/jenkins/"
RUN mkdir /home/jenkins/keys-container && chown jenkins.jenkins /home/jenkins/keys-container

USER jenkins
 
WORKDIR /home/jenkins

# expose the ssh port
EXPOSE 8080
 
