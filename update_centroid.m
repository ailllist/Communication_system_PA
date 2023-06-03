function [new_centroid] = update_centroid(centroids, bounds, values, edges)
    pdf_values = values;  % PDF값 취득
    bin_edges = edges; 
    new_centroid = zeros(1, length(centroids));
    for idx_a = 1:length(bounds)+1
        % 적분 구간 설정
        if idx_a == 1
            a_prev = -inf;
        else
            a_prev = bounds(idx_a-1);
        end
        % 마지막 index인 경우
        if idx_a == length(bounds)+1
            a_curr = inf;
        else % 그 외
            a_curr = bounds(idx_a);
        end
    
        % 리만합
        pre_sum1 = 0;
        pre_sum2 = 0;
        for i=1:length(pdf_values)
            if bin_edges(i) > a_prev && bin_edges(i) < a_curr
                if pdf_values(i) <= 0.0001  % 값이 없으면, 0이되서 점이 소실되기에
                    % 아주 작은 확률을 집어넣어준다.
                    pdf_value = 0.0001;
                else
                    pdf_value = pdf_values(i);
                end
                
                pre_sum1 = pre_sum1 + bin_edges(i) * pdf_value; % 분자항
                % 어차피 나누기기 때문에 직사각형의 밑변은 약분된다.
                pre_sum2 = pre_sum2 + pdf_value; % 분모항
            elseif bin_edges(i) > a_curr % 그 뒤는 볼 필요가 없기에 패스
                    break;
            end
        end
        
        new_centroid(idx_a) = pre_sum1 / pre_sum2; % centroid 계산
    end
end


