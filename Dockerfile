FROM felixweis/buildpack-deps:bitcoind

ENV BITCOIN_REPOSITORY acejam
ENV BITCOIN_BRANCH 0.15.1-indexes

RUN apt-get update && \
    apt-get install -y --no-install-recommends libzmq3-dev && \
    rm -rf /var/lib/apt/lists/*

RUN cd /root \
	&& curl -L https://github.com/$BITCOIN_REPOSITORY/bitcoin/archive/$BITCOIN_BRANCH.tar.gz | tar xzv \
	&& cd bitcoin-$BITCOIN_BRANCH/ \
	&& ./autogen.sh \
	&& ./configure --with-incompatible-bdb --disable-tests \
	&& make \
	&& make install \
	&& cd .. \
	&& rm -Rfv bitcoin-$BITCOIN_BRANCH/

EXPOSE 8332 8333
VOLUME /data/bitcoin
CMD ["/usr/local/bin/bitcoind", "-datadir=/data/bitcoin"]
