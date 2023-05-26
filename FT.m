function [t, amp, phz] = FT(x, s)
    % s : unit time
    tot = (length(x)-1) * s; % 총 시간
    t = -tot/2:s:tot/2;
    n = length(t);
    res = zeros(1, n);
    cnt = 1;
    for f=t
        exp_sig = x.*exp(-j*2*pi*t*f);
        res(cnt) = sum(exp_sig)*(tot/n);
        cnt = cnt+1;
    end
    amp = abs(res);
    phz = angle(res);
end