function [t, amp, phz] = FT(x, s)
    % s : unit time
    tot = (length(x)-1) * s; % 총 시간
    t = -tot:s:tot;
    
end