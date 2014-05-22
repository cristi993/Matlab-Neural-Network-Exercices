clear;
load x.mat;
load t.mat;

net = newp([-1 1; -1 1], 1, 'hardlims');
net.trainParam.epochs = 10;
net.inputweights{1,1}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';

net = init(net);

net = train(net,x',t');

y = sim(net,x');

fprintf('Error %g\n', numel(find(y' ~= t)) / size(t,1));

hold on;
t = t == 1;
plotpv(x',t');
plotpc(net.IW{1,1}, net.b{1});
hold off;