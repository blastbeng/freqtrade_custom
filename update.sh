#!/bin/bash
cd /opt/docker/compose/freqtrade
cd ./freqtrade-git
/usr/bin/git pull
cd ../phils_strategies
/usr/bin/git pull
cd ..

mkdir -p ./custom_strategies/utils/
cp -rf ./phils_strategies/NNPredict/*.py ./custom_strategies/
cp -rf ./phils_strategies/utils/* ./custom_strategies/utils/

docker compose build

sudo systemctl restart docker-compose@freqtrade
