[alphabet, targets] = prprob(); 

%% HOW A LETTER LOOKS LIKE

% l = alphabet(:,1);
% l = reshape(l, 5, 7);
% l = l'; 
% imagesc(l);

%% EXAMPLE OF NOISE ADDED TO A LETTEER

% l = alphabet(:,1);
% l = reshape(l,5,7);
% l = l';
% l = l + randn(7,5) * 0.2;
% l(l<0) = 0;
% l(l>1) = 1;
% imagesc(l);

%% CREATE THE NETWORK

S1 = 10;
[R,~] = size(alphabet);
[S2,Q] = size(targets); 
P = alphabet;
net = newff(minmax(P),[S1 S2],{'logsig' 'logsig'},'traingdx');
net.LW{2,1} = net.LW{2,1} * 0.01;
net.b{2} = net.b{2} * 0.01;
net.trainParam.epochs = 300;
net.trainParam.goal = 0.6;
net.trainParam.mc = 0.95;
net.performFcn = 'sse';

%% TRAIN NETWORK WITH NOISE

for i=1:10
    P1 = P + randn(R,Q) * 0.1;
    P2 = P + randn(R,Q) * 0.2;
    P1(P1<0) = 0;
    P1(P1>1) = 1;
    P2(P2<0) = 0;
    P2(P2>1) = 1;
    
    PZ = [P P P1 P2];
    TZ = [targets, targets, targets, targets];
    
    net = train(net, PZ, TZ);
end

%% TRAIN AGAIN ON LETTERS WITHOUT NOISE

net.trainParam.epochs = 500;
net.trainParam.goal = 0.5;
net = train(net, P, targets);

%% TEST NETWORK ON A SINGLE LETTER WITH NOISE

% noisyJ = alphabet(:,10)+randn(35,1) * 0.2;
% figure(1);
% plotchar(noisyJ);
% A2 = sim(net,noisyJ);
% A2 = compet(A2);
% answer = find(compet(A2) == 1);
% figure(2);
% plotchar(alphabet(:,answer));

%% TEST NETWORK TO FIND THE ERROR

Px = []; Tx = [];
for d = 0:0.05:0.5
    for i = 1:10
        Pz = P + randn(R,Q) * d;
        Px = [Px Pz];
        Tx = [Tx targets]; 
    end
end

Yx = sim(net, Px);
Yx = compet(Yx); 
Yx = mod(find(Yx == 1), Q);
Tx = mod(find(Tx == 1), Q);
E = numel(find(Tx ~= Yx)) / length(Tx)
