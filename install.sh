#!/bin/bash
/usr/bin/git clone https://github.com/freqtrade/freqtrade freqtrade-git
/usr/bin/git clone https://github.com/nateemma/strategies phils_strategies
./update.sh

docker compose build
sudo systemctl enable docker-compose@freqtrade
sudo systemctl start docker-compose@freqtrade
