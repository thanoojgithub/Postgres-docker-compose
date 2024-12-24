# Use an official Ubuntu as a parent image
FROM ubuntu:latest

# Set the timezone
ENV TZ=Asia/Kolkata

# Install required packages
RUN apt update && apt install -y \
    openjdk-21-jdk \
    git \
    build-essential \
    gradle \
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

CMD ["bash"]
