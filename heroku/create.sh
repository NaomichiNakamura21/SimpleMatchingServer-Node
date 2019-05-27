#!/bin/bash
cd `dirname $0`
UUIDTEXT=`uuidgen`
UUID=${UUIDTEXT:0:18}
URI=`echo unip2p-${UUID} | tr ‘[A-Z]’ ‘[a-z]’`
heroku create $URI
git remote rm heroku
git remote add heroku https://git.heroku.com/${URI}.git
git add ../
git commit -m "Publish Heroku"
git push heroku master

GameKey=`uuidgen`
SecretKey=`uuidgen`

heroku config:set GAMEKEY=${GameKey}
heroku config:set SERCETKEY=${SecretKey}

echo -e MatchingServerURL:${URI}\nMatchingGameKey:${GameKey}\nMatchingSecretKey:${SecretKey}> ./MatchingServerSettings.txt
echo -n -e "\n"
echo MatchingServerURL:https://${URI}.herokuapp.com
echo MatchingGameKey:${GameKey}
echo MatchingSecretKey:${SecretKey}

open https://${URI}.herokuapp.com/${GameKey}