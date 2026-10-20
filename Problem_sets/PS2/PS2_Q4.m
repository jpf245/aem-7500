% PS2_Q4.m
% AEM 7500, Problem Set 2 - Problem 4
%
% Estimation of theta = (beta0, beta1R, beta1W, beta2, beta3R, beta3W) by
% Generalized Method of Moments (GMM), with bootstrapped standard errors.
% Outputs: TODO
% Requires: TODO
% Line numbers cited in the write-up for Problem 4 refer to the line
% numbers of this file.

%% Setup

clearvars;
close all;
clc;

% TODO: load data from AEM7500_PS2_data_fall2026.xlsx


%% Problem 4a: moment condition

% No code. Written answer in the write-up: statement of the moment
% condition and the number of moments.


%% Problem 4b: estimate theta by GMM

% TODO: first-stage CCPs via ccp_nonparam.m
% TODO: minimize gmm_obj.m over theta
% TODO: print parameter estimates


%% Problem 4c: bootstrap the standard errors

% TODO: set rng seed for reproducibility
% TODO: resample, re-estimate CCPs and theta in each bootstrap replication
% TODO: take the standard deviation of the bootstrap estimates


%% Problem 4d: results table

% TODO: build and print the table of GMM estimates and standard errors
