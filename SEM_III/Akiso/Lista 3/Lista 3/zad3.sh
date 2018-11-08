#!/bin/bash

#Obrazek
echo "Obrazek z kotem:"
#curl - pbiera, xmllint - prasuje, wget - zapisuje w pliku ""
wget -q -O "o.xml" $(curl -s "http://thecatapi.com/api/images/get?format=xml&results_per_page=10" | xmllint --xpath "string(//url)" -)
#zmienia obrazek w tekst
img2txt "o.xml"
#rm - usuwa plik ""
rm "o.xml"

#Dowcip
echo -e "\rDowcip:"
#curl-pobiera z serwera, -s - nie pokazuje innych informacji
curl -s "http://api.icndb.com/jokes/random" | jq ".value.joke"
