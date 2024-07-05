function neighborsBoundariesSet = formNeighborhoodBoundariesSets(q_x, q_y, rZegond, bounds)
    N = size(q_x, 1);
    neighborsBoundariesSet  = zeros(N,size(bounds,2));
    
    for index=1:N
        x_i = q_x(index, end);
        y_i = q_y(index, end);

        qi = [x_i;y_i];
        
        for indey=1:size(bounds,2)
            qhat = projectAgent_on_Boundaries(qi, bounds(:, indey));

            dist = euclidean_dist(qhat - qi);
%             fprintf(">>> Distance from Vehicle %d to Obstacle %d = %f \n", index, indey, dist)
            
            if dist < rZegond
                neighborsBoundariesSet(index, indey) = 1;
            end
        end
    end
end