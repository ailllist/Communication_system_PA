function [new_bounds] = update_bounds(centroids)
    new_bounds = zeros(1, length(centroids)-1);
    for i=1:length(new_bounds)
        new_bounds(i) = (centroids(i) + centroids(i+1))/2;
    end
end