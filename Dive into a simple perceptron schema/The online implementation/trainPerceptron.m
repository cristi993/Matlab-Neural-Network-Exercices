function [w, y, error] = trainPerceptron(x, t, epochs)

[m , n] = size(x);

w = rand(n + 1, 1) * 2 - 1;
y = zeros(m,1);

for e = 1:epochs
    
    p = randperm(m);
    x = x(p,:);
    t = t(p);
    
    for i = 1:m
        xi = [x(i,:) 1]; 
        out = xi * w;
        if out > 0
            y(i) = 1;
        else
            y(i) = -1;
        end
        
        if t(i) ~= y(i)
            % online learning
            w = w + t(i) * xi';
        end
    end
end

error = nnz(gsubtract(y,t)) / m

end

