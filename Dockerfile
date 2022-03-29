# docker build -t vscode:3.6.2 .

FROM linuxserver/code-server:version-v3.6.2

ENV USERNAME=abc

USER root

RUN apt update && \
    apt -y install wget make gcc iputils-ping && \
    mkdir -p /home/${USERNAME} && \
    usermod --shell /bin/bash ${USERNAME} && \
    echo "alias ll='ls -ltrah --color'" >> /home/${USERNAME}/.bashrc

COPY binaryInstallers.sh /

ENV KUBECTL_VERSION=1.19.0
ENV DOCKER_VERSION=19.03.9
ENV GO_VERSION=1.15.4

RUN /binaryInstallers.sh installKubectl installDocker installGo
