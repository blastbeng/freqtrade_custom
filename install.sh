#!/bin/bash
cd /opt/docker/compose/freqtrade
/usr/bin/git clone https://github.com/freqtrade/freqtrade freqtrade-git
/usr/bin/git clone https://github.com/nateemma/strategies phils_strategies

cd /opt/docker/compose/freqtrade

mkdir -p ./custom_strategies/utils/
cp -rf ./phils_strategies/NNPredict/*.py ./custom_strategies/
cp -rf ./phils_strategies/utils/* ./custom_strategies/utils/
mkdir -p ./custom_strategies/models/
cp -rf ./phils_strategies/NNPredict/models/* ./custom_strategies/models/

docker compose build
sudo cp docker-compose@.service /lib/systemd/system/docker-compose@.service
sudo systemctl daemon-reload
sudo systemctl enable docker-compose@freqtrade
sudo systemctl restart docker-compose@freqtrade
