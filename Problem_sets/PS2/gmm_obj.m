function Q = gmm_obj(theta, ccp, N, T)
% GMM_OBJ  Weighted GMM criterion function (Problem 4).
%
% Subprogram calculating the weighted moments. Forms the sample moment
% vector from the difference between observed choice indicators and the
% model-predicted choice probabilities, then returns the weighted sum of
% squares minimized over theta.
%
% Inputs:  theta, ccp, N (# periods in each state), T (total periods)
% Outputs: GMM objective
%
% Called by: PS2_Q4.m

diff = ccp - sigma_model(ccp, theta);   % residuals from predicted model, actual data

% weight by observations per state
g = (N/T) .* diff;

% drops for collinearity of action probability
g = g(:, 2:3, :);       % 9 x 2 x 2 = 36 moments
g = g(:); % 36 x 1

% collapse to a scalar
A = eye(36);
Q = g' * A * g;

end
