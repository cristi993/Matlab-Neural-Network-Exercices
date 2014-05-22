function [w, y, error] = batchPerceptron(x, t, epochs, r)

[m , n] = size(x);

w = rand(n + 1, 1) * 2 - 1;
y = zeros(m,1);

for e = 1:epochs
    
    p = randperm(m);
    x = x(p,:);
    t = t(p);
    s = zeros(1,n + 1);
    
    for i = 1:m
        xi = [x(i,:) 1]; 
        out = xi * w;
        if out > 0
            y(i) = 1;
        else
            y(i) = -1;
        end
        
        if t(i) ~= y(i)
            s = s + t(i) * xi;
        end
    end
    
    w = w + r * s';
    
    %calculate the minimum squared error at every step
    %mse((y-t) * 0.5);
end

error = nnz(gsubtract(y,t)) / m

end

