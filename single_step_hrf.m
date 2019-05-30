function [dhdt] = single_step_hrf(h, x, P, pHRF)
%computes the update for the hemodynamic model of a single region
%h = [s,f,v,q], the hemodynamic state vector
%x = neural state of the region at time t
%fields of pHRF  is fixed
%HRF = hemodynamic response function 

%If parameters of HRF need to be inferredm the values in pHRF are
%multiplied with a log normal paramtere
kappa = exp(P.kappa) * pHRF.kappa;
tau = exp(P.tau) * pHRF.tau;
gamma = exp(P.gamma) * pHRF.gamma;
alpha = exp(P.alpha) * pHRF.alpha;
E0 = exp(P.E0) * pHRF.E0;

%4 differential equations which define the hemodynamic update
dhdt = zeros(size(h));
dhdt(1) =  x - kappa*h(1) - gamma *(h(2)-1);
dhdt(2) = h(1);
dhdt(3) = (h(2) - h(3)^(1/alpha))/tau;
dhdt(4) = (h(2)* (1-(1-E0)^(1/h(2)))/ E0 - h(3)^(1/alpha-1)*h(4))/tau; % looks like a re-arragement of the slide equation, haven't checked
end
