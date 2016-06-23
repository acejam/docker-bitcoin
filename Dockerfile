FROM ubuntu:14.04
MAINTAINER Joshua Noble <acejam@gmail.com>

ENV RPC_USER bitcoinrpc
ENV RPC_PASS P@ssw0rd
ENV MAX_CONNECTIONS 15
ENV RPC_PORT 8332
ENV PORT 8333

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8842ce5e && \
    echo "deb http://ppa.launchpad.net/bitcoin/bitcoin/ubuntu trusty main" > /etc/apt/sources.list.d/bitcoin.list

RUN apt-get update && \
    apt-get install -y bitcoind && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 8332 8333
VOLUME ["/data/bitcoin"]
CMD ["/usr/bin/bitcoind", "-datadir=/data/bitcoin", "-printtoconsole"]
