#!/bin/sh

if [ -z "$1" ]; then
  echo Usage: $0 '"phrase"' '[language_code]'
else
  # Translate to Arabic first.
  curl -u "07659530-1088-49ad-8e41-ec91be567edc":"OCYEZcp6BeQJ" -H "accept: application/json" -H "X-SyncTimeout: 30" -X POST -F "text=$1" -F "source=en" -F "target=ar" "https://gateway.watsonplatform.net/language-translation/api/v2/translate" > /tmp/enar.$$ 2>/dev/null
  ar_to_en=`egrep '"translation":' /tmp/enar.$$ | cut -d'"' -f4- | tr -d '"'`

  # Now translate back to English.
  echo "English to Arabic:"
  echo $ar_to_en
  curl -u "07659530-1088-49ad-8e41-ec91be567edc":"OCYEZcp6BeQJ" -H "accept: application/json" -H "X-SyncTimeout: 30" -X POST -F "text=$ar_to_en" -F "source=ar" -F "target=en" "https://gateway.watsonplatform.net/language-translation/api/v2/translate" > /tmp/aren.$$ 2>/dev/null
  en_to_fr=`egrep '"translation":' /tmp/aren.$$ | cut -d'"' -f4- | tr -d '"'`

  # Now translate to French.
  echo "Arabic to English:"
  echo $en_to_fr
  curl -u "07659530-1088-49ad-8e41-ec91be567edc":"OCYEZcp6BeQJ" -H "accept: application/json" -H "X-SyncTimeout: 30" -X POST -F "text=$en_to_fr" -F "source=en" -F "target=fr" "https://gateway.watsonplatform.net/language-translation/api/v2/translate" > /tmp/enfr.$$ 2>/dev/null
  fr_to_en=`egrep '"translation":' /tmp/enfr.$$ | cut -d'"' -f4- | tr -d '"'`

  # Now translate back to English.
  echo "English to French:"
  echo $fr_to_en
  curl -u "07659530-1088-49ad-8e41-ec91be567edc":"OCYEZcp6BeQJ" -H "accept: application/json" -H "X-SyncTimeout: 30" -X POST -F "text=$fr_to_en" -F "source=fr" -F "target=en" "https://gateway.watsonplatform.net/language-translation/api/v2/translate" > /tmp/fren.$$ 2>/dev/null
  en_to_es=`egrep '"translation":' /tmp/fren.$$ | cut -d'"' -f4- | tr -d '"'`

  # Now translate to Spanish.
  echo "French to English:"
  echo $en_to_es
  curl -u "07659530-1088-49ad-8e41-ec91be567edc":"OCYEZcp6BeQJ" -H "accept: application/json" -H "X-SyncTimeout: 30" -X POST -F "text=$en_to_es" -F "source=en" -F "target=es" "https://gateway.watsonplatform.net/language-translation/api/v2/translate" > /tmp/enes.$$ 2>/dev/null
  es_to_en=`egrep '"translation":' /tmp/enes.$$ | cut -d'"' -f4- | tr -d '"'`

  # Now translate back to English.
  echo "English to Spanish:"
  echo $es_to_en
  curl -u "07659530-1088-49ad-8e41-ec91be567edc":"OCYEZcp6BeQJ" -H "accept: application/json" -H "X-SyncTimeout: 30" -X POST -F "text=$es_to_en" -F "source=es" -F "target=en" "https://gateway.watsonplatform.net/language-translation/api/v2/translate" > /tmp/esen.$$ 2>/dev/null
  en_to_po=`egrep '"translation":' /tmp/esen.$$ | cut -d'"' -f4- | tr -d '"'`

  # Now translate to Portuguese.
  echo "Spanish to English:"
  echo $en_to_po
  curl -u "07659530-1088-49ad-8e41-ec91be567edc":"OCYEZcp6BeQJ" -H "accept: application/json" -H "X-SyncTimeout: 30" -X POST -F "text=$en_to_po" -F "source=en" -F "target=pt" "https://gateway.watsonplatform.net/language-translation/api/v2/translate" > /tmp/enpo.$$ 2>/dev/null
  po_to_en=`egrep '"translation":' /tmp/enpo.$$ | cut -d'"' -f4- | tr -d '"'`

  # Now translate back to English.
  echo "English to Portuguese:"
  echo $po_to_en
  curl -u "07659530-1088-49ad-8e41-ec91be567edc":"OCYEZcp6BeQJ" -H "accept: application/json" -H "X-SyncTimeout: 30" -X POST -F "text=$po_to_en" -F "source=pt" -F "target=en" "https://gateway.watsonplatform.net/language-translation/api/v2/translate" > /tmp/poen.$$ 2>/dev/null
  final=`egrep '"translation":' /tmp/poen.$$ | cut -d'"' -f4- | tr -d '"'`

  echo "Portuguese to English:"
  echo $final

  rm /tmp/enar.$$
  rm /tmp/aren.$$
  rm /tmp/enfr.$$
  rm /tmp/fren.$$
  rm /tmp/enes.$$
  rm /tmp/esen.$$
fi
