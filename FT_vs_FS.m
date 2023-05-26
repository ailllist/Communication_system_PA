clear
clc

s = 0.01;
T0 = 50;
hold on
t0 = -40:s:40;
v0 = zeros(1, length(t0));

for a = 0:T0:20 % 오른쪽으로 주기 함수 생성
    [t, v] = getrect(1, a, s);
    cnt = 1;
    while t0(cnt) ~= t(1) % t의 시작점으로 이동
        cnt = cnt+1;
    end
    % t0(cnt) == t(cnt)
    for i=v
        if v0(cnt) == 0
            v0(cnt) = i; % 각각의 rect함수를 집어넣는다.
        end
        cnt = cnt+1;
    end
end

for a = 0:-1*T0:-20 % 오른쪽으로 주기 함수 생성
    [t, v] = getrect(1, a, s);
    cnt = 1;
    while t0(cnt) ~= t(1) % t의 시작점으로 이동
        cnt = cnt+1;
    end
    % t0(cnt) == t(cnt)
    for i=v
        if v0(cnt) == 0
            v0(cnt) = i; % 각각의 rect함수를 집어넣는다.
        end
        cnt = cnt+1;
    end
end

% 주기함수 생성 종료

[t, amp, phz] = FS(v0, s, T0);
plot(t, amp)
%plot(t, phz)

% ?? FS의 결과와 FT의 결과를 비교하는 방법을 찾아봐야될 듯.