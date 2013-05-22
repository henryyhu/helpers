'''
From: http://blog.kaggle.com/2012/07/06/the-dangers-of-overfitting-psychopathy-post-mortem/

Some sample code

One of my best submissions (average precision = .86294) was actually one of my
own benchmarks that took very little thought. By stacking this with two other 
models (random forests and elastic net), I was able to get it up to .86334. 
Since the single model is pretty simple, I’ve included the code. After imputing
missing values in the training and test set with medians, I used the gbm package 
in R to fit a boosting model using every column in the data as predictor. The 
hyperparameters were not tuned at all, just some reasonable starting values. I 
used the internal cross-validation feature of gbm to choose the number of trees.
The full code from start to finish is below:
'''


library(gbm)

# impute.NA is a little function that fills in NAs with either means or medians
impute.NA <- function(x, fill="mean"){
  if (fill=="mean")
  {
    x.complete <- ifelse(is.na(x), mean(x, na.rm=TRUE), x)
  }

  if (fill=="median")
  {
    x.complete <- ifelse(is.na(x), median(x, na.rm=TRUE), x)
  }

  return(x.complete)
}

data <- read.table("Psychopath_Trainingset_v1.csv", header=T, sep=",")
testdata <- read.table("Psychopath_Testset_v1.csv", header=T, sep=",")

# Median impute all missing values
# Missing values are in columns 3-339
fulldata <- apply(data[,3:339], 2, FUN=impute.NA, fill="median")
data[,3:339] <- fulldata

fulltestdata <- apply(testdata[,3:339], 2, FUN=impute.NA, fill="median")
testdata[,3:339] <- fulltestdata

# Fit a generalized boosting model

# Create a formula that specifies that psychopathy is to be predicted using
# all other variables (columns 3-339) in the dataframe

gbm.psych.form <- as.formula(paste("psychopathy ~",
                                   paste(names(data)[c(3:339)], collapse=" + ")))

# Fit the model by supplying gbm with the formula from above.
# Including the train.fraction and cv.folds argument will perform
# cross-validation 

gbm.psych.bm.1 <- gbm(gbm.psych.form, n.trees=5000, data=data,
                      distribution="gaussian", interaction.depth=6,
                      train.fraction=.8, cv.folds=5)

# gbm.perf will return the optimal number of trees to use based on
# cross-validation. Although I grew 5,000 trees, cross-validation suggests that
# the optimal number of trees is about 4,332.

best.cv.iter <- gbm.perf(gbm.psych.bm.1, method="cv") # 4332

# Use the trained model to predict psychopathy from the test data. 

gbm.psych.1.preds <- predict(gbm.psych.bm.1, newdata=testdata, best.cv.iter)

# Package it in a dataframe and write it to a .csv file for uploading.

gbm.psych.1.bm.preds <- data.frame(cbind(myID=testdata$myID,
                                         psychopathy=gbm.psych.1.preds))

write.table(gbm.psych.1.bm.preds, "gbmbm1.csv", sep=",", row.names=FALSE)