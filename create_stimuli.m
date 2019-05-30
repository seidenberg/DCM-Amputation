function [U] = create_stimuli
expDuration = 500; %duration of input in seconds
U.dt = 0.1; %temporal resolution
stimTimeDiff = 10; % time between peaks in seconds

%% Create request signal (telling person to squeeze left or right)

amp = 2;
u1 = [];
u2 = [];
u3 = [];

state = 0;
% state0 = 0->0, state1 = 0->1, state2 = 1->0, state3 = 0->-1, state4 = -1->0
for block = 1 : round(expDuration/stimTimeDiff)
    if state == 0 
        event = zeros(stimTimeDiff/U.dt,1)*amp;
        u3 = [u3; event];
        u1 = [u1;event];
        u2 = [u2;event];
        state = 1;
    elseif state == 1
        event = ones(stimTimeDiff/U.dt,1)*amp;
        u3 = [u3; event];
        u1 = [u1;event];
        u2 = [u2;zeros(stimTimeDiff/U.dt,1)];
        state = 2;
    elseif state == 2
        event = zeros(stimTimeDiff/U.dt,1)*amp;
        u3 = [u3; event];
        u1 = [u1; event];
        u2 = [u2; event];
        state = 3;
    elseif state == 3
        event = ones(stimTimeDiff/U.dt,1)*amp;
        u3 = [u3; event];
        u1 = [u1; zeros(stimTimeDiff/U.dt,1)];
        u2 = [u2; event];
        state = 4;
    elseif state == 4
        event = zeros(stimTimeDiff/U.dt,1)*amp;
        u3 = [u3; event];
        u1 = [u1; event];
        u2 = [u2; event];
        state = 1;
    end
end

U.u = [u3,u1,u2]'; 

end

