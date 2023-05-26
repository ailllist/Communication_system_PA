clear
clc

hold on;
s = 0.01;
[t, v] = getrect(1, 0, s);
plot(t, v)
%[t, v] = convolution(v, v, s);
%plot(t, v)

%[t, amp, phz] = FT(v, s);

%plot(t, amp)
%plot(t, phz)