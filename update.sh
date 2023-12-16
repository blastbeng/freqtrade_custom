#!/bin/bash
cd ./freqtrade-git
/usr/bin/git pull
cd ../phils_strategies
/usr/bin/git pull
cd ..

docker compose build

sudo systemctl restart docker-compose@freqtrade
