#!/bin/bash
cd /opt/docker/compose/freqtrade
cd ./freqtrade-git
docker build . -t blastbeng/freqtrade:develop
docker compose build
sudo systemctl restart docker-compose@freqtrade