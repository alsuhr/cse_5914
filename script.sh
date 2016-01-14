#!/bin/sh

code=fr

if [ ! -z "$2" ]; then
  code=$2
fi


if [ -z "$1" ]; then
  echo Usage: $0 '"phrase"' '[language_code]'
else
  curl -u "07659530-1088-49ad-8e41-ec91be567edc":"OCYEZcp6BeQJ" -H "accept: application/json" -H "X-SyncTimeout: 30" -X POST -F "text=$1" -F "source=en" -F "target=$code" "https://gateway.watsonplatform.net/language-translation/api/v2/translate" > /tmp/foo.$$ 2>/dev/null
  egrep '"translation":' /tmp/foo.$$ | cut -d: -f2-
  rm /tmp/foo.$$
fi
