function sigma = sigma_model(ccp, theta)
% SIGMA_MODEL  Model-predicted choice probabilities given theta.
%
% Forms the expected deterministic payoff Phi_bar_i(a_i, s) by integrating
% the flow payoff over rivals' first-stage CCPs, then maps it into choice
% probabilities via the extreme value (logit) formula.
%
% Inputs:  ccp, theta
% Outputs: sigma
%
% Called by: gmm_obj.m, nll_obj.m

% avg over what rival might do using CCPs
k = [0 1 2]'; % three actions
a_bar = [ccp(:,:,1)*k, ccp(:,:,2)*k];

% form sigma array
sigma = zeros(9, 3, 2);
v = zeros(1,3); % initialize v

% nested loops
for j = 1:9 %states
    for i = 1:2 % countries
        sR = floor((j-1)/3);
        sW = mod(j-1, 3);
        for kval = 0:2 % actions
            s_own   = sR*(i==1) + sW*(i==2);   % own cost state
            a_rival = a_bar(j, 3-i);           % rival's expected action

            phi = zeros(6,1);
            if kval > 0
                phi(1)   = -kval;
                phi(1+i) = -kval * a_rival;       % slot 2 for R, slot 3 for W
                phi(4)   = -(2-kval) * s_own;
            else
                phi(4+i) = -a_rival;           % slot 5 for R, slot 6 for W
            end

            v(kval+1) = phi' * theta;
        end
        sigma(j,:,i) = exp(v) / sum(exp(v)); % logit step
    end
end

end
