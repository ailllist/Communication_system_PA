clear
clc

s = 1/300; % step size (impulse sampling : Ts)
t = -10:s:10; % Domain
scale_fac = 2;
[t, x1] = dtsinc(200, t, t, 0);
[t, x2] = dtsinc(300, t, t, 0);
x = 5*x1 + 2*x2;  % bandwidth : 150 (100, 150)

t1 = -10:(1/scale_fac)*s:10; % 새롭게 Domain을 정의하는 이유는, Reconstruct
% 과정에서 sinc function은 continuous하기 때문에, continuous하게 만들어주기 위함.
% 특히, sinc function이 Ts와 같이 만들면, peak point가 소실되 restore가 잘 되지 않는다.
res = zeros(1, length(t1));

% reconstruct
for n = 1:length(t)
    % [t, pre_sinc] = dtsinc(300, t, t, n-(length(t)+2)/2, true);
    [t1, pre_sinc] = dtsinc(1/s, t1, t1, t(n));  % t(n)은 time shifting 1/s는 time scale factor, 두 변수는 서로 독립적이다. (ax - n)
    tmp = pre_sinc * x(n);
    res = res + tmp;
%     n
%     plot(t, res)
%     drawnow
end

res = res/scale_fac;

% figure(1)
% stem(t, x)
% 
% figure(2)
% stem(t1, res)

% Quantization
% input : time sampling value  x
% output : Quantization value

minx = min(x);
maxx = max(x);
numofbit = 4;
totslot = 2^numofbit;
step_size = (maxx-minx) / (2*(totslot-1));
epochs = 10; % num of iteration
% init x hat, a, 많은 case에 대해서도 진행.
centroids = linspace(minx, maxx, totslot); % xhat
bounds = linspace(minx+step_size, maxx-step_size, totslot-1); % a

quant_res = zeros(1, length(x));
for i=1:length(x)
    [~, idx] = min(abs(centroids-x(i)));
    quant_res(i) = centroids(idx);
end


bins = -5:0.001:5; % bit가 크면, 정밀도를 더 높여줘야 된다.

% get_pdf
[values, edges] = histcounts(x, bins, "Normalization", "pdf");


% start lloyd
for eps=1:1
    % update centroid
    centroids = update_centroid(centroids, bounds, values, edges)
    % update bound
    bounds = update_bounds(centroids);
    quant_res = zeros(1, length(x));
    % re-Quantization
    for i=1:length(x)
        [~, idx] = min(abs(centroids-x(i)));
        quant_res(i) = centroids(idx);
    end
end
hold on
stem(t, quant_res)
stem(t, x)
legend(["after", "prev"])

