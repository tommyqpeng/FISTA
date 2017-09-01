function tv = tp_tv( x )
%TP_TV calculates the total variation in x

[p, q]=tp_lt(x);

tv = sum(sum(abs(p)))+sum(sum(abs(q)));

end

