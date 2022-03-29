#!/usr/bin/env bash

set -e

shopt -s expand_aliases
alias wget='wget -nv --show-progress --progress=bar:force:noscroll'

function mustBeRoot {
	if [ "$EUID" -ne 0 ]; then
  		echo "Please run as root"
  		exit 1
	fi
}

function installKubectl {
	wget https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl
        mv kubectl /usr/local/bin/kubectl
	chmod +x /usr/local/bin/kubectl
}

function installDocker {
	wget https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz
	tar zxvf docker-${DOCKER_VERSION}.tgz
	mv docker/docker /usr/local/bin/docker
	chmod +x /usr/local/bin/docker
	rm -rf docker-${DOCKER_VERSION}.tgz docker/
}

function installGo {
	wget https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz
	tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz
	echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/bash.bashrc

}

mustBeRoot
for var in "$@"; do
	$var
done

