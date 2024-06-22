function neighborsAgentsSet = formNeighborhoodAgentsSets(q_x, q_y, q_z, r)
    N = size(q_x, 1);
    neighborsAgentsSet  = zeros(N,N);
    for index=1:N
        x_i = q_x(index, end);
        y_i = q_y(index, end);
        z_i = q_z(index, end);
        for indey=1:N
            if indey == index
                continue
            end
            x_j = q_x(indey, end);
            y_j = q_y(indey, end);
            z_j = q_z(indey, end);
            dist = euclidean_dist([x_j;y_j;z_j]-[x_i;y_i;z_i]);
            if dist < r
                neighborsAgentsSet(index, indey) = 1;
            end
        end
    end
end