function [t, amp, phz] = FS(x, s, T0, k_max)
    tot = (length(x)-1) * s; % 총 시간

    t = -tot/2:s:tot/2; % time
    res = zeros(1, length(t));
    start = t(1);
    diff = -T0/2 - start; % t에서 -T0/2까지의 거리
    diff_cnt = diff/s; % t에서 [-T0/2, T0/2]까지 가야되는 cnt
    fun_t = -T0/2:s:T0/2;  % 주기 1개 함수의 domain
    fun_v = zeros(1, length(fun_t));  % 주기 1개 함수의 value
    interval_cnt = T0/s; % 1주기의 cnt
    cnt = 1;
    for i=1+diff_cnt:1:1+diff_cnt+interval_cnt
        fun_v(cnt) = x(i);  % 0을 중심을 하는 1주기 함수 추출
        cnt = cnt+1;
    end
    
    n = length(fun_v) - 1;  % 구분구적법의 n
    k_list = -k_max:1:k_max;  % C_k의 개수
    c_k = zeros(1, length(k_list));  % c_k를 저장할 배열
    cnt = 1;

    % c_k 생성
    for k = k_list
        exp_sig = fun_v.*exp(-j*2*pi*k*fun_t*(1/T0));  % x(t)*exp
        c_k(cnt) = (1/T0)*sum(exp_sig)*(T0/n);
        cnt = cnt+1;
    end

    cnt = 1;
    % c_k를 기반으로 신호 재생성
    for k = k_list
        coeff = c_k(cnt);
        kth_sig = coeff * exp(j*2*pi*k*t*(1/T0));
        res = res + kth_sig;
        cnt = cnt+1;
    end
    c_k
    amp = abs(res);
    phz = angle(res);

end