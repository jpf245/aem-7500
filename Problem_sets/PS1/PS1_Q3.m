% PS1_Q3.m
% AEM 7500, Problem Set 1 - Problem 3
%
% Stochastic dynamic programming, infinite horizon, with investment I as the
% control and law of motion K' = I + eps. Solves by value function iteration,
% then simulates 5 shock paths and the optimal trajectories from K0 = 5.
% Outputs: table results3; figure of simulated trajectories.
% Requires: Statistics and Machine Learning Toolbox (randsample).
% Line numbers cited in the write-up for Problem 3 refer to the line
% numbers of this file.

%% Problem 3d: solve for the value and policy functions

% Setup
clearvars;
clc;

% Define variables and parameters
rho = 0.05;
beta = 1 / (1 + rho);
a = 48.05;
b = 2;

% Define shock distribution
eps_vals = [-1, 0, 1];
eps_probs = [0.25, 0.45, 0.30];

% Create I grid
Igrid = 2:29;

% Create k
num_k = 30;
k = (1:num_k)';

% Describe laws of problem
f_k = a*k - b*k.^2 / 2 + k;
c = f_k - Igrid; % consumption for every pair
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
    Ev = 0.25*v(Igrid-1) + 0.45*v(Igrid) + 0.30*v(Igrid + 1);
    vv = pii + beta * Ev';

    % For each k, choose kprime to maximize vv
    [v, I_pol] = max(vv, [], 2);

    % Calculate diff
    diff = max(abs(v - v_old));
end

% Convert policy index to investment level
I_star = reshape(Igrid(I_pol), [], 1);

% Print results in table
results3 = table(k, v, I_star, 'VariableNames', {'State', 'Value', 'Policy'})

%% Problem 3e: simulate and plot optimal trajectories

% Pick number of periods and simulations
T = 200;
sims = 5;

% Set seed for reproducibility
rng(0);

% Simulate random draws of epsilon
epsval = [-1, 0, 1];
epsprob = [0.25, 0.45, 0.30];

eps_sim = zeros(T, sims);
for s = 1:sims
    eps_sim(:, s) = randsample(epsval, T, true, epsprob);
end

% Store capital and investment in vectors
k_path = zeros(T + 1, sims);
I_path = zeros(T, sims);

k_path(1, :) = 5; % start at K0 = 5

% Simulate the optimal paths
for s = 1:sims
    for t = 1:T
        I_path(t, s) = Igrid(I_pol(k_path(t, s))); % policy returns grid index
        k_path(t + 1, s) = I_path(t, s) + eps_sim(t, s);
    end
end

% Consumption from law of motion
c_path = f_k(k_path(1:T, :)) - I_path;

% Plot optimal paths
t_k = 0:T;
t_c = 0:T-1;

figure
subplot(4,1,1); plot(t_k, k_path); ylabel('K(t)'); title('Simulated Trajectories')
subplot(4,1,2); plot(t_c, I_path); ylabel('I(t)')
subplot(4,1,3); plot(t_c, c_path); ylabel('C(t)')
subplot(4,1,4); plot(t_c, eps_sim(:, 1)); ylabel('\epsilon(t)')
xlabel('Time t')
