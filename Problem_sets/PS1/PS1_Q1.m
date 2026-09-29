% PS1_Q1.m
% AEM 7500, Problem Set 1 - Problem 1
%
% Deterministic dynamic programming, infinite horizon. Solves for the value
% and policy functions by value function iteration over capital discretized
% to integers 1-30, then simulates optimal K(t) and C(t) starting from K0 = 5.
% Outputs: table results1; figure of optimal capital and consumption paths.
% Requires: base MATLAB.
% Line numbers cited in the write-up for Problem 1 refer to the line
% numbers of this file.

%% Problem 1e: solve for the value and policy functions

% Setup
clearvars;
close all;
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

% Initialize for loop
v = zeros(num_k, 1);
ep = 1e-6;
diff = 1;

% Solve
while diff > ep
    % Reset v to be the previous version
    v_old = v;

    % value of v
    vv = pii + beta * v';

    % For each k, choose kprime to maximize vv
    [v, kprime_pol] = max(vv, [], 2);

    % Calculate diff
    diff = max(abs(v - v_old));
end

% Print results in table
results1 = table(k, v, kprime_pol, 'VariableNames', {'State', 'Value', 'Policy'})

%% Problem 1f: plot optimal trajectories

% Pick number of periods
T = 20;

% Store capital in vector
k_path = zeros(T + 1, 1);
k_path(1) = 5; % start at k0 = 5

% Simulate the optimal capital path
for t = 1:T
    k_path(t + 1) = kprime_pol(k_path(t));
end

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
