clear
clc
% signal Generation

% BER_arr = zeros(1, length(-10:1:25));
% SER_arr = zeros(1, length(-10:1:25));
% cnt_recd = 1;
% 
% for Eb_N0=-10:1:25
%     Eb_N0

len = 600;
bin_seq = zeros(1, len);  % input data

numofbit = 4; 
phaze_symbols = ["00", "01", "11", "10"];  % a, b에 대응되는 비트
amp_symbols = [-3, -1, 1, 3];  % a, b

symbol_length = numofbit;
len_sym_seq = len/numofbit;
Eb_N0 = 20;
Eb_N0_lin = 10^(Eb_N0/10);
Es = 10;
Eb = Es/(numofbit);
N0 = (Eb_N0_lin/Eb)^-1;
sigma = sqrt(N0/2);  % AWGN의 표준편차
% bit sequence 생성
for i=1:length(bin_seq)
    bin_seq(i) = round(rand);
end 
%     figure(1)
%     histogram(bin_seq)
sym_arr = zeros(1, len_sym_seq);
% convert Symbol
sym_cnt = 1;
for i=1:numofbit:len-1
    tmp_seq = bin_seq(i:i+3);  % 4개가 1개의 symbol
    for k=1:2
        sym_1 = strjoin(string(tmp_seq(1:1:2)),""); % Real (a)
        sym_2 = strjoin(string(tmp_seq(3:1:4)),""); % Imag (b)
    end
    a = find(phaze_symbols==sym_1);  % Real축 symbol 생성
    b = find(phaze_symbols==sym_2);  % imag축 symbol 생성
    tmp_sig = amp_symbols(a) + amp_symbols(b)*j; % QAM symbol
    sym_arr(sym_cnt) = tmp_sig;
    sym_cnt = sym_cnt + 1;
end

noise1 = zeros(1, len_sym_seq);
noise2 = zeros(1, len_sym_seq);

for i=1:len_sym_seq
    noise1(i) = randn * sigma;  % noise 생성
    noise2(i) = randn * sigma;  % noise 생성
end

transmit_signals = sym_arr + noise1 + j*noise2;  % noisy signal

real_sig = real(transmit_signals);
imag_sig = imag(transmit_signals);

%     figure(2)
%     hist1 = histogram(real_sig);
%     figure(3)
%     hist2 = histogram(imag_sig);
%     
scatter(real_sig, imag_sig);
ylim([-1, 1])

grid on

% Demodulation
Demodulated_sym = zeros(1, len_sym_seq);
for i=1:length(transmit_signals)
    [~, index1] = max((1/(2*pi*(sigma^2)))*exp(-abs(real(transmit_signals(i))-amp_symbols)/(2*(sigma^2))));
    % get real index
    [~, index2] = max((1/(2*pi*(sigma^2)))*exp(-abs(imag(transmit_signals(i))-amp_symbols)/(2*(sigma^2))));
    % get imag index
    recv_sym = amp_symbols(index1) + j*amp_symbols(index2); % received signal
    Demodulated_sym(i) = recv_sym;
end

Demodulated_seq = double.empty;
% Symbol to Bit sequence
cnt = 1;
for i=1:length(Demodulated_sym)
    symbol = Demodulated_sym(i);
    real_idx = find(real(symbol)==amp_symbols); % a에 대응되는 bit seq의 index를 얻는다.
    imag_idx = find(imag(symbol)==amp_symbols); % b에 대응되는 bit seq의 index를 얻는다.
    str_real_sym = phaze_symbols(real_idx); % a에 대응되는 bit seq
    str_imag_sym = phaze_symbols(imag_idx); % b에 대응되는 bit seq
    str_sym = str_real_sym+str_imag_sym; % 두 bit seqeuence를 concat하여 온전한 bit seq를 얻는다.
    str_sym_arr = split(str_sym, ""); % array화 (1)
    str_sym_arr = transpose(str_sym_arr(strlength(str_sym_arr)>0)); % array화 (2)
    for k=str_sym_arr
        Demodulated_seq(cnt) = str2num(k); % string array -> double array
        cnt = cnt+1;
    end
end
    
%     figure(4)
%     hist = histogram(Demodulated_seq);

sym_error_cnt = sum(sym_arr~=Demodulated_sym);
bit_error_cnt = sum(bin_seq~=Demodulated_seq);

SER = sym_error_cnt/len_sym_seq
BER = bit_error_cnt/len

prob_1 = sum(bin_seq==1)/len
prob_2 = sum(Demodulated_seq==1)/len
% 
%     BER_arr(cnt_recd) = BER;
%     SER_arr(cnt_recd) = SER;
%     cnt_recd = cnt_recd + 1;
% end