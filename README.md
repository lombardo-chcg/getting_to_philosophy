# Wikipedia:Getting to Philosophy bash solve

The "Getting To Philosophy" challenge in pure bash using a simple recursive function.

What is the challenge, you ask? 

> "Clicking on the first link in the main text of a Wikipedia article, and then repeating the process for subsequent articles, usually eventually gets one to the Philosophy article"

*[Wikipedia:Getting to Philosophy](https://en.wikipedia.org/wiki/Wikipedia:Getting_to_Philosophy)*

## Usage

```
./getting_to_philosophy.sh "https://en.wikipedia.org/wiki/House_Music"
```

## ToDos

* filter out non-italicized links ([example](https://en.wikipedia.org/wiki/Help:IPA_for_English))
* filter out links to the current page, or red links
* filter out a page with no links or a page that does not exist
* stop when a loop occurs
* verify it's a valid URL before running the code
* persist results and keep score
* refactor for simplicity and better readability
* QA testing.  run more edge cases (try to break it)
