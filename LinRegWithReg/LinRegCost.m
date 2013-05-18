%% Linear regression with multiple variables
%% @dpmehta02 - adapted from Coursera's Machine Learning Course

%% ================ Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Train Data [UPDATE THIS SECTION FOR EACH PROJECT] - Comma Separated, no Headers
data = load('ex1data2.txt');
X = data(:, 1:2); % Input variables
y = data(:, 3); % Outcomes
m = length(y);

% Print out 10 data points
fprintf('First 10 examples: \n');
fprintf(' x = [%.0f %.0f], y = %.0f \n', [X(1:10,:) y(1:10,:)]');

fprintf('Program paused. Press enter to continue.\n');
pause;

% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');

[X mu sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];

%% ================ Gradient Descent ================

fprintf('Running gradient descent ...\n');

% Choose some alpha value [UPDATE THESE VALUES UNTIL COST FUNCTION CONVERGES QUICKLY]
alpha = .01;
num_iters = 400;

% Init Theta and Run Gradient Descent 
theta = zeros(3, 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');

% Estimate the outcome of a random input (sanity check) -- OPTIONAL
% Recall that the first column of X is all-ones. Thus, it does
% not need to be normalized.

%t=[1650, 3];
%price = [1, (t - mu) ./ sigma] * theta;

%fprintf(['Predicted outcome based on the input params' ...
%         'you selected (using gradient descent):\n $%f\n'], price);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================ Normal Equations ================

fprintf('Solving with normal equations...\n');

%% Load Data [UDPATE]
data = csvread('ex1data2.txt');
X = data(:, 1:2);
y = data(:, 3);
m = length(y);

% Add intercept term to X
X = [ones(m, 1) X];

% Calculate the parameters from the normal equation
theta = normalEqn(X, y);

% Display normal equation's result
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');


% Estimate the same outcome as Gradient Descent to compare [OPTIONAL]

%t=[1650, 3];
%price = [1, t] * theta;

%fprintf(['Predicted outcome based on input params ' ...
%         '(using normal equations):\n $%f\n'], price);

