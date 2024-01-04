#!/bin/bash
cd /opt/docker/compose/freqtrade
/usr/bin/git clone https://github.com/freqtrade/freqtrade freqtrade-git

cd ./freqtrade-git
/usr/bin/git clone https://github.com/nateemma/strategies phils_strategies

cd /opt/docker/compose/freqtrade

mkdir -p ./custom_strategies/utils/
cp -rf ./phils_strategies/NNPredict/*.py ./custom_strategies/
cp -rf ./phils_strategies/utils/* ./custom_strategies/utils/
mkdir -p ./custom_strategies/models/
cp -rf ./phils_strategies/NNPredict/models/* ./custom_strategies/models/

docker compose build

FILE=./config.json
if [ -f "$FILE" ]; then
    echo "$FILE exists. Continuing install process..."
else 
    echo "$FILE does not exist. Please create it then rerun install.sh."
    exit 1
fi

mkdir -p ./user_data/logs


sudo cp docker-compose@.service /lib/systemd/system/docker-compose@.service
sudo systemctl daemon-reload
sudo systemctl enable docker-compose@freqtrade
sudo systemctl restart docker-compose@freqtrade
