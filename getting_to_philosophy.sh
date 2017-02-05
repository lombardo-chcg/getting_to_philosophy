#!/bin/bash

# Clicking on the first non-parenthesized, non-italicized link
# Ignoring external links, links to the current page, or red links
# Stopping when reaching "Philosophy", a page with no links or a page that does not exist, or when a loop occurs

source helpers.sh

count=0
wikipediaBaseUrl="https://en.wikipedia.org"

extractHtmlTitleValue() {
  echo $(grep --color=never "<title>.*</title>" \
    | sed "s/<title>//" | sed "s/<\/title>//" \
    | sed "s|[[:space:]]\-[[:space:]]Wikipedia||"
  )
}

removeAnythingWithParens() {
  echo $( grep --color=never "<p>.*" \
      | sed "s|[[:space:]]([^)]*)||g"
  )
}

getFirstWikipediaInternalLink() {
  echo $(grep --color=never -o -m 1 "href=\"/wiki/.*\"")
}

split() {
  stringToSplit=$1

  echo ${!stringToSplit}
}

startingTitle=$(curl -s $1 | extractHtmlTitleValue )

getNextArticle() {
  echo -e "\n*************"
  site="$1"
  count=$2

  curl -s $site > temp

  title=$(cat temp | extractHtmlTitleValue)

  [[ ${title} == "Philosophy"  ]] && { printSuccessMessage $title $count; exit 0; }

  echo -e "Current article is $(printGreen "$title") \nthis is stop number $(printGreen $count)"

  firstLink=$(cat temp | removeAnythingWithParens | getFirstWikipediaInternalLink)

  stringarray=($firstLink)
  realFirstLink=$(echo ${stringarray[0]})

  strippedLink=$(echo $realFirstLink \
    | sed "s/href=\"//" \
    | sed "s/\"//"
  )

  nextPage="$wikipediaBaseUrl$strippedLink"

  echo -e "\nnext stop is $(printBlue $nextPage)"
  let count=count+1

  getNextArticle "$nextPage" $count
}

getNextArticle "$1" 0
