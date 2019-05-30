function [simData, Truth] = generate_data(groupSize)
%% %% TN Amputee Project Version 2.0

%% Testing for one subgroup
% Get parameters for model
rng('default'); % Create seed for random number generator (same results each time run)
rng(0);

%% Get all clean data for all subgroups

% This creates a structure for saving the true parameters of each
% simulated individual 
ages = struct('NA',[],'Early',[],'Mid',[],'Late',[]);
conditions = struct('Controls',[],'Amputees',[]);
Truth = conditions;
Truth.Controls = ages;
Truth.Amputees = ages;

% This creates a structure for saving the data from each simulated
% individual
ages = struct('NA',[],'Early',[],'Mid',[],'Late',[]);
conditions = struct('Controls',[],'Amputees',[]);
Results = conditions;
Results.Controls = ages;
Results.Amputees = ages;
U = create_stimuli;

for subject = 1 : groupSize
    for age = 0 : 3
        for cond = 0 : 1
            amputee = cond;
            Age = age;
            [P, pHRF] = create_parameters(amputee,Age);
            [yBOLD,y,x] = euler_integrate(U,P,pHRF);
            data = {};
            data{1} = yBOLD;
            data{2} = x;
            data{3} = y;
            if cond == 0 && age == 0
                Results.Controls.NA{subject} = data;
                Truth.Controls.NA{subject} = P;
            elseif cond == 0 && age == 1
                Results.Controls.Early{subject} = data;
                Truth.Controls.Early{subject} = P;
            elseif cond == 0 && age == 2
                Results.Controls.Mid{subject} = data;
                Truth.Controls.Mid{subject} = P;
            elseif cond == 0 && age == 3
                Results.Controls.Late{subject} = data;
                Truth.Controls.Late{subject} = P;
            elseif cond == 1 && age == 0
                Results.Amputees.NA{subject} = data;
                Truth.Amputees.NA{subject} = P;
            elseif cond == 1 && age == 1
                Results.Amputees.Early{subject} = data;
                Truth.Amputees.Early{subject} = P;
            elseif cond == 1 && age == 2
                Results.Amputees.Mid{subject} = data;
                Truth.Amputees.Mid{subject} = P;
            elseif cond == 1 && age == 3
                Results.Amputees.Late{subject} = data;
                Truth.Amputees.Late{subject} = P;
            end
        end
    end
end

%% Create noisy data

% This creates a structure for the noisy versions of the data from
% simulated individuals
ages = struct('NA',[],'Early',[],'Mid',[],'Late',[]);
conditions = struct('Controls',[],'Amputees',[]);
simData = conditions;
simData.Controls = ages;
simData.Amputees = ages;

for i = 1 : groupSize
    data = Results.Controls.NA{i}{1};
    stdBOLD = mean(std(data'));
    noised_data = data + stdBOLD*randn(size(data));
    simData.Controls.NA{i,1} = noised_data;
    simData.Controls.NA{i,2} = stdBOLD;
    
    data = Results.Controls.Early{i}{1};
    stdBOLD = mean(std(data'));
    noised_data = data + stdBOLD*randn(size(data));
    simData.Controls.Early{i,1} = noised_data;
    simData.Controls.Early{i,2} = stdBOLD;
    
    data = Results.Controls.Mid{i}{1};
    stdBOLD = mean(std(data'));
    noised_data = data + stdBOLD*randn(size(data));
    simData.Controls.Mid{i,1} = noised_data;
    simData.Controls.Mid{i,2} = stdBOLD;
    
    data = Results.Controls.Late{i}{1};
    stdBOLD = mean(std(data'));
    noised_data = data + stdBOLD*randn(size(data));
    simData.Controls.Late{i,1} = noised_data;
    simData.Controls.Late{i,2} = stdBOLD;
    
    data = Results.Amputees.NA{i}{1};
    stdBOLD = mean(std(data'));
    noised_data = data + stdBOLD*randn(size(data));
    simData.Amputees.NA{i,1} = noised_data;
    simData.Amputees.NA{i,2} = stdBOLD;

    data = Results.Amputees.Early{i}{1};
    stdBOLD = mean(std(data'));
    noised_data = data + stdBOLD*randn(size(data));
    simData.Amputees.Early{i,1} = noised_data;
    simData.Amputees.Early{i,2} = stdBOLD;

    data = Results.Amputees.Mid{i}{1};
    stdBOLD = mean(std(data'));
    noised_data = data + stdBOLD*randn(size(data));
    simData.Amputees.Mid{i,1} = noised_data;
    simData.Amputees.Mid{i,2} = stdBOLD;
    
    data = Results.Amputees.Late{i}{1};
    stdBOLD = mean(std(data'));
    noised_data = data + stdBOLD*randn(size(data));
    simData.Amputees.Late{i,1} = noised_data;
    simData.Amputees.Late{i,2} = stdBOLD;
    
end

% figure;
% hold on
% plot(simData.Controls.Early{1}(1,:));
% plot(simData.Controls.Mid{1}(1,:));
% plot(simData.Controls.Late{1}(1,:));

% plot(simData.Amputees.Early{1}(1,:));
% plot(simData.Amputees.Mid{1}(1,:));
% plot(0.2+simData.Amputees.Late{1}(1,:));
% hold off


%% Outputs of this last section worth using:
%%% simData - Contains the BOLD signals for each indidivual simulated
%%% Truth - Contains the true parameters of each simulated individual (Will
%%% be helpful later for double checking it all works)
end