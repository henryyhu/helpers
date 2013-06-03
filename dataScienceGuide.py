#!/usr/bin/env python

# A command line tool that guides a user through algorithm selection
# Used primarily for Kaggle competitions, partially inspired by: https://kaggle2.blob.core.windows.net/prospector-files/1091/815dad0d-88d9-4b70-9117-fe7cee94879b/scikitlearn.pdf
# Dev Mehta / dpmehta02@gmail.com / @dpmehta02
# Free; please attibute
# Please use it to make the world a better place
# Made in San Francisco, with love

# finish with https://kaggle2.blob.core.windows.net/prospector-files/1091/815dad0d-88d9-4b70-9117-fe7cee94879b/scikitlearn.pdf


# Non-binary classification problem with few parameters, one-vs-all logistic regression
# Non-binary classification problem with many parameters, one-vs-all neural network


def main():
	print '''
By @dpmehta02
This is a command line script that guides a user through algorithm
selection (and links to code skeletons) for data science projects.
All algorithms are available in the scikitlearn python library.

ALL ANSWERS ARE INPUT AS "yes" or "no" (case sensitive).

Let's get started.
'''
	q1 = raw_input("Do you have more than 50 samples in your dataset? ")
	if q1 == 'no':
		print "Need more data. Nothing to do here."
		return
	elif q1 == 'yes':
		q2 = raw_input("Are you predicting a category? ")
		if q2 == 'yes':
			q3 = raw_input("Do you have labeled data? ")
			if q3 == 'yes':
				print "\nThis is a CLASSIFICATION problem.\n"
				q4 = raw_input("Do you have more than 100k data points? ")
				if q4 == 'yes':
					print "Use Linear SVC: http://scikit-learn.org/dev/modules/generated/sklearn.svm.LinearSVC.html"
					q5 = raw_input("Did Linear SVC work? ")
		if q2 == 'no':
			q3 = raw_input("Are you predicting a quantity? ")



if __name__ == '__main__':
	main()




'''
1. Run simple Regression
2. plot learning curves (error against training set size) using 10-fold cross validation
	if high bias, add features, make polynomial, decrease ridge lambda
	if high variance, opposite, get more training examples, increase ridge lambda
3. Error analysis:  Manually examine the examples (in cross validation set) 
		that your algorithm made errors on. See if you spot any systematic trend 
		in what type of examples it is making errors on.

scale features if order of magnitude higher
'''