function [t_list, amp, phz] = IFT(x, s)
    % s : unit time
    tot = (length(x)-1) * s; % 총 주파수 영역
    f = -tot/2:s:tot/2; % x의 frequency index 추출
    n = length(f); % 총 slot의 수
    t_list = -160/tot:s:160/tot; % time domain의 t index
    res = zeros(1, length(t_list)); % x(t)값이 저장될 공간
    cnt = 1;
    % 적분 시작
    for t=t_list
        exp_sig = x.*exp(j*2*pi*t*f); % 피적분함수 생성
        res(cnt) = sum(exp_sig)*(tot/n); % f에 대해 리만 합 진행
        cnt = cnt+1;
    end
    
    amp = abs(res); % Amplitude
    phz = angle(res); % phase
end

