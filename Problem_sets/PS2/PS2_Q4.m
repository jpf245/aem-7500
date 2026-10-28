% PS2_Q4.m
% AEM 7500, Problem Set 2 - Problem 4
%
% Estimation of theta = (beta0, beta1R, beta1W, beta2, beta3R, beta3W) by
% Generalized Method of Moments (GMM), with bootstrapped standard errors.
% Outputs: theta_gmm & se_gmm
% Requires: ccp_nonparam.m, sigma_model.m, gmm_obj.m
% Line numbers cited in the write-up for Problem 4

%% Setup
% clear console
clearvars;
close all;
clc;

% load data from AEM7500_PS2_data_fall2026.xlsx
raw = readmatrix('AEM7500_PS2_data_fall2026.xlsx');
a = raw(:,1:2);  s = raw(:,3:4);

%% Problem 4b: estimate theta by GMM
% first-stage CCPs and state counts
ccp = ccp_nonparam(a, s);
s_idx = 3*s(:,1) + s(:,2) + 1;
N = accumarray(s_idx, 1, [9 1]);
T = size(a,1);

% minimize the GMM objective from multiple starting values
opts = optimset('MaxFunEvals', 1e5, 'MaxIter', 1e5);
f = @(th) gmm_obj(th, ccp, N, T);

rng(0);
nstart = 20;
best = inf;
for r = 1:nstart
    th0 = randn(6,1);
    [th, fv] = fminsearch(f, th0, opts);
    if fv < best
        best = fv;
        theta_gmm = th;
    end
end
theta_gmm;

%% Problem 4c: bootstrap the standard errors
n_b = 200;              % number of bootstrap replications
boot = zeros(6, n_b);
n_reject = 0;           % resamples discarded for empty state cells

rng(1); % set range for reproducibility, no conflict with previous q

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

    % new GMM
    f_bt = @(th) gmm_obj(th, ccp_bt, N_bt, T);
    [theta_bt, ~, ef] = fminsearch(f_bt, theta_gmm, opts);
    boot(:, b) = theta_bt;

end

% take the standard deviation of the bootstrap estimates
se_gmm = std(boot, 0, 2);

%% Problem 4d: results table
% build and print the table of GMM estimates and standard errors
pname = {'beta0';'beta1R';'beta1W';'beta2';'beta3R';'beta3W'};

res4 = table(pname, theta_gmm, se_gmm, ...
    'VariableNames', {'Parameter','Estimate','Bootstrap_SE'});