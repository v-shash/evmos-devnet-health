#!/bin/sh
set -e

if [ -z "$GRPC_URL" ] || [ -z "$TENDERMINT_URL" ] || [ -z "$DENOM_COEFFICIENT" ] || [ -z "$BECH_PREFIX" ] || [ -z "$DENOM" ]; then
  echo 'GRPC_URL, TENDERMINT_URL, DENOM_COEFFICIENT, BECH_PREFIX, DENOM environment variables must all be defined'        
  exit 1
fi

cosmos-exporter --bech-prefix=$BECH_PREFIX --tendermint-rpc=$TENDERMINT_URL --node=$GRPC_URL --denom=$DENOM --denom-coefficient=$DENOM_COEFFICIENT --log-level=debug