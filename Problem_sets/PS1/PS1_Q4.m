% PS1_Q4.m
% AEM 7500, Problem Set 1 - Problem 4
%
% Stochastic dynamic programming, finite horizon with T = 4, with investment
% I as the control and law of motion K' = I + eps. Solves by backward
% induction, then simulates 5 shock paths and trajectories from K0 = 5.
% Outputs: table results4; figure of simulated trajectories.
% Requires: Statistics and Machine Learning Toolbox (randsample).
% Line numbers cited in the write-up for Problem 4 refer to the line
% numbers of this file.

%% Problem 4c: solve for the value and policy functions at each t

% Setup
clearvars;
clc;

% Define variables and parameters
rho = 0.05;
beta = 1 / (1 + rho);
a = 48.05;
b = 2;

% Define shock distribution
epsval = [-1, 0, 1];
epsprob = [0.25, 0.45, 0.30];

% Create I grid
Igrid = 2:29;

% Create k
num_k = 30;
k = (1:num_k)';

% Number of periods
T = 4;

% Describe laws of problem
f_k = a*k - b*k.^2 / 2 + k;
c = f_k - Igrid; % consumption for every pair
pii = log(c); % payoffs

% Initialize value and policy functions
v_t = zeros(num_k, T + 1);
I_t = zeros(num_k, T);

% Value function at t = T: consume all available resources
v_t(:, T+1) = log(f_k);

% Solve using backwards iteration
for t = T-1:-1:0
    % Expected continuation value for each I
    v_next = v_t(:, t+2);
    Ev = epsprob(1)*v_next(Igrid-1) + epsprob(2)*v_next(Igrid) ...
        + epsprob(3)*v_next(Igrid+1);
    vv = pii + beta * Ev';

    % For each k, choose I to maximize vv
    [v_now, I_now] = max(vv, [], 2);
    v_t(:, t+1) = v_now;
    I_t(:, t+1) = reshape(Igrid(I_now), [], 1); % convert index to level
end

% Print results in table
results4 = array2table([k, v_t, I_t], 'VariableNames', ...
    {'K','v_t0','v_t1','v_t2','v_t3','v_t4','I_t0','I_t1','I_t2','I_t3'})

%% Problem 4d: simulate and plot optimal trajectories

% Set seed for reproducbility
rng(0);

% Simulate random draws of epsilon
sims = 5;
eps_sim = zeros(T + 1, sims);
for s = 1:sims
    eps_sim(:, s) = randsample(epsval, T + 1, true, epsprob);
end

% Store capital, investment, and consumption in vectors
k_path = zeros(T + 1, sims);
I_path = zeros(T, sims);
c_path = zeros(T + 1, sims);

k_path(1, :) = 5; % start at K0 = 5

% Simulate the optimal paths
for s = 1:sims
    for t = 0:T-1
        I_path(t+1, s) = I_t(k_path(t+1, s), t+1);
        k_path(t+2, s) = I_path(t+1, s) + eps_sim(t+1, s);
    end
end

% Consumption from law of motion, all resources consumed at t = T
c_path(1:T, :) = f_k(k_path(1:T, :)) - I_path;
c_path(T+1, :) = reshape(f_k(k_path(T+1, :)), 1, []);

% Plot optimal paths
t_all = 0:T;
t_dec = 0:T-1;

figure
subplot(4,1,1); plot(t_all, k_path, '-o'); ylabel('K(t)'); title('Simulated Trajectories, Finite Horizon')
subplot(4,1,2); plot(t_dec, I_path, '-o'); ylabel('I(t)')
subplot(4,1,3); plot(t_all, c_path, '-o'); ylabel('C(t)'); ylim([150 620])
subplot(4,1,4); plot(t_all, eps_sim, '-o'); ylabel('\epsilon(t)')
xlabel('Time t')
