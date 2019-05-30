function [output] = tn_LL_model2_new(parameters, yDATA, U, P, pHRF,sigmaNoise)

% this function will be used to find where it equals zeros. 
%parameters = [P2.A(1,1),P2.A(2,1),P2.A(2,2),P2.B(2,1),P2.C(1,1)];

%% Use log-likelihood function, log-joint function, and fminsearch

% counter for assigned parameters
% parCount = 0;
% % for each parameter matrix ...
% for parMat = ["A", "B", "C"]
%     % ... fill it with the next available parameters from the parameter list
%     P.(parMat) = vec2mat(parameters(parCount + 1:parCount + numel(P.(parMat))), 3);
%     % ... increase the counter by the number of assigned parameters
%     parCount = parCount + 1;
% end

% Explicit form for debugging 
P.A(1,2) = parameters(1);
P.A(2,1) = parameters(2);
P.A(2,2) = parameters(3);

% P.A(1,1) = parameters(1);
% P.A(1,2) = parameters(2);
% P.A(1,3) = parameters(3);
% P.A(2,1) = parameters(4);
% P.A(2,2) = parameters(5);
% P.A(2,3) = parameters(6);
% P.A(3,1) = parameters(7);
% P.A(3,2) = parameters(8);
% P.A(3,3) = parameters(9);
% P.B(1,1) = parameters(10);
% P.B(1,2) = parameters(11);
% P.B(1,3) = parameters(12);
% P.B(2,1) = parameters(13);
% P.B(2,2) = parameters(14);
% P.B(2,3) = parameters(15);
% P.B(3,1) = parameters(16);
% P.B(3,2) = parameters(17);
% P.B(3,3) = parameters(18);
% P.C(1,1) = parameters(19);
% P.C(1,2) = parameters(20);
% P.C(1,3) = parameters(21);
% P.C(2,1) = parameters(22);
% P.C(2,2) = parameters(23);
% P.C(2,3) = parameters(24);
% P.C(3,1) = parameters(25);
% P.C(3,2) = parameters(26);
% P.C(3,3) = parameters(27);

% P.A = vec2mat(parameters( 1: 9), 3);
% P.B = vec2mat(parameters(10:18), 3);
% P.C = vec2mat(parameters(19:27), 3);

[LL,yBOLD] = compute_loglikelihood(yDATA, U, P, pHRF, sigmaNoise);
output = 1/LL;

% [yBold,y,x] = euler_integrate_dcm(U,P2,pHRF);
% diff = mean(mean(yBold - yDATA));
end
