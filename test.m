clc
clear

% Define the rect function.
x = -1:0.01:1;
y = rectangularPulse(x);

% Compute the Fourier transform of the rect function.
Y = fft(y);

% Plot the amplitude and phase of the Fourier transform.
figure;
subplot(2,1,1);
plot(abs(Y));
title('Amplitude of the Fourier transform');
xlabel('Frequency');

subplot(2,1,2);
plot(angle(Y));
title('Phase of the Fourier transform');
xlabel('Frequency');