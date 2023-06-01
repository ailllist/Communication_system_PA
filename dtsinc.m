function [t, v] = dtsinc(a, t, x, n)
    v = sin(pi*(a*x-n))./(pi*(a*x-n)); % rect(t)의 경우 sin(pi*f)/(pi*f)로 sinc를 정의
    v((length(x)+1)/2) = (v((length(x)+1)/2 - 1) + v((length(x)+1)/2 + 1))/2;  % 0/0인 부분은 양쪽값의 평균으로 정의
    % 1로 두는게 맞지만, sampling interval에 따라 1이 무시 될 수 있기에...
end