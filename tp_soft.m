function x = tp_soft( in, thresh )
%TP_SOFT soft thresholding projection with l1 regularization term

    x = in;
    x(abs(x) < thresh) = 0;
    x(abs(x) >= thresh) = x(abs(x) >= thresh) - sign(x(abs(x) >= thresh))*thresh;

   
end

