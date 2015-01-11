#!/bin/bash

mkdir -p html txt

domains="https://quadpad.lqdn.fr"
for domain in $domains; do
  cat txt/* | grep "$domain" | sed 's/ /\n/g' | grep "^$domain/[^/]*$" | sort | uniq > listdomain
  cat list listdomain | sort | uniq > list.tmp
  mv list{.tmp,}
done

for pad in `cat list`; do
  host=$(echo $pad | sed 's|/[^/]*$||')
  domain=$(echo $host | sed 's|https\?://||')
  id=$(echo $pad | sed 's|^.*/\([^/]*\)$|\1|')
  url="$host/ep/pad/export/$id/latest?format="
  curl -sL "${url}html" > "html/${domain}_${id}.html"
  curl -sL "${url}txt" > "txt/${domain}_${id}.txt"
done

