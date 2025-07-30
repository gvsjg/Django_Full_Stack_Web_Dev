FROM jenkins/jenkins:lts

USER root

# Install Docker CLI & docker-compose
RUN apt-get update && \
    apt-get install -y docker.io docker-compose && \
    apt-get clean

# Add docker group with matching GID and add Jenkins user to it
RUN groupadd -g 1001 docker || true && \
    usermod -aG docker jenkins

USER jenkins
