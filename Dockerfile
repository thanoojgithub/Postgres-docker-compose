# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set the timezone
ENV TZ=Asia/Kolkata

# Install required packages
RUN apt update && apt install -y \
    openjdk-21-jdk \
    git \
    build-essential \
    curl \
    wget \
    unzip \
    nano \
    vim \
    neovim \
    htop \
    tmux \
    net-tools \
    jq \
    fzf \
    tree \
    procps \
    findutils \
    gnupg2 \ 
    lsb-release \ 
    apt-transport-https

# Download and install the latest Gradle version (8.12 as an example)
RUN wget https://services.gradle.org/distributions/gradle-8.12-bin.zip -P /tmp \
    && unzip -d /opt/gradle /tmp/gradle-8.12-bin.zip \
    && ln -s /opt/gradle/gradle-8.12/bin/gradle /usr/bin/gradle

# Verify the installations
RUN git --version \
    && gradle -v

CMD ["bash"]
