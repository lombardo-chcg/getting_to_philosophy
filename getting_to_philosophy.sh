#!/bin/bash

# Clicking on the first non-parenthesized, non-italicized link
# Ignoring external links, links to the current page, or red links
# Stopping when reaching "Philosophy", a page with no links or a page that does not exist, or when a loop occurs

# site=$1
# curl -s $initialSite > temp
# initialSiteTitle=$(cat temp | grep --color=never "<title>.*</title>" | sed "s/<title>//" | sed "s/<\/title>//" | sed "s|[[:space:]]\-[[:space:]]Wikipedia||" | tr -d " ")

waitExpression=0
count=0

green='\033[0;32m'
noColor='\033[0m'

getNextArticle() {
  echo "*************"
  site=$1
  curl -s $site > temp
  title=$(cat temp | grep --color=never "<title>.*</title>" | sed "s/<title>//" | sed "s/<\/title>//" | sed "s|[[:space:]]\-[[:space:]]Wikipedia||" | tr -d " ")

  echo -e "Current article is ${green}$title${noColor} at address ${green}$site${noColor}"

  [[ ${title} == "Philosophy"  ]] && { echo "Found it!"; exit 0; }

  cat temp | grep --color=never "<p>.*" > temp2
  firstLink=$(cat temp2 | grep --color=never -o -m 1 "href=\"/wiki/.*\"" )

  stringarray=($firstLink)
  realFirstLink=$(echo ${stringarray[0]})
  strippedLink=$(echo $realFirstLink | sed "s/href=\"//" | sed "s/\"//")

  nextPage="https://en.wikipedia.org$strippedLink"

  echo -e "\nnext page is ${green}$nextPage${noColor}"
  #
  getNextArticle $nextPage
}

getNextArticle $1

# site=$1
# curl -s $site > temp
# title=$(cat temp | grep --color=never "<title>.*</title>" | sed "s/<title>//" | sed "s/<\/title>//" | sed "s|[[:space:]]\-[[:space:]]Wikipedia||" | tr -d " ")
# cat temp | grep "<p>.*" > temp2
# firstLink=$(cat temp2 | grep -o -m 1 "href=\"/wiki/.*\"" )
# # sedStyle=$(sed -n "s|href=\"/wiki/[a-zA-Z\_\-]*\"|\1|p" temp2)
#
# echo $title
# [[ ${title} == "Quantity" ]] && Echo True
#
# stringarray=($firstLink)
# realFirstLink=$(echo ${stringarray[0]})
#
# echo $realFirstLink
# strippedLink=$(echo $realFirstLink | sed "s/href=\"//" | sed "s/\"//")
# echo $strippedLink
#
# nextPage="https://en.wikipedia.org$strippedLink"
# echo $nextPage
