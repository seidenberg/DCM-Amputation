function [derivModels] = evaluate_params(simData, groupSize, maxEvals,MaxIter)
%% Takes simulated Data as input and yields parameters optimized with three different models

% allocate memory space
arm_groupnames = ["Controls", "Amputees"];
% arm_groups = cell2struct(cell(1, length(arm_groupnames)), arm_groupnames, 2);
age_groupnames = ["NA", "Early", "Mid", "Late"];
% ages = cell2struct(cell(1, length(age_groupnames)), age_groupnames, 2);
% derivModels = arm_groups;
% derivModels.Controls = ages;
% derivModels.Amputees = ages;
analyses = ["LL", "MAP"]; %, "FE"];
nParams = 27;
pp = zeros(1,nParams);

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
        % get the generated BOLD data
        yDATA = simData.(i_arm).(i_age);
        % geth the generated noise
        sigmaNoise = simData.(i_arm).(i_age);
        % for every subject in the group ...
        parfor i_subject = 1:groupSize
            % ... get the BOLD data for this subject
            yDataSubject = yDATA{i_subject, 1};
            % ... store the generated Bold DATA into struct within sliced array
            subjectData(i_subject).yDATA = yDataSubject;
            % ... get the generated noise
            sigmaNoiseSubject = sigmaNoise{i_subject, 2};
            % ... get the priors. TODO: get_priors überarbeiten
            priors = tn_get_priors_new(0.01);
            % ... for each type of analysis ...
            for i_analysis = analyses
                % ... create optimiziable functions corresponding to
                % analysis into sliced variable (array)
                switch i_analysis
                    case "LL"
                        optimizedFun(i_subject).f = @(parameters)tn_LL_model2_new(parameters, yDataSubject, U, P, pHRF, sigmaNoiseSubject); 
                    case "MAP"
                        optimizedFun(i_subject).f = @(parameters)tn_MAP_model2_new(parameters, yDataSubject, U, P, pHRF, sigmaNoiseSubject, priors);
                    case "FE"
                        optimizedFun(i_subject).f = @(parameters)tn_FE_model2(parameters, yDataSubject, U, P, pHRF, sigmaNoiseSubject);
                end
                % ... optimize parameters
                pp2analysis = fminsearch(optimizedFun(i_subject), pp, options);
                % ... repeat to be sure, this time with optimized value
                pp2analysis = fminsearch(optimizedFun(i_subject), pp2analysis, options);
                % ... store optimal parameters as struct into sliced array
                subjectData(i_subject).(i_analysis) = pp2analysis;
            end
        end
        % transfer data from sliced array into output struct
        for i_subject = 1:groupSize
            derivModels.(i_arm).(i_age)(i_subject) = subjectData(i_subject);
            disp('Finished estimating maxLL and MAP for an individual')
        end
        %... TODO: store all of John's output into output struct, unprocessed
        save derivModels.mat 'derivModels';        
    end
end