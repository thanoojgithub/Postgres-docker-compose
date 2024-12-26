# Base Image
FROM ubuntu:latest

# Set non-interactive frontend for apt
ENV DEBIAN_FRONTEND=noninteractive

# Set the timezone
ENV TZ=Asia/Kolkata

# Install required packages
RUN apt update && apt install -y \
    software-properties-common \
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
    make \
    jq \
    fzf \
    tree \
    procps \
    findutils \
    gnupg2 \ 
    lsb-release \ 
    apt-transport-https \
    openjdk-21-jdk \
    postgresql postgresql-contrib

# Download and install the latest Gradle version (8.12 as an example)
RUN wget https://services.gradle.org/distributions/gradle-8.12-bin.zip -P /tmp \
    && unzip -d /opt/gradle /tmp/gradle-8.12-bin.zip \
    && ln -s /opt/gradle/gradle-8.12/bin/gradle /usr/bin/gradle

# Set environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:$PATH"

# Verify the installations
RUN git --version \
    && gradle -v \
    && java -version \
    && javac -version
    

# Adjust PostgreSQL configuration to trust all connections and listen on all IP addresses 
RUN echo "host all all 0.0.0.0/0 trust" >> /etc/postgresql/16/main/pg_hba.conf \
 && echo "listen_addresses='*'" >> /etc/postgresql/16/main/postgresql.conf

# Create a directory for PostgreSQL data 
RUN mkdir -p /var/lib/postgresql/data && chown -R postgres:postgres /var/lib/postgresql

# Expose PostgreSQL default port
EXPOSE 5433

# Start PostgreSQL service by default 
CMD ["sh", "-c", "service postgresql start && bash && tail -f /dev/null"]
