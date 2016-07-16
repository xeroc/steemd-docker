FROM ubuntu:16.04

WORKDIR /usr/local/steem

RUN apt-get update \
    apt-get install -qy build-essential git libssl-dev m4 yasm autogen automake libtool doxygen python-dev autotools-dev libicu-dev libbz2-dev cmake g++ wget pkg-config libgmp-dev libboost-all-dev \
    git clone https://github.com/steemit/steem steem-src
WORKDIR /usr/local/steem/steem-src
RUN git fetch --tags \
    git checkout master \
    git submodule update --init --recursive \
    cmake -DLOW_MEMORY_NODE=ON -DENABLE_CONTENT_PATCHING=OFF . \
    make \
    make install
WORKDIR /usr/local/steem
CMD ["steemd","--rpc-endpoint"]
EXPOSE 8090
