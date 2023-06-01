function [t, v] = convolution(x1, x2, s)
    % s : unit time
    % 다시 짜야된다.
    % t : domain of conv
    % v : range of conv

    x2_1 = flip(x2);  % 음수로 보낼 것
    x2_2 = x2_1; % 양수로 보낼 것
    dist = length(x1) + length(x2); % 배열의 총 길이
    tot_time = (dist-2) * s; % 총 걸린 시간
    t = -tot_time:s:tot_time; % x1과 x2의 시간을 모두 포함
    v = zeros(1,length(t)); % range
    center_idx = ceil(length(t)/2); % t=0을 기준으로 좌우로 
    % convolution을 할것이기에, 중심 값을 불러온다.
    normalizer = sum(x1);  % Rect함수이기에, 
    % conv결과에 1의 갯수만큼 나눠주면 실제 값이 나온다.
    
    v(center_idx) = sum(x1 .* x2_1) / normalizer; % t=0일때의 convolution
    % t = 0 -> -dist까지 conv
    cnt = center_idx-1;
    for i=0:-s:-tot_time % 음의 방향으로 conv
        if i==0 % index맞추기 용
            continue
        end
        x2_1(1) = 0; % 첫번째 값을 0으로 바꾸고
        x2_1 = circshift(x2_1, -1); % 음의 방향으로 
        % circshift를 하면 0이 뒤에 추가된다.
        v(cnt) = sum(x1 .* x2_1) / normalizer; % convolution
        cnt = cnt-1; % index감소
    end
        % t = 0 -> dist까지 conv
    cnt = center_idx+1; % 양의 방향으로 convolution하기 위해 cnt 초기화 
    for i=0:s:tot_time % 양의 방향으로 conv
        if i==0 % index맞추기 용
            continue
        end
        x2_2(end) = 0; % 마지막 값을 0으로 바꾸고,
        x2_2 = circshift(x2_2, 1); % 양의 방향을
        % circshift를 하면 0이 앞에 추가된다.
        v(cnt) = sum(x1 .* x2_2) / normalizer; % convoultion
        cnt = cnt+1; % index 증가
    end
end