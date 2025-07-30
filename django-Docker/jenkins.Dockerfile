FROM jenkins/jenkins:lts

USER root

# Install Docker CLI & docker-compose
# Changed to install docker-ce-cli as recommended, and curl for docker-compose download
# This is generally more reliable than `docker.io` from apt repos
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce-cli && \
    curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add the jenkins user to the existing 'docker' group (created by docker-ce-cli installation if needed)
# Or, if the group doesn't exist, this will add it
# Crucially, we don't assume a GID here, letting the system manage it
RUN usermod -aG docker jenkins

# Set permissions for the docker.sock inside the container
# This is the key change to address the PermissionError on the socket
# It ensures the 'docker' group (which jenkins user is now part of) has write access
# to the mounted socket, assuming the host's Docker socket is group-writable.
RUN chmod 666 /var/run/docker.sock || true

USER jenkins
