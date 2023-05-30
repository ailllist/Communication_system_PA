function [t, v] = dtsinc(a, t, x)
    v = sin(a * pi * x)./(a * pi * x); % rect(t)의 경우 sin(pi*f)/(pi*f)로 sinc를 정의
end