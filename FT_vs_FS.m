clear
clc
close all

s = 0.01;
T0 = 10;
hold on
t_max = 20;
t0 = -4*t_max:s:4*t_max;
v0 = zeros(1, length(t0));

for a = 0:T0:t_max % 오른쪽으로 주기 함수 생성
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

for a = 0:-1*T0:-t_max % 오른쪽으로 주기 함수 생성
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

% 주기함수 생성 종료 % Rect
%plot(t0, v0)
hold on
[t, fun_v] = getrect(1, 0, s);

[t, amp, phz, res] = FT(fun_v, s);
% [t, amp, phz] = IFT(res, s);
plot(t, amp)

[t, amp, phz] = FS(v0, s, T0, 100);
plot(t, amp)
legend(["FT", "FS"])
xlim([-20,20])
xticks(-20:8:20)

% saveas(gcf, "Prob_1/FS_T8.png")
% saveas(gcf, "Prob_1/FSvsFT_T8.png")
saveas(gcf, "Prob_1/FSvsFTs_T100.png")

%plot(t, phz)