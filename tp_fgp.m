function [ x ] = tp_fgp( b, lambda, N )
%TP_FGP Fast gradient projection as described by Beck and Teboulle
%   Takes in the observed sinogram b, regularization parameter lambda, number
%   of iterations N, and outputs x the optimal solution to the TV
%   regularized problem

max_it = N; %number of maximum iterations
[m, n] = size(b);

%initialization of iteration variables
r = zeros(m-1, n);
p = zeros(m-1, n);
s = zeros(m, n-1);
q = zeros(m, n-1);
t = 1;

for i = 1:max_it
    %stores temporary versions of current variable values
    temp_p = p;
    temp_q = q;
    temp_t = t;
    
    %4.9
    calcpc = tp_pc(b - lambda*tp_l(r, s));
    [calc_p, calc_q] = tp_lt(calcpc);
    calc_p = 1/(8*lambda)*calc_p;
    calc_q = 1/(8*lambda)*calc_q;
    [p, q] = tp_pp(r + calc_p, s + calc_q);
    
    %4.10
    t = (1+(1+4*t^2)^0.5)/2;
    
    %4.11
    r = p + ((temp_t - 1)/(t))*(p - temp_p);
    s = q + ((temp_t - 1)/(t))*(q - temp_q);
    
end

x = tp_pc(b - lambda*tp_l(p, q));
end

