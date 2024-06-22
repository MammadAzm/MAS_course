function neighborsObstaclesSet = formNeighborhoodObstaclesSets(q_x, q_y, rPrime, obs, Rk)
    N = size(q_x, 1);
    neighborsObstaclesSet  = zeros(N,size(obs,2));
    
    for index=1:N
        x_i = q_x(index, end);
        y_i = q_y(index, end);

        qi = [x_i;y_i];
        
        for indey=1:size(obs,2)
            qhat = projectAgent(qi, obs(:,indey), Rk(indey));

            dist = euclidean_dist(qhat - qi);
%             fprintf(">>> Distance from Vehicle %d to Obstacle %d = %f \n", index, indey, dist)
            
            if dist < rPrime
                neighborsObstaclesSet(index, indey) = 1;
            end
        end
    end
end