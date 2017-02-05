#!/bin/bash

# Clicking on the first non-parenthesized, non-italicized link
# Ignoring external links, links to the current page, or red links
# Stopping when reaching "Philosophy", a page with no links or a page that does not exist, or when a loop occurs

site=$1
curl -s $site > temp
title=$(cat temp | grep "<title>.*</title>" | sed "s/<title>//" | sed "s/<\/title>//" | sed "s/[[:space:]]\-[[:space:]]Wikipedia//")
cat temp | grep "<p>.*" > temp2
firstLink=$(cat temp2 | grep -o -m 1 "href=\"/wiki/.*\"" )
# sedStyle=$(sed -n "s|href=\"/wiki/[a-zA-Z\_\-]*\"|\1|p" temp2)

echo $title
stringarray=($firstLink)
realFirstLink=$(echo ${stringarray[0]})

echo $realFirstLink
strippedLink=$(echo $realFirstLink | sed "s/href=\"//" | sed "s/\"//")
echo $strippedLink

nextPage="https://en.wikipedia.org$strippedLink"
echo $nextPage
