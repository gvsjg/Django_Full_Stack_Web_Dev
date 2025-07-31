FROM jenkins/jenkins:lts

USER root

# Install Docker CLI & docker-compose
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common lsb-release && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo \
      "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      \"$(. /etc/os-release && echo "$VERSION_CODENAME")\" stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add the docker group with the exact GID 1001, if it doesn't exist already.
# Or, modify it to 1001 if it exists with a different GID.
RUN groupadd -g 1001 docker || groupmod -g 1001 docker || true

# Add the jenkins user to the docker group
RUN usermod -aG docker jenkins

# Set permissions for the docker.sock inside the container
RUN chmod 666 /var/run/docker.sock || true

USER jenkins