clear
clc
% signal Generation

BER_arr = zeros(1, length(-10:1:25));
cnt = 1;

for Eb_N0=-10:1:25
    len = 1000000;
    bin_seq = zeros(1, len);  % input data
    numofbit = 1;
    symbols = [0, 1];
    symbol_length = numofbit;
%     Eb_N0 = 8;
    Eb_N0_lin = 10^(Eb_N0/10);
    Es = 1;
    Eb = 1/(numofbit);
    N0 = (Eb_N0_lin/Eb)^-1;
    sigma = sqrt(N0/2);  % AWGN의 표준편차
    
    % bit sequence 생성
    for i=1:length(bin_seq)
        bin_seq(i) = round(rand);
    end
    
    % histogram(bin_seq)
    
    % sym_seq = (2 * bin_seq) - 1;  % convert to symbol
    
    sym_arr = zeros(1, len);
    for i=1:len
        m = find(symbols==bin_seq(i));  % symbol index
        sym_arr(i) = m;
    end
    
    transmit_signals = exp(j*sym_arr*pi);  % 전송하는 signal
    noise = zeros(1, len);
    for i=1:len
        noise(i) = randn * sigma;
    end
    
    transmit_signals = transmit_signals + noise;  % AWGN을 거친 Signal
    
    real_sig = real(transmit_signals);
    imag_sig = imag(transmit_signals);
    % 
    % hist = histogram(real_sig);
    
    % scatter(real_sig, imag_sig);
    % ylim([-1, 1])
    
    % Demodulation
    Demodulated_sig = zeros(1, len);
    for i=1:len
        [~, index] = max((1/(2*pi*(sigma^2)))*exp(-(real_sig(i)-[-1, 1]).^2/(2*(sigma^2))));
        Demodulated_sig(i) = symbols(index);
    end
    % 
    hist = histogram(Demodulated_sig);
    
    error_arr = abs(bin_seq - Demodulated_sig);  % 
    sum(error_arr) % 37793, 37432
    BER = sum(error_arr) / len;  % Bit Error Rate 계산 
    BER_arr(cnt) = BER;
    cnt = cnt + 1;
end


