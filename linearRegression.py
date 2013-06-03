#!usr/bin/env python

# Dev Mehta @dpmehta02
# Linear Regression with Regularization using scikit learn

from sklearn import cross_validation
import logloss
import numpy as np

def main():
  # read data, parse into training and target sets
  dataset = np.genfromtxt(open('train.csv','r'), delimiter=',', dtype='f8')[1:]    
  target = np.array([x[0] for x in dataset])
  inputs = np.array([x[1:] for x in dataset])

  # train regression
  cfr = RandomForestClassifier(n_estimators=100)

  # 10-fold cross validation
  cv = cross_validation.KFold(len(inputs), k=10, indices=False)

  # iterate through the training and test cross validation segments and
  # run the classifier on each one, aggregating the results into a list
  results = []
  for traincv, testcv in cv:
    probas = cfr.fit(inputs[traincv], target[traincv]).predict_proba(inputs[testcv])
    results.append( logloss.llfun(target[testcv], [x[1] for x in probas]) )

  # mean of cross-validated results
  print "Results: " + str( np.array(results).mean() )






























if __name__=="__main__":
  main()