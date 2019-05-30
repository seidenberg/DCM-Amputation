% K MEAN FOR OUR MODEL - 
clear all;
load derivModels
a = [15,3]; b = [15,3]; c = [15,3];
aa = [15,3]; bb = [15,3]; cc = [15,3];


for i = 1:10
    a(i,1:3) = derivModels.Controls.Early(i).LL;
    b(i,1:3) = derivModels.Controls.Mid(i).LL;
    c(i,1:3) = derivModels.Controls.Late(i).LL;
    aa(i,1:3) = derivModels.Amputees.Early(i).LL;
    bb(i,1:3) = derivModels.Amputees.Mid(i).LL;
    cc(i,1:3) = derivModels.Amputees.Late(i).LL;
end


control = [a b c];
amputee = [aa bb cc ];
x = [a; aa; bb; cc];

k = 2;
[G,C] = kmeans(x, k, 'distance','sqEuclidean', 'start', 'sample');

clr = lines(k);
figure, hold on

scatter3(a(:,1),a(:,2),a(:,3), 'rx' ),hold on
scatter3(aa(:,1),aa(:,2),aa(:,3), 'bx')
scatter3(bb(:,1),bb(:,2),bb(:,3), 'gx')
scatter3(cc(:,1),cc(:,2),cc(:,3), 'kx')

%scatter3(x(:,1), x(:,2), x(:,3), 36, clr(G,:), 'Marker','x')
scatter3(C(:,1), C(:,2), C(:,3), 100,  'Marker','o', 'LineWidth',3)

legend({'Control', 'Early Amputee', 'Mid Amputee', 'Late Amputee', ...
    'K-Means Clustering'}, 'Location', 'northeast')
title('Clustering MLL')


hold off
view(3), axis vis3d, box on, rotate3d on
xlabel('HCL > V5'), ylabel('V5 > HCL'), zlabel('HCL <> HCL')

