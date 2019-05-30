function [yBOLD,y,x] = euler_integrate(U,P,pHRF)

dt = U.dt;
inp = U.u;

nTrace = max(size(U.u));
nPop = size(P.A,1);
x = zeros(nPop, nTrace +1); %initialize x and add one element for starting condition
% this is a matrix of brain regions (rows) and time points (columns)
x(:,1) = zeros(nPop,1); %initial condition for x)
% this last line appears to be redundent 
yBold = zeros(nPop, nTrace);

for k = 1:nPop  % for each brain region, create a storage space for traces
    y{k} = zeros(4,nTrace +1); % the hemodynamic state values
    y{k}(:,1) = [0;1;1;1]; %set initial condition for hemodynamics to fixed point
end

%integrate the function
for k = 1:nTrace % for each time point
    dxdt = single_step_neural(x(:,k), inp(:,k),P);
    x(:,k+1) = x(:,k) + dt*dxdt;
    for kHRF = 1:nPop %integrate the hemodynamic model for all regions
        dydt = single_step_hrf(y{kHRF}(:,k), x(kHRF,k),P,pHRF);
        y{kHRF}(:,k+1) = y{kHRF}(:,k) + dt * dydt;
    end
end

x=x(:,2:end);
for kHRF = 1:nPop
    y{kHRF} = y{kHRF}(:,2:end);
end

% BOLD signal equations
% this is just a guess for the integration of BOLD signal
dbdt = compute_bold_signal(y, pHRF);
dbdt = cell2mat(dbdt);
yBOLD = dbdt;
