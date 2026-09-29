AEM 7500 - PROBLEM SET 1
Josephine Freis
READ_ME

--------------------------------------------------------------------------
CONTENTS
--------------------------------------------------------------------------

Freis_Josephine_PS1_answers.pdf   Write-up: all answers, equations,
                                         tables, and figures.

PS1_Q1.m    Problem 1 - Deterministic dynamic programming, infinite horizon.
PS1_Q2.m    Problem 2 - Deterministic dynamic programming, finite horizon (T = 4).
PS1_Q3.m    Problem 3 - Stochastic dynamic programming, infinite horizon.
PS1_Q4.m    Problem 4 - Stochastic dynamic programming, finite horizon (T = 4).

READ_ME.txt This file.

--------------------------------------------------------------------------
HOW TO RUN
--------------------------------------------------------------------------

Open MATLAB, set the current folder to the folder containing these files,
and run each file from the Editor or by typing its name (without the .m
extension) at the command prompt, e.g.

    >> PS1_Q1

Each file is self-contained. It clears the workspace, sets its own
parameter values, and can be run on its own in any order. Each file prints 
a results table to the Command Window and opens one figure.

--------------------------------------------------------------------------
WHAT EACH PROGRAM DOES
--------------------------------------------------------------------------

PS1_Q1.m  (Problem 1, parts e and f)
    Solves the deterministic infinite horizon problem by value function
    iteration over capital discretized to the integers 1 to 30, with
    next-period capital K' as the control. Iterates until the value
    function converges. Prints the table "results1" giving the value and
    policy functions as functions of K, then simulates and plots the
    optimal paths of capital and consumption over 20 periods starting
    from K0 = 5.

PS1_Q2.m  (Problem 2, parts c and d)
    Solves the deterministic finite horizon problem with T = 4 by backward
    induction. Sets the value function in the last period equal to the
    payoff from consuming all available resources, then iterates backwards
    from t = T-1 to t = 0. Prints the table "results2" giving the value
    and policy functions at each t as functions of K, then simulates and
    plots the optimal paths of capital and consumption over the family's
    lifetime starting from K0 = 5.

PS1_Q3.m  (Problem 3, parts d and e)
    Solves the stochastic infinite horizon problem, where the control is
    investment I and the law of motion is K' = I + epsilon, with epsilon
    taking the values -1, 0, and 1 with probabilities 0.25, 0.45, and
    0.30. Computes the expected continuation value by averaging the value
    function over the three possible realizations of K' and iterates until
    convergence. Prints the table "results3" giving the value and policy
    functions as functions of K, then simulates 5 shock paths of 200
    periods each and plots the resulting trajectories of capital,
    investment, consumption, and the shock, starting from K0 = 5.

PS1_Q4.m  (Problem 4, parts c and d)
    Solves the stochastic finite horizon problem with T = 4, with the same
    control and law of motion as Problem 3, by backward induction. Prints
    the table "results4" giving the value and policy functions at each t
    as functions of K, then simulates 5 shock paths and plots the
    resulting trajectories of capital, investment, consumption, and the
    shock over the family's lifetime, starting from K0 = 5.

--------------------------------------------------------------------------
PROBLEMS WITHOUT CODE
--------------------------------------------------------------------------

Problems 5, 6, 7, and 8 are written answers with no associated code. They
appear in the write-up only. The same is true of the non-computational
parts of Problems 1 through 4 (the Bellman equations, their
interpretations, and the interpretations of the results).

--------------------------------------------------------------------------
LINE NUMBER REFERENCES
--------------------------------------------------------------------------

The write-up explains each block of code by referring to specific line
numbers. Those line numbers refer to the .m file for the problem being
discussed. For example, a reference to lines 46-59 in the explanation of
Problem 3 refers to lines 46-59 of PS1_Q3.m.

--------------------------------------------------------------------------
REQUIREMENTS
--------------------------------------------------------------------------

PS1_Q1.m and PS1_Q2.m require only base MATLAB.

PS1_Q3.m and PS1_Q4.m additionally require the Statistics and Machine
Learning Toolbox, for the randsample function used to draw the shock
realizations.

Both PS1_Q3.m and PS1_Q4.m call rng(0) before drawing shocks, so the
simulated trajectories are reproducible and will match the figures in the
write-up exactly.

No external data files are used. All results are generated by the code.