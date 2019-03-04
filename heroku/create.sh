#!/bin/bash
UUIDTEXT=`uuidgen`
UUID=${UUIDTEXT:0:7}
LUUID=`echo ${UUID} | tr ‘[A-Z]’ ‘[a-z]’`
heroku create "unip2p-"$LUUID
git remote set-url heroku https://git.heroku.com/unip2p-${LUUID}.git
git add .
git commit -m "Publish Heroku"
git push heroku master

SecretKeyTEXT=`uuidgen`
SecretKey=${SecretKeyTEXT:0:7}${SecretKeyTEXT:9:13}

echo MatchingServerURL: https://unip2p-${LUUID}.herokuapp.com/
echo MatchingSecretKey: ${SecretKey}

heroku open

echo ${LUUID} > ./url