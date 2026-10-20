% PS2_Q5.m
% AEM 7500, Problem Set 2 - Problem 5
%
% Estimation of theta = (beta0, beta1R, beta1W, beta2, beta3R, beta3W) by
% Maximum Likelihood Estimation (MLE), with bootstrapped standard errors.
% Outputs: TODO
% Requires: TODO
% Line numbers cited in the write-up for Problem 5 refer to the line
% numbers of this file.

%% Setup

clearvars;
close all;
clc;

% TODO: load data from AEM7500_PS2_data_fall2026.xlsx


%% Problem 5a: negative log likelihood subprogram

% No code here. The subprogram is nll_obj.m; see that file.


%% Problem 5b: estimate theta by MLE

% TODO: first-stage CCPs via ccp_nonparam.m
% TODO: minimize nll_obj.m over theta
% TODO: print parameter estimates


%% Problem 5c: bootstrap the standard errors

% TODO: set rng seed for reproducibility
% TODO: resample, re-estimate CCPs and theta in each bootstrap replication
% TODO: take the standard deviation of the bootstrap estimates


%% Problem 5d: results table

% TODO: build and print the table of MLE estimates and standard errors
