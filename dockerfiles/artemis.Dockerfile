FROM ubuntu:18.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y build-essential maven libsodium-dev \
    tmux wget iperf3 curl apt-utils iputils-ping expect npm git git-extras \
    software-properties-common openssh-server openjdk-11-jre-headless lsof telnet

# get artemis
RUN git clone --recursive https://github.com/atoulme/artemis.git
WORKDIR artemis/
RUN ./gradlew build -x test
WORKDIR /artemis/build/distributions
RUN tar -xzf artemis-*-SNAPSHOT.tar.gz
RUN ln -s /artemis/build/distributions/artemis-*-SNAPSHOT/bin/artemis /usr/bin/artemis

WORKDIR /

ENTRYPOINT ["/bin/bash"]