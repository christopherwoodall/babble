# Security Onion Docker file for testing purposes
# NOTES:
#   - Installation:
#       - https://docs.securityonion.net/en/2.3/installation.html
#   - Hardware Requirements:
#       - https://docs.securityonion.net/en/2.3/hardware.html#hardware


FROM ubuntu:20.04

ARG DEBIAN_FRONTEND="noninteractive"

USER root
WORKDIR /root
SHELL ["/bin/bash", "-c"]
RUN rm /bin/sh && ln -s /bin/bash /bin/sh


# Install dependencies
RUN apt-get -y -qq update   && \
    apt-get -qq -y upgrade  && \
    apt-get install -y         \
      apt-transport-https      \
      ca-certificates          \
      curl                     \
      git                      \
      gnupg                    \
      lsb-release


# Install `podman`
RUN mkdir -p /etc/apt/keyrings && \
    . /etc/os-release && \
    echo "deb https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /" \
      > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list && \
    curl -fsSL "https://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/Release.key" \
      | apt-key add -  && \
    apt-get update -qq && \
    apt-get install -y podman


# Install Docker
# TODO: Move into "installer.sh" script -cw
RUN apt-get remove docker docker-engine docker.io containerd runc && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
      gpg --dearmor -o /etc/apt/keyrings/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" >> /etc/apt/sources.list.d/docker.list && \
    apt-get update -qq && \
  apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin


# Install SO components
WORKDIR /securityonion

RUN git clone https://github.com/Security-Onion-Solutions/securityonion.git . && \
    git checkout
    # bash so-setup-network


####################################################################
# NOTES:
# docker pull ghcr.io/security-onion-solutions/so-elasticsearch:2.4.0
# docker pull ghcr.io/security-onion-solutions/so-kibana:2.4.0
#
