clear
clc

%s = 1/300;
t = -10:0.001:10;
[t, x1] = dtsinc(200, t, t, 0);
[t, x2] = dtsinc(300, t, t, 0);
x = 5*x1 + 2*x2;
plot(t, x)
Y = fft(x);
%
plot(abs(Y))

array = [1, 4, 7, 10, 13];  % Example array
value = 9;                  % Example value

[~, index] = min(abs(array - value));  % Find the index of the nearest value
nearestValue = array(index);           % Get the nearest value

disp(nearestValue);  % Display the nearest value