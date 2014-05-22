clear;
warning('off','all');
load choles_all;

for i = 1:size(t,1)
    m = mean(t(i,:));
    d = std(t(i,:));
    t(i,:) = (t(i,:) - m) / d;
end

net = newff(minmax(p),[21,15,3],{'tansig','logsig','purelin'}, 'trainlm');
net.trainParam.epochs = 100;
net.trainParam.goal = 0.027;
net.trainParam.show = 100;
net = init(net); 
[net, tr] = train(net,p,t);
plotperform(tr);
%plot(tr.epoch, tr.perf);
y = sim(net, p);
fprintf('MSE: %g\n', mse(net,y,t)); %error

% hold on;
% plot(p, t, 'g');
% plot(p, y);
% hold off;
