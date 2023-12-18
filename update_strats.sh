
#!/bin/bash
cd /opt/docker/compose/freqtrade
cd ./phils_strategies
/usr/bin/git pull
cd ..

mkdir -p ./custom_strategies/utils/
cp -rf ./phils_strategies/NNPredict/*.py ./custom_strategies/
cp -rf ./phils_strategies/utils/* ./custom_strategies/utils/

sudo systemctl restart docker-compose@freqtrade
