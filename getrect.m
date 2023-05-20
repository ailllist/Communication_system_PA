function [t, v] = getrect(k, a, s)
    % t = (1/k)*(-2+a):s:(1/k)*(2+a); 이대로 하면 time shifting됬는지 알기 어려움
    t = -1 * (1/k)*(2+a):s:(1/k)*(2+a); %그래서 t=0을 가운데에 두고 코딩
    v = zeros(1, length(t)); % range를 만든다.
    cnt = 1; % range용 index
    for i = -1*(1/k)*(2+a):s:(1/k)*(2+a) % domain의 원소를 하나씩 다 살펴봄
        if ((1/k)*(-1/2+a) <= i) && (i <= (1/k)*(1/2+a)) % rect의 정의 a를 기준으로 rect를 만든다.
            v(cnt) = 1;
        end
        cnt = cnt + 1;
    end
end