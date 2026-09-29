% PS1_Q2.m
% AEM 7500, Problem Set 1 - Problem 2
%
% Deterministic dynamic programming, finite horizon with T = 4. Solves for
% the value and policy functions at each t by backward induction, then
% simulates optimal K(t) and C(t) from K0 = 5 over the family's lifetime.
% Outputs: table results2; figure of optimal capital and consumption paths.
% Requires: base MATLAB.
% Line numbers cited in the write-up for Problem 2 refer to the line
% numbers of this file.

%% Problem 2c: solve for the value and policy functions at each t

% Setup
clearvars;
clc;

% Define variables and parameters
rho = 0.05;
beta = 1 / (1 + rho);
a = 48.05;
b = 3;

% Create k grids
num_k = 30;
num_kprime = 30;

k = (1:num_k)';
kprime = 1:num_kprime;

% Describe laws of problem
f_k = a*k - b*k.^2 / 2 + k;
c = f_k - kprime; % consumption for every pair
pii = log(c); % payoffs

T = 4;

% Initialize value function
v = zeros(num_k, T + 1);

% Value function at t=T
v_t(:, T+1) = log(a*k - b*k.^2/2 + k);

% Solve using backwards iteration
for t = T-1:-1:0
    % Initialize vv
    vv = pii + beta * v_t(:, t+2)';

    % Choose optimal actions
    [v_now, kprime_now] = max(vv, [], 2);
    v_t(:, t + 1) = v_now;
    kprime_t(:, t+1) = kprime_now;

end

% Print results in table
results2 = array2table([k, v_t, kprime_t], 'VariableNames', ...
    {'K','v_t0','v_t1','v_t2','v_t3','v_t4','K_t0','K_t1','K_t2','K_t3'})

%% Problem 2d: plot optimal trajectories

% Store capital in vector
k_path = zeros(T + 1, 1);
k_path(1) = 5; % start at k0 = 5

% Simulate the optimal capital path
for t = 0:T-1
    k_path(t + 2) = kprime_t(k_path(t+1), t+1);
end
k_path(T+1) = 0;

% Consumption from law of motion
c_path = f_k(k_path(1:T)) - k_path(2:T + 1);

% Plot optimal paths
t_k = 0:T;
t_c = 0:T-1;

figure
plot(t_k, k_path)
hold on
plot(t_c, c_path)
legend('Capital K', 'Consumption C')
xlabel('Time t')
title('Optimal Paths')
ylabel('Capital and consumption')
