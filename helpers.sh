#!/bin/bash

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
  echo -e "\nArrival!  Took $(printGreen $steps) steps to get from $(printGreen "$startingTitle") to $(printBlue "$currentArticle") \n"
}
