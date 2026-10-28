function nll = nll_obj(theta, ccp, N)
% NLL_OBJ  Negative log likelihood (Problem 5).
%
% Subprogram calculating the negative log likelihood, where
%   L(theta) = sum_i sum_t ln( sigma_i( a_it | s_t, Phibar^e, theta ) ).
% Returns -L(theta) so that it can be passed to a minimizer.
%
% Inputs:  theta, ccp, N
% Outputs: nll
%
% Called by: PS2_Q5.m

% model predicted probs at this theta
sigma = sigma_model(ccp, theta);

% build observed counts
obs = ccp.*N;

% log likelihood
like = sum(obs(:) .* log(max(sigma(:), realmin)));
nll = -like;

end