function [t, v] = dtsinc(a, t, x, n, nan_pass)
    v = sin(a * pi * (x-n))./(a * pi * (a*x-n)); % rect(t)의 경우 sin(pi*f)/(pi*f)로 sinc를 정의
    % if isnan(v((length(x)+1)/2)) & nan_pass
    %     v((length(x)+1)/2) = 1;
    % end
    % v((length(x)+1)/2) = 1;  % 이걸 빼야 왜 제대로 될까?
end