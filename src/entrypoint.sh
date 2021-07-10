#!/bin/sh

cd /usr/src/fab
envsubst < ./data/settings.json > ./data/settings-postenv.json
mv ./data/settings-postenv.json ./data/settings.json
node bot.js