clear
clc

s = 1/100; % step size (impulse sampling : Ts)
t = -10:s:10; % Domain
[t, x1] = dtsinc(200, t, t);
[t, x2] = dtsinc(300, t, t);
x = 5*x1 + 2*x2;  % bandwidth : 150 (100, 150)
plot(t, x)
