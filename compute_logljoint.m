function [LJ,yBOLD] = compute_logljoint(yData, U, P, pHRF, sigmaNoise, priorP)
pp = [P.A(:);P.B(:);P.C(:)];
ppPrior = priorP.mu;

indPrior = find(diag(priorP.C));
nPrior = length(indPrior);

pp = pp(indPrior);
ppPrior = ppPrior(indPrior);
covPrior = priorP.C(indPrior,indPrior);

if length(yData(1,:))~=length(U.u(1,:))
    error('Data dimensions do not agree.');
else
    yBOLD = euler_integrate(U,P,pHRF);
    yDiff = (yBOLD -yData)';
    yDiff = yDiff(:);
    n = length(yDiff);
    LJ = -0.5/(sigmaNoise^2)*yDiff'*yDiff-n*log(sigmaNoise)-n/2*log(2*pi)-0.5*log(sqrt(prod(diag(covPrior))))-nPrior/2*log(2*pi)-0.5*(ppPrior-pp)'*inv(covPrior)*(ppPrior-pp);
end
end
