function [t, v] = dtsinc(a, t, x, n)
    v = sin(pi*(a*(x-n)))./(pi*(a*(x-n))); % rect(t)의 경우 sin(pi*f)/(pi*f)로 sinc를 정의
%     v((length(x)+1)/2) = (v((length(x)+1)/2 - 1) + v((length(x)+1)/2 + 1))/2;
    if sum(isnan(v)) >= 1 % sampling과정중에 정확히 sinc의 중앙을 지나면,
        idx_nan = find(isnan(v));  % 0/0꼴 (sinc의 중앙)
        v(idx_nan) = 1; % 1로 변경
    end
end

