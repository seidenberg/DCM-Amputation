function [P,pHRF] = create_parameters(amputee,age)
% row = recieving regions, column = sending region. So P.A(2,1) =
% connection strength from region 1 to region 2.
% Order is HandCortexLeft, HandCortexRight, SMN
% Amputees (Jamie Lannister) all lose left hand, so HandCortexLeft
% affected

%% Creating an individual of a subtype
if amputee == 0
    P.A = [1 1 1; 1 1 0; 1 0 1]; % control group
else
    P.A = [1 0.5 1; 0.5 0.5 0; 1 0 1]; % amputee group, recurrent connections to/from HCR and V5 half strength
end

if amputee == 1 
    if age == 0 % age not considered
        P.A = P.A;
    elseif age == 1 % Early amputation
        ratio = 1; % Ratio determines weakening of connections with time 
        P.A(1,2) = P.A(1,2)*ratio; 
        P.A(2,1) = P.A(2,1)*ratio; % currently both directions affected equally by age
        P.A(2,2) = P.A(2,2)*ratio; 
    elseif age == 2
        ratio = 0.9;
        P.A(1,2) = P.A(1,2)*ratio; 
        P.A(2,1) = P.A(2,1)*ratio; % currently both directions affected equally by age
        P.A(2,2) = P.A(2,2)*ratio; 
    elseif age == 3
        ratio = 0.8;
        P.A(1,2) = P.A(1,2)*ratio; 
        P.A(2,1) = P.A(2,1)*ratio; % currently both directions affected equally by age
        P.A(2,2) = P.A(2,2)*ratio; 
    end
end

P.B = zeros(3,3,2);
P.B(:,:,1) = [0 0 1;0 0 0; 1 0 0];  % For u1, which is modulation of V5 to HCR
P.B(:,:,2) = [0 1 0;1 0 0; 0 0 0];  % For u2, which is modulation of V5 to HCL

P.C = [1 0 0; 0 0 0; 0 0 0];

%% Adding variation 
variance = 0.001;
for a = 1 : numel(P.A)
    if P.A(a)~=0
        P.A(a) = P.A(a) + randn(1)*variance;
    end
end
for b = 1 : numel(P.B)
    if P.B(b)~=0
        P.B(b) = P.B(b) + randn(1)*variance;
    end
end
for c = 1 : numel(P.C)
    if P.C(c)~=0
        P.C(c) = P.C(c) + randn(1)*variance;
    end
end

if amputee == -1
    P.A = [1 1 1; 1 1 0; 1 0 1]; % control group
end

%%
% HRF parameters
P.kappa = 0;
P.gamma = 0;
P.tau = 0;
P.alpha = 0;
P.E0 = 0; 

pHRF.kappa = 0.64;
pHRF.gamma = 0.32;
pHRF.tau = 2.00;
pHRF.alpha = 0.32;
pHRF.TE = 0.03;
pHRF.V0 = 0.04;
pHRF.ep = 0.47;
pHRF.r0 = 110;
pHRF.nu0 = 80.6; 
pHRF.E0 = 0.4;

