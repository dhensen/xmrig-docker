FROM ubuntu:22.04

# RUN apt-get update -y && apt-get install -y --no-install-recommends kmod msr-tools

ARG XMRIG_VERSION=6.16.2
ENV XMRIG_VERSION=$XMRIG_VERSION

RUN mkdir /xmrig
WORKDIR /xmrig

# ADD https://github.com/xmrig/xmrig/releases/download/v$XMRIG_VERSION/xmrig-$XMRIG_VERSION-focal-x64.tar.gz /xmrig/xmrig.tar.gz
ADD https://github.com/xmrig/xmrig/releases/download/v$XMRIG_VERSION/xmrig-$XMRIG_VERSION-linux-static-x64.tar.gz /xmrig/xmrig.tar.gz
# TODO add verify signature

RUN tar xf xmrig.tar.gz
RUN mv xmrig-$XMRIG_VERSION xmrig-client
RUN ls -sla ./xmrig-client

ENV USER=4AeP7Piu23yDrYS3dmDMbc3jVzLKbP8QVcBPi9NW5ywKQwgH47ekGr6fjPzGS6WwGQaYTeXC72pSuiVvoXqfrcMH8qKe174+docker
ENV URL=xmrpool.eu:5555

CMD ./xmrig-client/xmrig --user $USER --pass "x" --url $url
