function [f_list, amp, phz, res] = FT(x, s)
    % s : unit time
    tot = (length(x)-1) * s; % 총 시간
    t = -tot/2:s:tot/2; % x의 time index 추출
    n = length(t); % 총 slot의 수
    f_list = -160/tot:s:160/tot; % frequency domain의 f index
    res = zeros(1, length(f_list)); % X(f)값이 저장될 공간
    cnt = 1;
    % 적분 시작
    for f=f_list
        exp_sig = x.*exp(-j*2*pi*t*f); % 피적분함수 생성
        res(cnt) = sum(exp_sig)*(tot/n); % t에 대해 리만 합 진행
        cnt = cnt+1;
    end
    amp = abs(res); % Amplitude
    phz = angle(res); % phase
end


