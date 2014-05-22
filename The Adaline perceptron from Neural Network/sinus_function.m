time = 0:0.025:5;
n = length(time);
%f = sin(time * 2 * pi);
f = sin(time * 2 * pi) + rand(1,n) * 0.1; % with noise
P = num2cell(f(1:n-1)); %until last example: the last one is the example, rest of them the history
T = num2cell(f(2:n));
Pi = {0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0};%delay units
net = newlind(P, T, Pi);
Y = sim(net, P);
a = cell2mat(Y);

hold on;
plot(time, f, 'b');
plot(time(2:n), a, 'r', 'LineWidth', 2);
hold off;
