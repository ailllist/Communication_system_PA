
EbN0_dB = -10:0.1:25;
EbN0 = 10.^(EbN0_dB/10);
% BPSK
% BER = 1/2.*erfc(sqrt(EbN0));

% QPSK
% BER = 1/2.*erfc(sqrt(EbN0));
% SER = 2*BER;

% 8PSK
% SER = erfc(sqrt(2*EbN0)*sin(pi/8));
% BER = (1/3)*SER;

% 16 QAM
% P_M = (3/4)*erfc(sqrt((2/5)*EbN0));
% SER = 1 - (1-P_M).^2;
% BER = (1/4)*SER;

% semilogy(EbN0_dB,BER)
semilogy(EbN0_dB,BER)
grid on
ylabel('BER')
xlabel('E_b/N_0 (dB)')
title('BER for QAM')
