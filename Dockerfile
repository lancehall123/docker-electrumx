FROM python:3.6-alpine3.6

LABEL maintainer="Lance Hall"

COPY ./bin /usr/local/bin

RUN chmod a+x /usr/local/bin/* && \
    apk add --no-cache git build-base openssl && \
    apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ leveldb-dev && \
    pip install aiohttp pylru plyvel quark_hash && \
    git clone https://github.com/odinblockchain/electrumx.git && \
    cd electrumx && \
	git checkout odin-support && \
    python setup.py install && \
    apk del git build-base && \
    rm -rf /tmp/*

VOLUME ["/data"]
ENV HOME /data
ENV ALLOW_ROOT 1
ENV DB_DIRECTORY /data
ENV TCP_PORT=50001
ENV SSL_PORT=50443
ENV SSL_CERTFILE ${DB_DIRECTORY}/electrumx.crt
ENV SSL_KEYFILE ${DB_DIRECTORY}/electrumx.key
ENV HOST=""
ENV RPC_HOST="127.0.0.1"
ENV COIN=Odin
ENV USERNAME=userme
ENV DAEMON_URL=http://userme:passwordme@172.17.0.3:1988/
WORKDIR /data

EXPOSE 50001 50443

CMD ["init"]


# REQUIRED
#DB_DIRECTORY = /db
# Bitcoin Node RPC Credentials
#DAEMON_URL = http://username:password@hostname:port/

# See https://github.com/kyuupichan/electrumx/blob/master/docs/ENVIRONMENT.rst for
# information about other configuration settings you probably want to consider.