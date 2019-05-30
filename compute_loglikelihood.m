function [LL,yBOLD] = compute_loglikelihood(yData, U, P, pHRF, sigmaNoise)
   
% This function computes the log likelihood given data yData as input, a
% set of parameters, and a noise level.

if length(yData(1,:))~=length(U.u(1,:))
    error('Data dimensions do not agree.');
else 
    yBOLD = euler_integrate(U,P,pHRF);
    yDiff = (yBOLD - yData)';
    yDiff = yDiff(:);
    n = length(yDiff);
    
    LL = -0.5/(sigmaNoise^2)*yDiff'*yDiff-n*log(sigmaNoise)-n/2*log(2*pi);
end
end
