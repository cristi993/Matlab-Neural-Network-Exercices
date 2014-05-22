clear;
x = -1:0.1:1;
n = length(x);
f = 2 * x + (0.25-(-0.25)) .* rand(1,n) + (-0.25);

rate = 0:0.01:0.1;
epoci = 0:10:100;
epoci(1) = 1;
MSE = zeros(length(rate), length(epoci));

for i = 1:length(rate)
    for j = 1:length(epoci)
        net = newlin(x,f,0,rate(i));
        net.trainParam.epochs = epoci(j);
        net = train(net, x, f);
        y = sim(net, x);
        
        MSE(i,j) = 1.0/length(f) * sum((f - y).^2);
    end
end

[xx, yy] = meshgrid(rate, epoci);
surf(xx, yy, MSE);

MIN = min(min(MSE))
[i, j] = find(MSE == MIN);
fprintf('Optimal pairs of learning rates and epochs:\n');
[rate(i); epoci(j)]

net = newlin(x,f,0,0.01);
net.trainParam.epochs = 60;
net = train(net, x, f);
y = sim(net, x);

figure(2);
hold on;
plot(x, f, 'b');
plot(x, y, 'r', 'LineWidth', 2);
plot(x, 2 * x, 'g', 'LineWidth', 2);
hold off;