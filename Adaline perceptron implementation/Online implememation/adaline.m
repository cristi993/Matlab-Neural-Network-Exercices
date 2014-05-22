function [w, y] = adaline(x, t, epochs, miu)

%% Plot error surface
figure(3);
hold on
[W1,W2] = meshgrid(-0.5:0.01:0.5, -0.5:0.01:0.5);
[p1,p2] = size(W1);

JW = zeros(p1,p2);
for i = 1:(p1 * p2)
    w = [W1(i) W2(i)]';
    JW(i) = sum((t - x' * w).^2);
end

surf(W1,W2,JW);

%% Initialization
[~,m] = size(x);
w = [0 0]';

% For plotting the ||w* - w^k|| difference
diff = zeros(1,epochs);
wStar = (x * x')^-1 * x * t;  

%% Online algorithm ADALINE
for step = 1:epochs
    
    y = zeros(m,1);
    
    p = randperm(m);
    x = x(:,p);
    t = t(p);
    
    for j = 1:m
        i = p(j);
        y(i) = x(:,i)' * w;
        w = w + miu * (t(i) - y(i)) * x(:,i);
        %without a new bias
    end
    
    J = sum((t - x' * w).^2);
    plot3(w(1),w(2),J,'wo');
    
    % Remember the ||w* - w^k|| difference
    diff(step) = norm(w - wStar);
end

hold off

%% Plot the difference
figure(2);
plot(diff);
end
