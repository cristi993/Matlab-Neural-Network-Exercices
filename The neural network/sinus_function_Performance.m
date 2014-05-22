clear;
warning('off','all');
p = -2:0.05:2; 
t = sin(2*pi*p) + 0.1 * randn(size(p)); 
trainings = {'traingd' 'traingdm' 'traincgf' 'traincgp' 'traingda' 'traingdm' 'traingdx' 'trainbfg' 'trainoss' 'trainlm'};
colors = {'red', 'green', 'blue', 'yellow', [0.8 0.4 0.6], [0.5 0.5 0.5], 'magenta', 'cyan', 'black', [0.1 0.6 1]};
                                             %a dark pink   %grey                                    %some kind of blue

for i = 1:length(trainings)
    net = newff(minmax(p),[3,10,10,1],{'purelin','tansig','tansig','purelin'}, trainings{i});
    net.trainParam.epochs = 50;
    net.trainParam.goal = 0.001;
    net = init(net); 
    [net, tr] = train(net,p,t);
    
    hold on;
    plot(tr.epoch,tr.perf, 'Color', colors{i}, 'LineWidth', 2);
    hold off;
    %figure(i); 
    %plotperform(tr); % MSE at every epoch
    
    y = sim(net, p);
    y = round(y);
    fprintf('MSE %s: %g\n', trainings{i}, (1.0/length(t) * sum((t - y).^2))); %error
end

% net = newff(minmax(p),[3,10,10,1],{'purelin','tansig','tansig','purelin'}, 'trainbfg');
% net.trainParam.epochs = 50;
% net.trainParam.goal = 0.001;
% net = init(net); 
% [net, tr] = train(net,p,t);
% y = sim(net, p);
% % plotperf(tr);
% plot(tr.epoch, tr.perf); % plot after every epoch
% % hold on;
% % plot(p,y);
% % plot(p,sin(2*pi*p), 'g');
% hold off;
