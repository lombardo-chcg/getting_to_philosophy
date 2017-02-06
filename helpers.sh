#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;34m'
noColor='\033[0m'

printGreen() {
  echo ${green}$1${noColor}
}

printBlue() {
  echo ${blue}$1${noColor}
}

printRed() {
  echo -e ${red}$1${noColor}
}

printSuccessMessage() {
  currentArticle=$1
  steps=$2
  echo -e "\nArrival!  It took $(printGreen $steps) steps to get from $(printGreen "$startingTitle") to $(printBlue "$currentArticle") \n"
}

extractHtmlTitleValue() {
  echo $(grep --color=never "<title>.*</title>" \
    | sed "s/<title>//" | sed "s/<\/title>//" \
    | sed "s|[[:space:]]\-[[:space:]]Wikipedia||"
  )
}

removeTextInParentheses() {
  echo $( grep --color=never "<p>.*" \
      | sed "s|[[:space:]]([^)]*)||g"
  )
}

getFirstWikipediaInternalLink() {
  echo $(grep --color=never -o -m 1 "href=\"/wiki/[^\"]*\"[[:space:]]")
}

usage() {
printRed "\nERROR! Must provide a Wikipedia article link as script argument."

cat <<EOF

  Usage: ./getting_to_philosophy.sh <valid_wikipedia_article_url>

  -1|--valid_wikipedia_article_link    example: "https://en.wikipedia.org/wiki/House_Music"

EOF
}
