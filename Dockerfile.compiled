FROM ubuntu:20.04


# USE YOUR TIMEZONE
# TODO: Automate
ARG TIMEZONE=Europe/Amsterdam

# XMRig base version
ARG XMRIG_VER=6.16.2

# Let the installs happen on their own
ENV DEBIAN_FRONTEND=noninteractive

# One-off for tzdata
RUN set -xe; \
    apt update && apt upgrade -y; \
    ln -fs /usr/share/zoneinfo/${TIMEZONE} /etc/localtime; \
    apt install -y tzdata; \
    dpkg-reconfigure --frontend noninteractive tzdata;

# Install Headers and prep
RUN set -xe; \
    apt-get update; \
    apt-get install wget software-properties-common kmod msr-tools linux-headers-generic ubuntu-dev-tools -y;

# Install XMRig
RUN set -xe; \
    apt-get update && apt-get install build-essential cmake automake libtool autoconf -y; \
    wget https://github.com/xmrig/xmrig/archive/refs/tags/v${XMRIG_VER}.tar.gz; \
    tar xf v${XMRIG_VER}.tar.gz; \
    mkdir -p xmrig-${XMRIG_VER}/build; \
    sed -i 's/DonateLevel = 1/DonateLevel = 0/g' xmrig-${XMRIG_VER}/src/donate.h; \
    cd xmrig-${XMRIG_VER}/scripts; \
    ./build_deps.sh; \
    cd ../build; \
    cmake .. -DXMRIG_DEPS=scripts/deps -DCMAKE_BUILD_TYPE=Release; \
    make -j $(nproc); \
    cp xmrig /usr/local/bin/xmrig; \
    rm -rf xmrig* *.tar.gz;

WORKDIR /tmp
COPY entrypoint.sh /
EXPOSE 3003
CMD "/entrypoint.sh"
