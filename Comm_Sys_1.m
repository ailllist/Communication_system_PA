clear
clc
close all

s = 0.1;
[t, v] = getrect(1, 0, s);

%[t, v] = convolution(v, v, s);
stem(t, v)
[t, amp, phz] = FT(v, s);

%Phaze 안정화... (pi근처 점들을 0으로 변경)
for i=1:length(phz)
    if abs(abs(phz(i)) - pi) < 0.001
        phz(i) = 0;
    end
end

%plot(t, amp)
stem(t, phz)


%saveas(gcf, "Prob_1/convk0.5a0.png")
