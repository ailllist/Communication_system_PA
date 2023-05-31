clear
clc

s = 0.01
t = -10:s:10;
[t, x1] = dtsinc(1, t, t, 0, true);
% [t, v] = FT(x1, s);

plot(t, x1)