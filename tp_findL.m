function [L_out, x_k, f_out] = tp_findL(y, b, L, lambda )
%TP_FINDL Finds the optimal new L for tv regularization term with input y
%   Detailed explanation goes here

%initialization
L_out = L;
n = 2;
f = 1;
q = 0;
counter = 0;

%these dont change with L
AY_b = forward(y, size(b, 1), size(b, 2)) - b;
ATAY_b = backward(AY_b, 256);
del_f_y = 2*ATAY_b;
f_y = norm(AY_b)^2;

while f > q
    L_out = L*(n^counter);
    
    pl_y = tp_fgp(y-(2/L_out)*ATAY_b, 2*lambda/L_out, 10);
    f = norm(forward(pl_y, size(b, 1), size(b, 2)) - b)^2 + lambda*tp_tv(pl_y); 
    dot_prod = sum(dot((pl_y-y), del_f_y)); %dotprod term
    tv = tp_tv(pl_y); %g(pl_y)
    diff = (L_out/2)*norm(pl_y-y)^2; %norm term with L/2
    
    q = f_y + dot_prod + diff + tv;
    
    counter = counter + 1;
end

    x_k = pl_y;
    f_out = f;
    
end

