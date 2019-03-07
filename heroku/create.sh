#!/bin/bash
cd `dirname $0`
UUIDTEXT=`uuidgen`
UUID=${UUIDTEXT:0:18}
URI=`echo unip2p-${UUID} | tr ‘[A-Z]’ ‘[a-z]’`
heroku create $URI
git remote set-url heroku https://git.heroku.com/${URI}.git
git add ../
git commit -m "Publish Heroku"
git push heroku master

GameKey=`uuidgen`
SecretKeyTEXT=`uuidgen`
SecretKey=${SecretKeyTEXT:0:7}${SecretKeyTEXT:9:13}

heroku config:set GAMEKEY=${GameKey}
echo ${URI} > ./url

echo MatchingServerURL: https://${URI}.herokuapp.com/
echo MatchingGameKey: ${GameKey}
echo MatchingSecretKey: ${SecretKey}

open https://${URI}.herokuapp.com/${GameKey}