function [derivModels] = EphraimsCode2(simData, groupSize, maxEvals,MaxIter)
%% Takes simulated Data as input and yields parameters optimized with three different models

% allocate memory space
%arm_groupnames = ['Controls', 'Amputees'];
arm_groupnames = {'Controls', 'Amputees'};
arm_groups = cell2struct(cell(1, length(arm_groupnames)), arm_groupnames, 2);
%age_groupnames = ["NA", "Early", "Mid", "Late"];
age_groupnames = {'NA','Early','Mid','Late'};
ages = cell2struct(cell(1, length(age_groupnames)), age_groupnames, 2);
derivModels = arm_groups;
derivModels.Controls = ages;
derivModels.Amputees = ages;
analyses = ["LL", "MAP"]; %, "FE"];
pp = zeros(1,3);

% Get parameters (We only need the HRF parameters, so the input is
% irrelevant here and this is actually doing more than necessary -> TODO:
% Make an input-less version.
[P, pHRF] = create_parameters(0,0);
% Generate input signals. TODO: Check; Should this be taken from previous steps?
U = create_stimuli; 


% set number of allowed function evaluations in optimization
options.MaxFunEvals = maxEvals;
options.MaxIter = MaxIter;
% print final output of optimization
options.Display = 'final';
% iterate the two main groups, i.e. controls vs amputees
for i_arm = arm_groupnames
    % iterate the age groups
    for i_age = age_groupnames
        % for every subject in the group ...
        for i_subject = 1 : groupSize
            % ... get the generated BOLD data
%             yDATA = simData.(i_arm).(i_age){i_subject,1};
            yDATA = simData.(i_arm{1}).(i_age{1}){i_subject,1};
            % ... get the generated noise
            sigmaNoise = simData.(i_arm{1}).(i_age{1}){i_subject,2};
            % ... get the priors. TODO: get_priors überarbeiten
            priors = tn_get_priors_new(0.01);
            % ... for each type of analysis ...
            for i_analysis = analyses
            % ... create optimiziable functions corresponding to analysis
                switch i_analysis
                    case "LL"
                        optimizedFunction = @(parameters)tn_LL_model2_new(parameters, yDATA, U, P, pHRF, sigmaNoise); 
                    case "MAP"
                        optimizedFunction = @(parameters)tn_MAP_model2_new(parameters, yDATA, U, P, pHRF, sigmaNoise, priors);
                    case "FE"
                        optimizedFunction = @(parameters)tn_FE_model2(parameters, yDATA, U, P, pHRF, sigmaNoise);
                end
                % ... optimize parameters
                pp2analysis = fminsearch(optimizedFunction,pp, options);
                % .. repeat to be sure, this time with optimized value
                pp2analysis = fminsearch(optimizedFunction,pp2analysis, options);
                % ... store optimal parameters into output struct
                derivModels.(i_arm{1}).(i_age{1})(i_subject).(i_analysis) = pp2analysis;
            end
            % ... store the generated Bold DATA into the output struct
            derivModels.(i_arm{1}).(i_age{1})(i_subject).yDATA = yDATA;
            disp('Finished estimating maxLL and MAP for an individual')
            % ... TODO: store all of John's output into output struct, unprocessed
            save derivModels.mat 'derivModels';
        end
    end
end