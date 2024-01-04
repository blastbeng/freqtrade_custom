#!/bin/bash
#freqtrade download-data \
#      --logfile /freqtrade/user_data/logs/freqtrade-downloader.log \
#      --config /freqtrade/user_data/configs/config.json \
#      --dl-trades
freqtrade trade \
      --logfile /freqtrade/user_data/logs/freqtrade-trade.log \
      --db-url sqlite:////freqtrade/user_data/databases/tradesv3.sqlite \
      --config /freqtrade/user_data/configs/config.json \
      --freqaimodel CatboostRegressor \
      --strategy NNPredict_CNN
