
EbN0_dB = -10:0.1:10;
EbN0 = 10.^(EbN0_dB/10);
BER = 1/3.*erfc(sqrt(EbN0));
SER = 3*BER;
semilogy(EbN0_dB,BER)
% plot(EbN0_dB,SER)
grid on
ylabel('BER')
xlabel('E_b/N_0 (dB)')
title('BER for QPSK')


% A='01010001101010';
% num2cell(A)
% Output=char(num2cell(A))
% Output = str2num(Output);