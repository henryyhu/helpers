function [error_train, error_val] = ...
    learningCurve(X, y, Xval, yval, lambda)
% LEARNINGCURVE Generates the train and cross validation set errors needed 
% to plot a learning curve
%   [error_train, error_val] = ...
%       LEARNINGCURVE(X, y, Xval, yval, lambda) returns the train and
%       cross validation set errors for a learning curve. In particular, 
%       it returns two vectors of the same length - error_train and 
%       error_val. Then, error_train(i) contains the training error for
%       i examples (and similarly for error_val(i)).
%
%   When working with large datasets, train in large intervals.

m = size(X, 1);

error_train = zeros(m, 1);
error_val   = zeros(m, 1);

% for every j cases (1:j:m, can adjust to be more/less precise)
for i = 1:10000:m

	% for each training step, the training set must contains 1 to m 
	Xtrain = X(1:i,:);
	ytrain = y(1:i);

	% calc the theta
	theta = trainLinearReg(Xtrain, ytrain, lambda);	

	%Compute train/cross validation errors using training examples
	[Jtrain,grad_train]=linearRegCostFunction(Xtrain,ytrain,theta,0); 
	[Jval,grad_val]=linearRegCostFunction(Xval,yval,theta,0);

    %store the results
    error_train(i) = Jtrain;  
    error_val(i) = Jval;

end

end
