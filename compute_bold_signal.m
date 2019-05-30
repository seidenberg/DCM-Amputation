function [yBold] = compute_bold_signal(h, pHRF)

% BOLD signal equaition
% -Coefficients in BOLD signal model

%this function uses v + q (rows 4,5 in h) to compute the BOLD signal change
%yBold

% h here is a cell array, with 1 cell for each brain region, and contains
% a matrix of [s,f,v,q](rows) 

nPop= length(h);
k1 = 4.3* pHRF.nu0*pHRF.E0*pHRF.TE;
k2 = pHRF.ep* pHRF.r0 * pHRF.E0 * pHRF.TE;
k3 = 1- pHRF.ep;

for kHRF = 1:nPop
    %BOLD signal change equation
    yBold{kHRF,:} = pHRF.V0 * (k1.*(1-h{kHRF}(4,:)) + k2.*(1-h{kHRF}(4,:)./h{kHRF}(3,:)) + k3.*(1-h{kHRF}(3,:))); % John: looked at slides to complete this line
  % yBold(q,v) = V0*[k1*(1-q) + k2(1-q/v) + k3(1-v)]
end
