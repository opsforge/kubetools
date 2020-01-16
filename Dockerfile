FROM ubuntu:18.04

ENV KCTL="latest"
ENV PKS="1.6.1b20-packed"
ENV BOSH="6.1.1"
ENV CF="latest"
ENV FLY="latest"

MAINTAINER opsforge.io
LABEL type="thin"

# OS fixes and additions

USER root

# Ubuntu package installs

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install git curl telnet dnsutils jq -y && \
    apt-get clean && \
    mkdir -p /tmp

# Install KubeCTL

RUN cd /tmp && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl
    
# Install CF CLI using pivotal method

RUN cd /tmp && \
    curl -L -o cf.deb "https://cli.run.pivotal.io/stable?release=debian64&source=github" && \
    dpkg -i cf.deb && \
    rm -rf /tmp/*

# Install BOSH cli

RUN cd /tmp && \
    curl -LO https://s3.amazonaws.com/bosh-cli-artifacts/bosh-cli-${BOSHVER}-linux-amd64 && \
    chmod +x bosh-cli-${BOSHVER}-linux-amd64 && \
    mv bosh-cli-${BOSHVER}-linux-amd64 /usr/local/bin/bosh

# Install FLY CLI

RUN cd /tmp && \
    curl -LO https://github.com/concourse/concourse/releases/download/$(curl -s https://github.com/concourse/concourse/releases/latest | sed 's/^.*tag\///' | sed 's/\".*$//')/fly_linux_amd64 && \
    chmod +x fly_linux_amd64 && \
    mv fly_linux_amd64 /usr/local/bin/fly
    
# Install PKS CLI

RUN cd /tmp && \
    curl -Lk -o pks 'https://docs.google.com/uc?export=download&id=1JRnzSErlT3r7ACaRnbHdazp0gWJcAZuL' && \
    chmod +x pks && \
    mv pks /usr/local/bin/pks

# Cleanup

RUN rm -rf /tmp/*
