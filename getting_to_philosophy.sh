#!/bin/bash

# Clicking on the first non-parenthesized, non-italicized link
# Ignoring external links, links to the current page, or red links
# Stopping when reaching "Philosophy", a page with no links or a page that does not exist, or when a loop occurs

source helpers.sh

[[ "$1" ]] || { usage; exit 1; }

stepNumber=0
wikipediaBaseUrl="https://en.wikipedia.org"

startingTitle=$(curl -s $1 | extractHtmlTitleValue )

getNextArticle() {

  echo -e "\n*************"
  site="$1"
  stepNumber=$2

  curl -s $site > temp

  title=$(cat temp | extractHtmlTitleValue)

  [[ ${title} == "Philosophy"  ]] && { printSuccessMessage $title $stepNumber; exit 0; }

  echo -e "Current article is $(printGreen "$title") \nthis is step number $(printGreen $stepNumber)"

  validLinks=$(cat temp | removeTextInParentheses | getFirstWikipediaInternalLink)

  arrayOfValidLinks=($validLinks)

  firstLink=$(echo ${arrayOfValidLinks[0]})

  strippedLink=$(echo $firstLink \
    | sed "s/href=\"//" \
    | sed "s/\"//"
  )

  nextPage="$wikipediaBaseUrl$strippedLink"

  echo -e "\nnext step is $(printBlue $nextPage)"
  let stepNumber=stepNumber+1

  getNextArticle "$nextPage" $stepNumber
}

getNextArticle "$1" 0
