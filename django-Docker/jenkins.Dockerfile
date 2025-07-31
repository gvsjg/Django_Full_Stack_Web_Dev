FROM jenkins/jenkins:lts

USER root

# Install Docker CLI & docker-compose
# Updated Docker installation steps for better compatibility
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common lsb-release && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    chmod a+r /etc/apt/keyrings/docker.gpg && \
    echo \
      "deb [arch=\"$(dpkg --print-architecture)\" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
      \"$(. /etc/os-release && echo "$VERSION_CODENAME")\" stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    apt-get update && \
    # Install docker-ce-cli
    apt-get install -y docker-ce-cli && \
    # Download docker-compose directly as before
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add the docker group if it doesn't exist (important!)
RUN groupadd docker || true

# Add the jenkins user to the docker group
RUN usermod -aG docker jenkins

# Set permissions for the docker.sock inside the container (important for bind mount)
RUN chmod 666 /var/run/docker.sock || true

USER jenkins