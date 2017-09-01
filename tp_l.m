function [ x ] = tp_l( p, q )
%TP_L Linear operator to form an output
%   takes in two matrices p, q and outputs a single matrix x based on the
%   linear operator

m = size(p, 1) + 1;
n = size(p, 2);

x = zeros(m,n);

x(1:m-1, :) = p;
x(:,1:n-1) = x(:,1:n-1) + q;
x(2:m, :) = x(2:m, :) - p;
x(:, 2:n) = x(:,2:n) - q;
end

