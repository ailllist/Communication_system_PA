
clc
close all

s = 1/300; % step size (impulse sampling : Ts)
t = -10:s:10; % Domain

[t, x1] = dtsinc(200, t, t, 0);
[t, x2] = dtsinc(300, t, t, 0);
x = 5*x1 + 2*x2;  % bandwidth : 150 (100, 150), sinc function 생성


% s0 = 1/30000; % step size (impulse sampling : Ts)
% t0 = -10:s0:10; % Domain
% [t0, x10] = dtsinc(200, t0, t0, 0);
% [t0, x20] = dtsinc(300, t0, t0, 0);
% x0 = 5*x10 + 2*x20;  % bandwidth : 150 (100, 150), 목표 함수 생성

% % reconstruct
% scale_fac = 3;
% t1 = -10:(1/scale_fac)*s:10; % 새롭게 Domain을 정의하는 이유는, Reconstruct
% % 과정에서 sinc function은 continuous하기 때문에, continuous하게 만들어주기 위함.
% res = zeros(1, length(t1)); % reconstruction된 함수가 들어갈 배열
% 
% for n = 1:length(t)
%     [t1, pre_sinc] = dtsinc(1/s, t1, t1, t(n));  % filter 생성
% 
%     tmp = pre_sinc * x(n);
%     res = res + tmp;  % update
% %     plot(t1, res)
% %     ylim([-2, 7])
% %     drawnow
% end

% hold on
% plot(t0, x0, "r")
% stem(t, x, "Color",[0 0.4470 0.7410])
% plot(t1, res, "k")
% 
% xlim([-0.5,0.5])
% xticks(-1:0.1:1)
% % legend(["original", "sampled"])
% legend(["original", "sampled", "reconstructed"])

% saveas(gcf, "Prob_2/xt_samp_more_vs.png")
% saveas(gcf, "Prob_2/xt_samp_reconst_more.png")

% Quantization
% input : time sampling value  x
% output : Quantization value

minx = min(x)/2;  % Quantiazation 값의 initialization을 위한 값
maxx = max(x)/2;  % Quantiazation 값의 initialization을 위한 값
numofbit = 8;  % bit의 갯수
totslot = 2^numofbit;  % slot의 수
step_size = (maxx-minx) / (2*(totslot-1));  % Quantization값에서
% 가장 가까운 bound까지의 거리
epochs = 10; % num of iteration

% init x hat, a, 많은 case에 대해서도 진행.
centroids = linspace(minx, maxx, totslot); % xhat
bounds = linspace(minx+step_size, maxx-step_size, totslot-1); % a

quant_res = zeros(1, length(x));  % 결과값이 저장될 배열

for i=1:length(x)
    [~, idx] = min(abs(centroids-x(i)));  % 가장 가까운 Quantization 값의 index를 얻는다.
    quant_res(i) = centroids(idx);  % 해당 값에 대응시킨다.
end

% figure(1)
% hold on
% stem(t, x)
% stem(t, quant_res)
% legend(["prev", "after"])
% saveas(gcf, "Prob_2/quant_prev_N16_1.png")

bins = -20:0.0001:20; % bit가 크면, 정밀도를 더 높여줘야 된다.
% get_pdf
[values, edges] = histcounts(x, bins, "Normalization", "pdf");
% start lloyd
for eps=1:200
    % update centroid
    eps
    cent_prev = centroids;
    centroids = update_centroid(centroids, bounds, values, edges);
    % update bound
    bounds = update_bounds(centroids);
    quant_res = zeros(1, length(x));
    % re-Quantization
    for i=1:length(x)
        [~, idx] = min(abs(x(i)-centroids));
        quant_res(i) = centroids(idx);
    end
    dist = sum(abs(cent_prev-centroids));
    if dist <= 0.001
        break
    end
end

SQNR = get_SQNR(x, quant_res)

% figure(2)
% hold on
% stem(t, x)
% stem(t, quant_res)
% legend(["prev", "after"])
% saveas(gcf, "Prob_2/quant_N16_1.png")
