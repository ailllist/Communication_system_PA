clear
clc

s = 1/300; % step size (impulse sampling : Ts)
t = -10:s:10; % Domain
[t, x1] = dtsinc(200, t, t, 0, false);
[t, x2] = dtsinc(300, t, t, 0, false);
x = 5*x1 + 2*x2;  % bandwidth : 150 (100, 150)

figure(1)
stem(t, x)

res = zeros(1, length(t));


for n = 1:length(t)
    % [t, pre_sinc] = dtsinc(300, t, t, n-(length(t)+2)/2, true);
    [t, pre_sinc] = dtsinc(1/s, t, t, t(n), true);
    tmp = pre_sinc * x(n);
    if isnan(tmp)
        find(isnan(tmp))
        n
        break
    end
    res = res + tmp;

    % plot(t, res)
    % drawnow
end


figure(2)
stem(t, res)

