function [ x ] = tp_ISTABACK( input, N )
%TP_ISTABACK ista with back-tracking l1-norm regularization

max_it = N;
x = ones(256);
lambda = 0.02;
L = 0.5;
n = 2;

for i = 1:max_it
    
    in_fid = forward(x, size(input,1), size(input, 2)) - input;
    fidelity = backward(in_fid, 256);
    
    pl = tp_soft(x - (1/L)*fidelity, (1/L));
    f = norm(forward(pl, size(input,1), size(input, 2)) - input)^2 + sum(sum(abs(pl)))
    f_x = norm(in_fid)^2;
    dot_prod = sum(dot(pl-x, fidelity));
    diff = (L/2)*norm(pl-x)^2;
    l1 = sum(sum(abs(pl)));
    q = f_x + dot_prod + diff + l1
    
    count = 0;
    while f > q
        count = count + 1
        L = n^(count)*L;
        pl = tp_soft(x - (2/L)*fidelity, (1/L));
        f = norm(forward(pl, size(input,1), size(input, 2)) - input)^2 + sum(sum(abs(pl)))
        f_x = norm(in_fid)^2;
        dot_prod = sum(dot(pl-x, fidelity));
        diff = (L/2)*norm(pl-x)^2;
        l1 = sum(sum(abs(pl)));
        q = f_x + dot_prod + diff + l1
    end
    
    x = pl;
    
    disp(i);
end

end

