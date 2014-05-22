%% Input dataset
x = [-2,2; -2,3; -1,1; -1,4; 0,0; 0,1; 0,2; 0,3; 1,0; 1,1; 2,1; 2,2; 3,-1; 3,0; 3,1; 3,2; 4,-2; 4,1; 5,-1; 5,0]';
t = [-1 -1 -1 -1 -1 -1 -1 -1 1 -1 1 -1 1 1 1 1 1 1 1 1]';

%% Train ADALINE element using batch
[w,y] = adaline(x,t,100,0.001);

%% Plot the points and the hyperplane of separation learned by ADALINE
figure(1);
plotpv(x,(t' + 1) / 2);
plotpc(w',0);
