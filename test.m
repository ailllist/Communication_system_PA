clear
clc

%s = 1/300;
s = 0.1;
[t, x] = getrect(1, 1, 0.001);
%plot(x)
Y = fft(x);
stem(angle(Y))
