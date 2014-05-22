p = -1:0.05:1; 
t = sin(2*pi*p)+0.1*randn(size(p)); 
net=newff(minmax(p),[20,1],{'tansig','purelin'},'trainbr'); %first attempt, without normalization
%net=newff(minmax(p),[20,1],{'tansig','purelin'},'trainbfg'); %second attempt, with normalization
%net.performFcn = 'msereg'; % from second attempt
net.trainParam.show = 10; 
net.trainParam.epochs = 100;
net = init(net); 
[net,tr]=train(net,p,t); 
y = sim(net, p);
hold on;
plot(p, sin(2*pi*p), 'b');
plot(p, t,'r');
plot(p, y,'g', 'LineWidth', 2);
hold off;
