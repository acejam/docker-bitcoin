#!/bin/bash
set -eo pipefail

if [ ! -f /data/bitcoin/bitcoin.conf ]; then
  echo "server=1
  printtoconsole=1
  rpcallowip=::/0
  rpcuser=${RPC_USER:-bitcoin}
  rpcpassword=${RPC_PASSWORD:-password}" > /data/bitcoin/bitcoin.conf
fi

exec "$@"
