clear
clc

hold on;
s = 0.01;
[t, v] = getrect(1, 1, s);
plot(t, v)
[t, v] = convolution(v, v, s);
plot(t, v)

[t, v] = FT(v, s);