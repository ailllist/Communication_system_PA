t = -100:0.0001:100;

[t, v] = dtsinc(2, t, t, 10);
plot(t, v)