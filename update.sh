#!/bin/bash
cd /opt/docker/compose/freqtrade
cd ./freqtrade-git
/usr/bin/git pull
cd ..
cd ./phils_strategies
/usr/bin/git pull
cd ..

docker compose build

sudo systemctl restart docker-compose@freqtrade
