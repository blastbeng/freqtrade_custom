#!/bin/bash
cd /opt/docker/compose/freqtrade
cd ./freqtrade-git
/usr/bin/git pull
cd ../phils_strategies
/usr/bin/git pull
cd ..

cp -rf ./phils_strategies/NNPredict/*.py ./custom_strategies/

docker compose build

sudo systemctl restart docker-compose@freqtrade
