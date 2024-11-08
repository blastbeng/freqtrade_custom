#!/bin/bash
cd /opt/docker/compose/freqtrade
docker compose -f docker-compose.csv-convert.yml up --remove-orphans
docker compose -f docker-compose.convert-trades.yml up --remove-orphans