
d = simData.Amputees.NA{1};
y1 = d(1,:);
y2 = d(2,:);
y3 = d(3,:);

y1 = y1(1:0.25*length(y1));
y2 = y2(1:0.25*length(y2));
y3 = y3(1:0.25*length(y3));
x = 1:0.1:125.9;
figure;
hold on
plot(x,y1)
plot(x,y2)
plot(x,y3)
xlim([0 max(x)])
xlabel('Seconds')
ylabel('BOLD signal')
legend('V5','HCR','HCL')
hold off
