FROM ubuntu:20.04

RUN rm -rf /var/lib/apt/lists/* && apt-get update && apt-get install -y tzdata

ENV TZ=UTC

RUN apt-get update -y \
    && apt-get install -y \
        libtool \
        libssl-dev \
        libevent-dev \
        libboost-dev \
        libboost-system-dev \
        libboost-filesystem-dev \
        libboost-program-options-dev \
        libboost-thread-dev \
        libdb-dev \
        libsqlite3-dev \
        wget \
        tar \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://bitcoincore.org/bin/bitcoin-core-25.0/bitcoin-25.0-x86_64-linux-gnu.tar.gz

RUN tar -zxvf bitcoin-25.0-x86_64-linux-gnu.tar.gz

RUN cp bitcoin-25.0/bin/* /usr/local/bin

ENV BITCOIN_DATA=/root/.bitcoin

RUN mkdir -p ${BITCOIN_DATA}

EXPOSE 38882 38883

CMD ["bitcoind", "-txindex", "-signet"]
