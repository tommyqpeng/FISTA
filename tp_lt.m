function [ p, q ] = tp_lt( x )
%TP_LT Adjoint of linear operator L
%   Takes the image x and outputs a matrix pair p,q based on isotropic TV

[m, n] = size(x);

p = x(1:m-1, :) - x(2:m, :);
q = x(:,1:n-1) - x(:, 2:n);
end

