
load('derivModels.mat');

controlEarlyData = [];
controlMidData = [];
controlLateData = [];
ampEarlyData = [];
ampMidData = [];
ampLateData = [];

for i = 1:15
    e = derivModels.Controls.Early(i).LL;
    m = derivModels.Controls.Mid(i).LL;
    l = derivModels.Controls.Late(i).LL;
    controlEarlyData = [controlEarlyData;e];
    controlMidData = [controlMidData;m];
    controlLateData = [controlLateData;l];
    e2 = derivModels.Amputees.Early(i).LL;
    m2 = derivModels.Amputees.Mid(i).LL;
    l2 = derivModels.Amputees.Late(i).LL;
    ampEarlyData = [ampEarlyData;e2];
    ampMidData = [ampMidData;m2];
    ampLateData = [ampLateData;l2];

end

pp = [controlEarlyData;controlMidData;controlLateData;ampEarlyData;ampMidData;ampLateData];
cs = ones(45,1);
ae = 2*ones(15,1);
am = 3*ones(15,1);
al = 4*ones(15,1);

labels = [cs;ae;am;al];

training_all = [pp,labels];

cs = ones(45,1);
ae = 2*ones(15,1);
am = 2*ones(15,1);
al = 2*ones(15,1);

labels = [cs;ae;am;al];

training_2 = [pp,labels];

