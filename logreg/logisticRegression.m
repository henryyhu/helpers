%% Part 1: One-vs-all classification

%% Initialization
clear ; close all; clc

%% Setup the parameters you will use for this part of the exercise
%input_layer_size  = 400;  % 20x20 Input Images of Digits
num_labels = 51;          % 10 labels, from 1 to 10   
                          % (note that we have mapped "0" to label 10)

%% =========== Part 1: Loading Data =============

fprintf('Loading Data ...\n')

% Fields: votes_useful  r_days_active   r_length  u_avg_votes_useful  sentiment
% unused: order(created by me) r_exclamations  u_review_count
% add misspellings/grammar issues as categories?
data = csvread('train.csv');
X = data(1:170000,2:5);
y = data(1:170000,1);

testdata = csvread('test.csv');
Xtest = testdata(:,2:5);
ytest = testdata(:,1);

Xval = data(170001:213434,2:5);
yval = data(170001:213434,1);

% m = Number of examples
m = size(X, 1);

fprintf('Program paused. Press enter to train logistic regression.\n');
pause;

%% ============ Part 2: Vectorize Logistic Regression ============

fprintf('\nTraining One-vs-All Logistic Regression...\n')

lambda = 0;
[all_theta] = oneVsAll(X, y, num_labels, lambda);

pred = predictOneVsAll(all_theta, X);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

fprintf('Program paused. Press enter to generate Kaggle submission.\n');
pause;

%% ================ Part 3: Predict for One-Vs-All ================

pred_test = predictOneVsAll(all_theta, Xtest);
dlmwrite('KaggleSubmission.csv', pred_test, 'delimiter', ',', 'newline', '\n');
