clear;

load t.mat
load x.mat

hold on;

plot(x(t==1,1),x(t==1,2),'b+');
plot(x(t==-1,1),x(t==-1,2),'ro');

[w, ~, ~] = trainPerceptron(x, t, 100);

x1 = -1:1:1;
x2 = - (w(3) + x1 * w(1)) / w(2);
plot(x1,x2,'g');
    
hold off;
