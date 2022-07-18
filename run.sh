#!/bin/sh
set -e

docker-compose down

sudo rm -rf ./localnet-setup

echo "---- Building docker image"
cd ethermint
git submodule update --recursive
docker-compose build

echo "---- Initializing node configs"
cd ../
mkdir -p localnet-setup
if ! [ -f localnet-setup/node0/evmosd/config/genesis.json ]; then docker run --rm -v $PWD/localnet-setup:/ethermint:Z ethermintd/node "./ethermintd testnet init-files --v 4 -o /ethermint --keyring-backend=test --starting-ip-address 192.168.0.10"; fi

sudo chown -R $USER:$USER ./localnet-setup

find localnet-setup/node*/evmosd/config/* -type f -name "config.toml" -exec sed -i -e 's/prometheus = false/prometheus = true/g' {} + 

jq '.app_state.bank.balances += [{"address": "ethm1xchpxhekfveq958wtexu8dcrtkcy6hvpfruht2", "coins": [{"denom": "aphoton","amount": "50000000000000000000000"}]}]' ./localnet-setup/node0/evmosd/config/genesis.json > genesis.json 

cp genesis.json ./localnet-setup/node0/evmosd/config/.
cp genesis.json ./localnet-setup/node1/evmosd/config/.
cp genesis.json ./localnet-setup/node2/evmosd/config/.
cp genesis.json ./localnet-setup/node3/evmosd/config/.

docker-compose build

docker-compose up -d