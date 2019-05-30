function [dxdt] = single_step_neural(x,u,P)
%dx/dt = (A+ u2B)x + Cu1 ---> this bilinear midel describes dynamics of
%neural system
%caculates right side of diff'equation

%x = neural state vector
%u = 2d input vectir at time t
%P = parameter struct with fields A,B,C

dxdt = zeros(size(x));

CC = P.A + P.B(:,:,1)*u(2)+P.B(:,:,2)*u(3);

effCon = diag(-6 * exp(diag(CC))) + (CC - diag(diag(CC))); %make diagonal negative to make system stable

dxdt = effCon *x + P.C*u;

end
