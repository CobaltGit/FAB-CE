#!/bin/sh

cd /usr/src/fab
envsubst '\$TOKEN' < ./data/settings.json > ./data/settings-postenv.json
rm ./data/settings.json
mv ./data/settings-postenv.json
node bot.js