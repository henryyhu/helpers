#!/usr/bin/env python

# @dpmehta02
# Create bag-of-words

import textmining

def main():
  # Initialize
  tdm = textmining.TermDocumentMatrix()
  
  for line in open('yelp_training_set_review.csv', 'r'):
    # Add each review
    tdm.add_doc(line)
    # Write out the matrix to a csv file. Note that setting cutoff=1 means
    # that words which appear in 1 or more documents will be included in
    # the output (i.e. every word will appear in the output). The default
    # for cutoff is 2, since we usually aren't interested in words which
    # appear in a single document.
    tdm.write_csv('matrix.csv', cutoff=2)

if __name__ == '__main__':
  main()