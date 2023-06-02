x = -4*pi:0.1:4*pi;

fx = -j*exp(-2*pi*x*j);
stem(x, angle(fx))