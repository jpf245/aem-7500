% PS2_Q3.m
% AEM 7500, Problem Set 2 - Problem 3
%
% Nonparametric estimation of the conditional choice probabilities (CCPs)
% for the static pollution game using empirical frequencies
% Outputs: CCP table
% Requires: AEM7500_PS2_data_fall2026.xlsx
% Line numbers cited in the write-up for Problem 3

%% Setup
% clear console
clearvars;
close all;
clc;

% load data from AEM7500_PS2_data_fall2026.xlsx
raw = readmatrix('AEM7500_PS2_data_fall2026.xlsx');
a = raw(:,1:2);  s = raw(:,3:4);

%% Problem 3: estimate the choice probabilities nonparametrically
% call ccp_nonparam.m
ccp = ccp_nonparam(a, s);

%% Problem 3: results table
% state labels
j = (1:9)';
sR = floor((j-1)/3);
sW = mod(j-1, 3);
% cell counts
s_idx = 3*s(:, 1) + s(:, 2) + 1;
N = accumarray(s_idx, 1, [9 1]);

% 3D to 2D array
M = [j, sR, sW, N, ccp(:,:,1), ccp(:,:,2)];

% Print results in table
res3 = array2table(M, 'VariableNames', ...
    {'State','s_R','s_W','N','R_a0','R_a1','R_a2','W_a0','W_a1','W_a2'})