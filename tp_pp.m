function [ r, s ] = tp_pp( p, q )
%TP_PP projects the two input matrices onto the set P
%   Takes in two matrices p and q, and outputs two matrices r, s which are
%   projections of p and q onto the set P, used in Beck & Tebulle 4.9

%ani

    abs_p = abs(p);
    abs_q = abs(q);
    
    abs_p(abs_p < 1) = 1;
    abs_q(abs_q < 1) = 1;
    
    r = p./abs_p;
    s = q./abs_q;

% %iso
%     p_calc = [p; zeros(1, size(p, 2))];
%     q_calc = [q, zeros(size(q, 1), 1)];
%     div = (q_calc.^2 + p_calc.^2).^.5;
%     div(div < 1) = 1;
%     
%     r = p./div(1:end-1, :);
%     s = q./div(:, 1:end-1);
end

