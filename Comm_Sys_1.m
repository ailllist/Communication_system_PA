clear
clc
close all

s = 0.01;
[t, v] = getrect(2, 0, s);

[t, v] = convolution(v, v, s);

[t, amp, phz] = FT(v, s);

%Phaze 안정화... (pi근처 점들을 0으로 변경)
for i=1:length(phz)
    if abs(abs(phz(i)) - pi) < 0.001
        phz(i) = 0;
    end
end

% plot(t, amp)
stem(t, phz)

xlim([-1, 1])
xticks(-1:0.5:1)

saveas(gcf, "Prob_1/FTphzx2k2a0.png")
