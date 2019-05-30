function [priorP] = tn_get_priors_new(priorVariance)

if nargin < 2
    priorVariance = 0.1;
end
priorP.mu = zeros(27,1);
% param_vect = ones(27,1);
param_vect = [0 0 1 0 0 1 1 1 0 0 0 1 0 0 1 0 0 0 1 0 0 0 1 0 0 0 0]; 
priorP.C = priorVariance*diag(param_vect);

