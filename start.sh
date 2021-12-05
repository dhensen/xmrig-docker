#!/usr/bin/env bash

mkdir -p miner_data

if [ ! -f miner_data/config.json ] ; then
    cp config.json.example miner_data/config.json
fi

docker-compose up -d
docker-compose logs -f
