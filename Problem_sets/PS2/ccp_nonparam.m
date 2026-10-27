function ccp = ccp_nonparam(a, s)
% CCP_NONPARAM  Nonparametric first-stage conditional choice probabilities.
%
% Estimates sigma_i(a_i = k | s) by empirical frequency, separately for
% each country i, each action k, and each state s = (s_R, s_W). No
% functional form is imposed; each probability is a sample proportion.
%
% Inputs:
%   a    T x 2 matrix of actions,  [a_R a_W],  each in {0,1,2}
%   s    T x 2 matrix of states,   [s_R s_W],  each in {0,1,2}
%
% Output:
%   ccp  9 x 3 x 2 array. ccp(j,k+1,i) is the estimated probability that
%        country i chooses action k in state j, where the state index is
%        j = 3*s_R + s_W + 1, so that j runs (0,0),(0,1),(0,2),(1,0),...,(2,2).
%        Empty state cells return NaN.
%
% Called by: PS2_Q3.m, PS2_Q4.m, PS2_Q5.m

n_s = 9;
n_a = 3;
n_i = 2;

% Collapse the state pair (s_R, s_W) into a single index 1-9
s_idx = 3*s(:,1) + s(:,2) + 1;

% Initialize
ccp = nan(n_s, n_a, n_i);

for j = 1:n_s

    % logical index of the periods in which the state equals j
    instate = (s_idx == j);

    for i = 1:n_i
        for k = 0:n_a-1

            % empirical probability that country i chooses k,
            % among the periods in state j
            ccp(j, k+1, i) = sum(a(instate, i) == k) / sum(instate);

        end
    end
end

end
