clear all
load derivModels
load trueParameters
%a = [15,2]; b = [15,2]; c = [15,2]; %Control inferred
%aa = [15,2]; bb = [15,2]; cc = [15,2];%Amputee inferred
%t1 = [15,1]; t2 = [15,1]; t3 = [15,2];%True Control

for i = 1:10
    a(i,1:2) = derivModels.Controls.Early(i).MAP(1:2);
    b(i,1:2) = derivModels.Controls.Mid(i).MAP(1:2);
    c(i,1:2) = derivModels.Controls.Late(i).MAP(1:2);
    aa(i,1:3) = derivModels.Amputees.Early(i).MAP(1:3);
    bb(i,1:3) = derivModels.Amputees.Mid(i).MAP(1:3);
    cc(i,1:3) = derivModels.Amputees.Late(i).MAP(1:3);
    
    t1(i,1) = Truth.Amputees.Early{i}.A(2,2);
    t2(i,1) = Truth.Amputees.Mid{i}.A(2,2);
    t3(i,1) = Truth.Amputees.Late{i}.A(2,2);

    %t3(i,1:2) = Truth.Controls.Late(i,1:2);

end
n = 3; %Parameter that we are interessted
X = [aa(:,n); bb(:,n);cc(:,n) ];
X2 = [t1;t2;t3];

pd = fitdist(X, 'Normal');
x_values = -.5:0.001:1.5;
y= pdf(pd,x_values);
figure
hold on
pd2 = fitdist(X2, 'Normal');
y2= pdf(pd2,x_values);
plot(x_values,y2, 'r') %True
plot(x_values,y, 'b'), %Estimated
legend('True Distribution', 'Estimated Distribution')
title('Probability Density Distribution of Parameter 3')
xlabel('Parameter 3');
ylabel('Probability density')
hold off

%C = [a; T];

%GMModel = fitgmdist(C,2);

% figure, hold on
% scatter(a(:,1),a(:,2),'ro'); 
% scatter(T(:,1),T(:,2), 'bx'); 
% 
% gmPDF = @(x,y)reshape(pdf(GMModel,[x(:) y(:)]),size(x));
% g = gca; %current axes
% fcontour(gmPDF,[g.XLim g.YLim])
% hold off
% %view(3), axis vis3d, box on, rotate3d on

