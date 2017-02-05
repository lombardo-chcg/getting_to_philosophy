#!/bin/bash

# Clicking on the first non-parenthesized, non-italicized link
# Ignoring external links, links to the current page, or red links
# Stopping when reaching "Philosophy", a page with no links or a page that does not exist, or when a loop occurs

waitExpression=0
count=0

curl -s $1 > temp
startingTitle=$(cat temp | grep --color=never "<title>.*</title>" | sed "s/<title>//" | sed "s/<\/title>//" | sed "s|[[:space:]]\-[[:space:]]Wikipedia||")

green='\033[0;32m'
blue='\033[0;34m'
noColor='\033[0m'

printGreen() {
  echo ${green}$1${noColor}
}

printBlue() {
  echo ${blue}$1${noColor}
}

printSuccessMessage() {
  currentArticle=$1
  steps=$2
  echo -e "\nArrival!  Took $(printGreen $steps) steps to get from $(printGreen $startingTitle) to $(printBlue $currentArticle) \n"
}

getNextArticle() {
  echo -e "\n*************"
  site="$1"
  count=$2

  curl -s $site > temp
  title=$(cat temp | grep --color=never "<title>.*</title>" | sed "s/<title>//" | sed "s/<\/title>//" | sed "s|[[:space:]]\-[[:space:]]Wikipedia||")

  [[ ${title} == "Philosophy"  ]] && { printSuccessMessage $title $count; exit 0; }

  echo -e "Current article is $(printGreen "$title") \nthis is stop number $(printGreen $count)"

  cat temp | grep --color=never "<p>.*" | sed "s|[[:space:]]([^)]*)||g" > temp2
  firstLink=$(cat temp2 | grep --color=never -o -m 1 "href=\"/wiki/.*\"" )

  stringarray=($firstLink)
  realFirstLink=$(echo ${stringarray[0]})
  strippedLink=$(echo $realFirstLink | sed "s/href=\"//" | sed "s/\"//")

  nextPage="https://en.wikipedia.org$strippedLink"

  echo -e "\nnext stop is $(printBlue $nextPage)"
  let count=count+1
  getNextArticle $nextPage $count
}

getNextArticle $1 0
