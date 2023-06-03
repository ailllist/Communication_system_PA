function [SQNR] = get_SQNR(x, quant_res)
    xt_qxt = x - quant_res;
    exp_xt_qxt = (1/length(xt_qxt))*sum(xt_qxt);
    x2 = x.^2;
    exp_x2 = (1/length(x2))*sum(x2);
    SQNR = exp_x2 / exp_xt_qxt;
end

