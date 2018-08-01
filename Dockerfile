FROM ubuntu:16.04
LABEL maintainer "Joshua Noble <acejam@gmail.com>"

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://bitcoincore.org/bin/bitcoin-core-0.16.2/bitcoin-0.16.2-x86_64-linux-gnu.tar.gz && \
    tar -xf bitcoin-0.16.2-x86_64-linux-gnu.tar.gz && \
    cp bitcoin-0.16.2/bin/* /usr/bin && \
    rm -rf bitcoin-0.16.2*

COPY docker-entrypoint.sh /usr/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 8332 8333
VOLUME ["/data/bitcoin"]
CMD ["/usr/bin/bitcoind", "-datadir=/data/bitcoin"]
