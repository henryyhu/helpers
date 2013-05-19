#!/usr/bin/env python

# @dpmehta02
# Analyze text (CSV rows) for sentiment (negativity/positivity)
# Requires sentiment file (e.g., AFINN-111.txt: https://code.google.com/p/fb-moody/source/browse/trunk/AFINN/AFINN-111.txt?spec=svn2&r=2)
# USAGE: $ python review_sentiment.py <sentiment_file> <tweet_file>
# Generates scores in review_sentiments.txt

import sys
import csv
import re

def main():

  # load a tab delimited dict of sentiment scores
  afinnfile = open(sys.argv[1])
  scores = {}
  for line in afinnfile:
    term, score  = line.split("\t")
    scores[term] = int(score)

  csv_reviews = csv.reader(open(sys.argv[2], 'rb'))
  f = open('review_sentiments.txt', 'w')

  # load each line of text
  for line in csv_reviews:
    score = 0
    if line != []:
      text_line = line[0].split()
      for word in text_line:
        # only read alphanumeric words
        if re.match("^[A-Za-z0-9_-]*$", word):
          score += scores.get(word, 0)
    f.write("%i\n" % score)

if __name__ == '__main__':
  main()