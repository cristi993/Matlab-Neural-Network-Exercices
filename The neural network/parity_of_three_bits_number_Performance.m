clear;
warning('off','all');
p = round(rand(3,100));
t = mod(sum(p),2) * 2 - 1;
trainings = {'traingd' 'traingdm' 'traincgf' 'traincgp' 'traingda' 'traingdm' 'traingdx' 'trainbfg' 'trainoss' 'trainlm'};
colors = {'red', 'green', 'blue', 'yellow', [0.8 0.4 0.6], [0.5 0.5 0.5], 'magenta', 'cyan', 'black', [0.1 0.6 1]};
                                             %a dark pink   %grey                                    %some kind of blue

for i = 1:length(trainings)
    net = newff(minmax(p),[3,10,10,1],{'purelin','logsig','tansig','tansig'}, trainings{i});
    net.performFcn = 'msereg';
    net.trainParam.epochs = 50;
    net.trainParam.goal = 0.001;
    net = init(net); 
    [net, tr] = train(net,p,t);
    
    hold on;
    plot(tr.epoch,tr.perf, 'Color', colors{i}, 'LineWidth', 2);
    hold off;
    %figure(i); 
    %plotperform(tr); % show MSE at every epoch
    
    y = sim(net, p);
    y = round(y);
    fprintf('MSE %s: %g\n', trainings{i}, (1.0/length(t) * sum((t - y).^2))); %error
end
