
clear all
close all
clc

%% Test section for modifying create_stimuli function
groupSize = 15;
maxEvals = 5000;
MaxIter = 5000;
[U] = create_stimuli;

figure;
hold on
plot(U.u(3,:))
plot(U.u(2,:))
plot(U.u(1,:))
hold off

%% REAL PROJECT STARTS HERE
%% Generate data
disp('-------------------------')
disp('Creating synthetic noisy BOLD signals')

[simData, Truth] = generate_data(groupSize);

figure;
hold on
plot(simData.Controls.NA{1}(1,:))
plot(simData.Controls.NA{1}(2,:))
plot(simData.Controls.NA{1}(3,:))
hold off

%% Estimate Parameters
disp('-------------------------')
disp('Estimating parameters')
[derivModels] = EphraimsCode2(simData, groupSize, maxEvals,MaxIter);
save derivModels.mat 'derivModels';
save trueParameters.mat 'Truth';
