AEM 7500 - PROBLEM SET 2
Josephine Freis
READ_ME

--------------------------------------------------------------------------
CONTENTS
--------------------------------------------------------------------------

Freis_Josephine_PS2_answers.pdf   Write-up: all answers, equations,
                                         tables, and figures.

PS2_Q3.m    Problem 3 - Nonparametric estimation of the conditional choice
                        probabilities.
PS2_Q4.m    Problem 4 - Generalized Method of Moments (GMM) estimation,
                        with bootstrapped standard errors.
PS2_Q5.m    Problem 5 - Maximum Likelihood Estimation (MLE), with
                        bootstrapped standard errors.

ccp_nonparam.m  Function. Estimates the first-stage conditional choice
                probabilities by empirical frequency.
sigma_model.m   Function. Forms the model-predicted choice probabilities
                for a candidate theta.
gmm_obj.m       Function. Calculates the weighted GMM moments and returns
                the criterion as a scalar.
nll_obj.m       Function. Calculates the negative log likelihood.

AEM7500_PS2_data_fall2026.xlsx   Data file. 374 periods. Columns are
                pollution emitted by Red, pollution emitted by White, cost
                of abatement in Red, and cost of abatement in White.

READ_ME.txt This file.

--------------------------------------------------------------------------
HOW TO RUN
--------------------------------------------------------------------------

Open MATLAB, set the current folder to the folder containing these files,
and run each file from the Editor or by typing its name (without the .m
extension) at the command prompt, e.g.

    >> PS2_Q3

Each of the three numbered files is self-contained. It clears the
workspace, reads the data file, and can be run on its own in any order.
Each prints a results table to the Command Window.

The four function files are called by the numbered files and are not run
directly. They must be in the same folder, or otherwise on the MATLAB
path, for the numbered files to run. The data file must also be in the
same folder.

PS2_Q4.m and PS2_Q5.m each run 200 bootstrap replications, with one
optimization per replication, and take a few minutes to finish.

--------------------------------------------------------------------------
WHAT EACH PROGRAM DOES
--------------------------------------------------------------------------

PS2_Q3.m  (Problem 3)
    Estimates the conditional choice probabilities nonparametrically as
    empirical frequencies, conditioning on the full state pair (s_R, s_W).
    The nine states are indexed by j = 3*s_R + s_W + 1. Calls
    ccp_nonparam.m and prints the table "res3", giving the number of
    observations and the six choice probabilities for each state.

PS2_Q4.m  (Problem 4, parts b, c, and d)
    Estimates theta by GMM. Calls ccp_nonparam.m for the first-stage
    choice probabilities, then minimizes gmm_obj.m over theta using
    fminsearch from 20 random starting values, keeping the estimate that
    attains the lowest criterion value. Bootstraps the standard errors
    over 200 replications, re-estimating both the choice probabilities
    and theta within each replication. Prints the table "res4", giving
    the point estimates and bootstrap standard errors.

PS2_Q5.m  (Problem 5, parts b, c, and d)
    Estimates theta by MLE. Identical in structure to PS2_Q4.m, but
    minimizes nll_obj.m in place of gmm_obj.m. Uses the same bootstrap
    seed as PS2_Q4.m so that both estimators are bootstrapped on
    identical resamples. Prints the table "res5", giving the point
    estimates and bootstrap standard errors.

ccp_nonparam.m
    Takes the T x 2 matrices of actions and states and returns a
    9 x 3 x 2 array of choice probabilities, indexed by state, action,
    and country. A state with no observations returns NaN.

sigma_model.m
    Takes the choice probabilities and a candidate theta and returns a
    9 x 3 x 2 array of model-predicted choice probabilities. Forms the
    expected payoff vector Phi_bar_i(a_i, s) using each country's
    expected action, then applies the extreme value logit formula.

gmm_obj.m
    Takes theta, the choice probabilities, the state counts, and the
    number of periods, and returns the GMM criterion as a scalar. Forms
    36 moments by differencing the empirical and model-predicted choice
    probabilities, weighting by each state's share of the sample, and
    dropping the residual for action 0 in each country and state.

nll_obj.m
    Takes theta, the choice probabilities, and the state counts, and
    returns the negative log likelihood as a scalar.

--------------------------------------------------------------------------
PROBLEMS WITHOUT CODE
--------------------------------------------------------------------------

Problems 1, 2, 4a, 6, 7, 8, and 9 are written answers with no associated
code. They appear in the write-up only. The same is true of the
interpretations of the results in Problems 3, 4d, and 5d, although the
tables those interpretations refer to are produced by the code.

--------------------------------------------------------------------------
LINE NUMBER REFERENCES
--------------------------------------------------------------------------

The write-up explains each block of code by referring to specific line
numbers. Those line numbers refer to the file named in the sentence in
which they appear. Where a sentence refers to one of the function files,
the line numbers are those of that function file and not of the numbered
file that calls it.

--------------------------------------------------------------------------
REQUIREMENTS
--------------------------------------------------------------------------

All files require only base MATLAB. No toolboxes are needed. In
particular, the bootstrap resampling is done with rand and ceil rather
than with boot, datasample, or randsample.

PS2_Q4.m and PS2_Q5.m call rng(0) before drawing the random starting
values for the optimizer and rng(1) before drawing the bootstrap
resamples, so all reported estimates and standard errors are
reproducible and will match the write-up exactly.

Both files discard any bootstrap resample in which one or more of the
nine state cells is empty, since the choice probabilities are undefined
in that case. State 9, in which both countries face a high cost of
abatement, contains only 5 of the 374 periods, so this occurs
occasionally. The number of discarded resamples is stored in n_reject.
