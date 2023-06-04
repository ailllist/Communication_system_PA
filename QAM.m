clear
clc
% signal Generation

% BER_arr = zeros(1, length(-10:1:25));
% SER_arr = zeros(1, length(-10:1:25));
% cnt_recd = 1;
% 
% for Eb_N0=-10:1:25
% Eb_N0

len = 400;
bin_seq = zeros(1, len);  % input data

numofbit = 4;
phaze_symbols = ["00", "01", "10", "11"];

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

sym_arr = zeros(1, len_sym_seq);

for i=1:numofbit:len-1
    tmp_seq = bin_seq(i:i+3);
    for k=1:2
        sym_1 = tmp_seq(1:2:4); % Quad
        sym_2 = tmp_seq(2:2:4); % In-phase
    end
end

