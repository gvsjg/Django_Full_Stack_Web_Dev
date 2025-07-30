# jenkins.Dockerfile
FROM jenkins/jenkins:lts

USER root

RUN apt-get update && \
    apt-get install -y docker.io docker-compose && \
    usermod -aG docker jenkins

USER jenkins