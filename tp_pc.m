function y  = tp_pc( x )
%TP_PC Projects the output onto -10 and 400
%   values in the matrix below 0 and above 1 are set to -10 and 400
%   respectively

y = x;

y(x < -10) = -10;
y(x > 400) = 400;

end

