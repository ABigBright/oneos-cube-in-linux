# Firefly development environment based on Ubuntu 16.04 LTS.

# Start with Ubuntu 16.04 LTS.
FROM ubuntu:18.04

MAINTAINER tchip <990647625@qq.com>

env PROJECT="/home/oneos" \
    BASE_DEP="apt-utils git vim xxd python3 python3-pip python3-venv"

# Update repository of Alibaba
# COPY sources.list /etc/apt/sources.list

# ENTRYPOINT
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Default workdir
WORKDIR $PROJECT

RUN apt-get update \
    && apt-get install -y ca-certificates

COPY sources.list /etc/apt/

# Update package lists
RUN apt-get update \
    && apt-get upgrade -y \
# Install gosu
    && apt-get -y install curl \
    && curl -o /usr/local/bin/gosu -SL "https://gitee.com/tiankeyong/gosu/releases/download/1.14/gosu-$(dpkg --print-architecture | awk -F- '{ print $NF }')" \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true \
# install dependencies
    && apt-get install -y $BASE_DEP \
# scons & yaml etc
    && python3 -m pip install requests tqdm pyyaml SCons==4.4.0 \
# Clean
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
# Change the access permissions of entrypoint.sh
    && chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD [ "/bin/bash" ]
