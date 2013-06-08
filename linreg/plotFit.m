function plotFit(min_x, max_x, mu, sigma, theta, p, mu2, sigma2, mu3, sigma3, mu4, sigma4, Xtrain_one, Xtrain_two, Xtrain_four)
% PLOTFIT Plots a learned polynomial regression fit over an existing figure.
% Also works with linear regression.
%   PLOTFIT(min_x, max_x, mu, sigma, theta, p) plots the learned polynomial
%   fit with power p and feature normalization (mu, sigma).

% Hold on to the current figure
hold on;

% We plot a range slightly bigger than the min and max values to get
% an idea of how the fit will vary outside the range of the data points
x = (min_x - 15: 0.05 : max_x + 25)';

% Map the X values 
X_poly           = polyFeatures(x, p);
X_poly           = bsxfun(@minus,   X_poly,            mu);
X_poly           = bsxfun(@rdivide, X_poly,            sigma);
days_active_norm = bsxfun(@minus,   Xtrain_one,        mu2);
days_active_norm = bsxfun(@rdivide, days_active_norm,  sigma2);
length_norm      = bsxfun(@minus,   Xtrain_two,        mu3);
length_norm      = bsxfun(@rdivide, length_norm,       sigma3);
sentiment_norm   = bsxfun(@minus,   Xtrain_four,       mu4);
sentiment_norm   = bsxfun(@rdivide, sentiment_norm,    sigma4);
% Add ones
% why is X_poly 2974x3?
X_poly = [ones(size(x, 1), 1), X_poly, days_active_norm, length_norm, sentiment_norm];

% Plot
plot(x, X_poly * theta, '--', 'LineWidth', 2)

% Hold off to the current figure
hold off

end
