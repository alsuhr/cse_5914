#!/bin/sh

if [ -z "$1" ]; then
  echo Usage: $0 '"phrase"' '[language_code]'
else
  # Translate to Arabic first.
  curl -u "07659530-1088-49ad-8e41-ec91be567edc":"OCYEZcp6BeQJ" -H "accept: application/json" -H "X-SyncTimeout: 30" -X POST -F "text=$1" -F "source=en" -F "target=ar" "https://gateway.watsonplatform.net/language-translation/api/v2/translate" > /tmp/enar.$$ 2>/dev/null
  ar_to_en=`egrep '"translation":' /tmp/enar.$$ | cut -d'"' -f4-`

  # Now translate back to English.
  echo "English to Arabic:"
  echo $ar_to_en
  curl -u "07659530-1088-49ad-8e41-ec91be567edc":"OCYEZcp6BeQJ" -H "accept: application/json" -H "X-SyncTimeout: 30" -X POST -F "text=$ar_to_en" -F "source=ar" -F "target=en" "https://gateway.watsonplatform.net/language-translation/api/v2/translate" > /tmp/aren.$$ 2>/dev/null
  en_to_fr=`egrep '"translation":' /tmp/aren.$$ | cut -d: -f2- > /tmp/foo.$$`

  # Now translate to French.
  echo "Arabic to French:"
  echo $en_to_fr

  rm /tmp/enar.$$
  rm /tmp/aren.$$
fi
