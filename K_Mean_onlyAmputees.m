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
n = 1:3;
X = [aa(:,n); bb(:,n);cc(:,n) ];

k = 3;
[G,C] = kmeans(X, k, 'distance','sqEuclidean', 'start', 'sample');

clr = lines(k);
figure, hold on

scatter3(aa(:,1),aa(:,2),aa(:,3), 'bx')
scatter3(bb(:,1),bb(:,2),bb(:,3), 'mx')
scatter3(cc(:,1),cc(:,2),cc(:,3), 'gx')

%scatter3(x(:,1), x(:,2), x(:,3), 36, clr(G,:), 'Marker','x')
scatter3(C(1,1), C(1,2), C(1,3), 'bo', 'LineWidth',3)
scatter3(C(2,1), C(2,2), C(2,3), 'mo', 'LineWidth',3)
scatter3(C(3,1), C(3,2), C(3,3),'go', 'LineWidth',3)

legend( 'Early Amputee', 'Mid Amputee', 'Late Amputee',...
    'K-Mean 1', 'K-Mean 2', 'K-Mean 3')

title('K-means for different Groups of Amputees')

hold off
view(3), axis vis3d, box on, rotate3d on
xlabel('HCL > V5'), ylabel('V5 > HCL'), zlabel('HCL <> HCL')

