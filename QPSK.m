clear
clc
% signal Generation
% 
% BER_arr = zeros(1, length(-10:1:25));
% SER_arr = zeros(1, length(-10:1:25));
% cnt_recd = 1;
% 
% for Eb_N0=-10:1:25
% Eb_N0
len = 1000000;
bin_seq = zeros(1, len);  % input data

numofbit = 2;
symbols = ["00", "01", "11", "10"];  % Graymapping, index = m
symbol_length = numofbit;
len_sym_seq = len/numofbit;

Eb_N0 = 8;
Eb_N0_lin = 10^(Eb_N0/10);
Es = 1;
Eb = 1/(numofbit);
N0 = (Eb_N0_lin/Eb)^-1;
sigma = sqrt(N0/2);  % AWGN의 표준편차

% bit sequence 생성
for i=1:length(bin_seq)
    bin_seq(i) = round(rand);
end
%     
%     figure(1)
%     histogram(bin_seq)
sym_arr = zeros(1, len_sym_seq);
% Convert Symbol
sym_cnt = 1;
for i=1:2:len-1  % 이 과정이 g_T(t)의 Rect임.
    tmp_sym = string(bin_seq(i:i+1));
    str_sym = strjoin(tmp_sym, "");
    m = find(symbols==str_sym);  % symbol index
    sym_arr(sym_cnt) = m;
    sym_cnt = sym_cnt + 1;
end
transmit_signals = exp(j*((sym_arr*pi/2)+pi/4));  % 전송하는 signal
noise1 = zeros(1, len_sym_seq);  % real방향 noise
noise2 = zeros(1, len_sym_seq);  % imag방향 noise
for i=1:len_sym_seq
    noise1(i) = randn * sigma;  % noise 생성
    noise2(i) = randn * sigma;  % noise 생성
end

transmit_signals = transmit_signals + noise1;  % AWGN을 거친 Signal
transmit_signals = transmit_signals + j*noise2;  % AWGN을 거친 Signal

real_sig = real(transmit_signals);
imag_sig = imag(transmit_signals);
% 
%     figure(2)
%     hist1 = histogram(real_sig);
%     figure(3)
%     hist2 = histogram(imag_sig);
% 
%     scatter(real_sig, imag_sig);
%     ylim([-1, 1])
% 
% grid on
% 
% Demodulation Symbol
Demodulated_sym = zeros(1, len_sym_seq); % Demodulate된 symbol이 들어갈 list
sym_list = 1:2^symbol_length; % Symbol의 index
GT = exp(j*((sym_list*pi/2)+pi/4)); % Symbol의 종류
for i=1:length(transmit_signals)
    [~, index] = max((1/(2*pi*(sigma^2)))*exp(-abs(transmit_signals(i)-GT)/(2*(sigma^2))));
    % Optimal Detection
    Demodulated_sym(i) = index; % 검출된 Symbol의 index저장
end

Demodulated_seq = double.empty; % Symbol을 bit로 변환하기 위한 빈 배열
cnt = 1;
for i=1:length(Demodulated_sym)
    sym_idx = Demodulated_sym(i); % symbol index 추출
    str_sym = symbols(sym_idx); % index에 대응하는 symbol 추출
    str_sym_arr = split(str_sym, "");  % symbol의 비트화
    str_sym_arr = transpose(str_sym_arr(strlength(str_sym_arr)>0)); % 후처리 ""을 없엔다.
    for k=str_sym_arr
        Demodulated_seq(cnt) = str2num(k); % bit에 추가
        cnt = cnt+1;
    end
end

sym_error_cnt = sum(sym_arr~=Demodulated_sym);  % SER 계산
bit_error_cnt = sum(bin_seq~=Demodulated_seq);  % BER 계산

SER = sym_error_cnt/len_sym_seq
BER = bit_error_cnt/len;
%     
%     figure(4)
%     hist = histogram(Demodulated_seq);
%     BER_arr(cnt_recd) = BER;
%     SER_arr(cnt_recd) = SER;
%     cnt_recd = cnt_recd + 1;
% end
