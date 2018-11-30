FROM python:3.6-alpine3.6

LABEL maintainer="Lance Hall"

COPY ./bin /usr/local/bin

RUN chmod a+x /usr/local/bin/* && \
    apk add --no-cache git build-base openssl && \
    apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/main leveldb-dev && \
    pip install aiohttp pylru plyvel && \
    git clone https://github.com/Manbearpixel/electrumx.git && \
	git rev-parse HEAD && \
    cd electrumx && \
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
#ENV HOST "159.89.140.84"
ENV COIN=Odin
ENV USERNAME=electrumx
ENV DAEMON_URL=http://user:password@localhost:1988
WORKDIR /data

EXPOSE 50001 50443

CMD ["init"]


# REQUIRED
#DB_DIRECTORY = /db
# Bitcoin Node RPC Credentials
#DAEMON_URL = http://username:password@hostname:port/

# See https://github.com/kyuupichan/electrumx/blob/master/docs/ENVIRONMENT.rst for
# information about other configuration settings you probably want to consider.