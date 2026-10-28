% PS2_Q5.m
% AEM 7500, Problem Set 2 - Problem 5
%
% Estimation of theta = (beta0, beta1R, beta1W, beta2, beta3R, beta3W) by
% Maximum Likelihood Estimation (MLE), with bootstrapped standard errors.
% Outputs: theta_mle & se_mle
% Requires: nll_obj.m
% Line numbers cited in the write-up for Problem 5 refer to the line
% numbers of this file.

%% Setup
% clear console
clearvars;
close all;
clc;

% load data from AEM7500_PS2_data_fall2026.xlsx
raw = readmatrix('AEM7500_PS2_data_fall2026.xlsx');
a = raw(:,1:2);  s = raw(:,3:4);

%% Problem 5a: negative log likelihood subprogram
% see nll_obj.m

%% Problem 5b: estimate theta by MLE
% first-stage CCPs and state counts
ccp = ccp_nonparam(a, s);
s_idx = 3*s(:,1) + s(:,2) + 1;
N = accumarray(s_idx, 1, [9 1]);
T = size(a,1);

% minimize the MLE objective from multiple starting values
opts = optimset('MaxFunEvals', 1e5, 'MaxIter', 1e5);
f = @(th) nll_obj(th, ccp, N);

rng(0);
nstart = 20;
best = inf;
for r = 1:nstart
    th0 = randn(6,1);
    [th, fv] = fminsearch(f, th0, opts);
    if fv < best
        best = fv;
        theta_mle = th;
    end
end
theta_mle;

%% Problem 5c: bootstrap the standard errors
n_b = 200;              % number of bootstrap replications
boot = zeros(6, n_b);
n_reject = 0;           % resamples discarded for empty state cells

rng(1); % set range for comparison with Q4

for b = 1:n_b
    % draw resamples until every state cell is occupied
    valid = false;
    while ~valid
        % draw T row indices from 1:T with replacement
        idx  = ceil(T * rand(T,1));
        a_bt = a(idx, :);
        s_bt = s(idx, :);

        % new ccps
        ccp_bt = ccp_nonparam(a_bt, s_bt);

        valid = ~any(isnan(ccp_bt(:)));
        if ~valid
            n_reject = n_reject + 1;
        end
    end

    s_idx_bt = 3*s_bt(:,1) + s_bt(:,2) + 1; % same as before
    N_bt = accumarray(s_idx_bt, 1, [9 1]);

    % new MLE
    f_bt = @(th) nll_obj(th, ccp_bt, N_bt);
    [theta_bt, ~, ef] = fminsearch(f_bt, theta_mle, opts);
    boot(:, b) = theta_bt;

end

% take the standard deviation of the bootstrap estimates
se_mle = std(boot, 0, 2);

%% Problem 5d: results table
pname = {'beta0';'beta1R';'beta1W';'beta2';'beta3R';'beta3W'};
res5 = table(pname, theta_mle, se_mle, ...
    'VariableNames', {'Parameter','Estimate','Bootstrap_SE'})