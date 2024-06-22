clc; clear;

run("CONSTANTS.m");

rng(13);

figure(1);
hold on;

graphics_edges = gobjects(N,N);
graphics_leader = gobjects(1,1);
graphics_obstacles = gobjects(size(obs, 2), 1);
graphics_agents = gobjects(N,1);

theta = linspace(0, 2*pi, 100);
for i=1:size(obs,2)
    rs = Rk(i):-0.01:0;
    temp_x = [];
    temp_y = [];
    for j=1:length(rs)
        temp_x = [temp_x, obs(1,i) + rs(j) * cos(theta)];
        temp_y = [temp_y, obs(2,i) + rs(j) * sin(theta)];
    end
    graphics_obstacles(i) = plot(temp_x, temp_y, LineWidth=2, Color="red");
end

for i = 1:N
    for j=1:N
        graphics_edges(i,j) = plot([0, 0], [0, 0], LineWidth=1, Color="blue");
    end
end

graphics_leader(end) = scatter(leader_q_x(1, end), leader_q_y(1, end),  'O', 'filled', 'green', 'DisplayName', sprintf("leader"));

for i = 1:N
    graphics_agents(i) = scatter(q_x(i, end), q_y(i, end),  '>', 'black', 'filled', 'DisplayName', sprintf("veh_%d", i));
end

animationPauseTime = 0.01;
xlabel('x');
ylabel('y');
ylim([0,100]);
xlim([0,100]);
title('Animating Agent Movements');
% legend('show');
grid on;
hold off;

% tInit = 0;
timeStep = 0.01;
tFinal = 12;
for tInit=0:timeStep:tFinal
    neighborsAgentsSet = formNeighborhoodAgentsSets(q_x, q_y, r);
    neighborsObstaclesSet = formNeighborhoodObstaclesSets(q_x, q_y, rPrime, obs, Rk);
    for i=1:N
        qi = [q_x(i,end); q_y(i,end)];
        pi = [p_x(i,end); p_y(i,end)];
        qr = [leader_q_x(1,end); leader_q_y(1,end)];
        pr = [leader_p_x(1,end); leader_p_y(1,end)];
    
        phia_nij = 0;
        phib_nij = 0;
        u_i_a_term01 = 0;
        u_i_a_term02 = 0;
        u_i_b_term01 = 0;
        u_i_b_term02 = 0;
    
        ui_y = -c1_gamma.*(qi-qr) - c2_gamma.*(pi-pr);

        
        for j=1:N
    
            if neighborsAgentsSet(i, j) == 1
                % u_i_a -----------------------------------------
                qj = [q_x(j,end); q_y(j,end)];
                pj = [p_x(j,end); p_y(j,end)];
    
                z = qj - qi;
                z = sigma_normF(z, epsilon);
                phia = phi_alphaF(z, r, d, h_a, h_b, a, b);
                nij = nijF(qi, qj, epsilon);
                phia_nij = phia_nij + phia*nij;
    
                adjacent = formAdjacency(qi, qj, r, h_a, epsilon);
                
                u_i_a_term01 = u_i_a_term01 + phia_nij;
                u_i_a_term02 = u_i_a_term02 + adjacent*(pj-pi);
                
                % -----------------------------------------------
            end
        end
        ui_a = u_i_a_term01.*c1_alpha + u_i_a_term02.*c2_alpha;
        
        for j=1:size(obs, 2)
            if neighborsObstaclesSet(i, j) == 1
                % u_i_b -----------------------------------------
                qhat = projectAgent(qi, obs(:,j), Rk(j));
                z = qhat - qi;
                z = sigma_normF(z, epsilon);
                phi_beta = phi_betaF(z, rPrime, dPrime, h_b, a, b);
    
                nij_hat = nijF(qi, qhat, epsilon);
    
                phib_nij = phib_nij + phi_beta*nij_hat;
    
                adjacent = formAdjacency(qi, qhat, dPrime, h_b, epsilon);
    
                phat = projectAgent_p(qi, pi, obs(:,j), Rk(j));
                
                u_i_b_term01 = u_i_b_term01 + phib_nij;
                u_i_b_term02 = u_i_b_term02 + adjacent*(phat-pi);
    
                % -----------------------------------------------
            end
        end
        ui_b = u_i_b_term01.*c1_beta + u_i_b_term02.*c2_beta;
    
        ui = ui_a + ui_b + ui_y;
        
        if i == 1
            ux(i,end+1) = ui(1);
            uy(i,end+1) = ui(2);
        else
            ux(i,end) = ui(1);
            uy(i,end) = ui(2);
        end
        
    end

    q_dot_x(:, end+1) = p_x(:,end);
    q_dot_y(:, end+1) = p_y(:,end);
    
    p_dot_x(:, end+1) = ux(:, end);
    p_dot_y(:, end+1) = uy(:, end);
    
    q_x(:, end+1) = q_x(:, end) + q_dot_x(:, end)*timeStep;
    q_y(:, end+1) = q_y(:, end) + q_dot_y(:, end)*timeStep;

    p_x(:, end+1) = p_x(:, end) + p_dot_x(:, end)*timeStep;
    p_y(:, end+1) = p_y(:, end) + p_dot_y(:, end)*timeStep;
    
    leader_q_x_dot(:, end+1) = leader_p_x(:,end);
    leader_q_y_dot(:, end+1) = leader_p_y(:,end);
    
    leader_p_x_dot(:, end+1) = leader_q_x(:,end)*0;
    leader_p_y_dot(:, end+1) = leader_q_x(:,end)*0;

    leader_q_x(:, end+1) = leader_q_x(:, end) + leader_q_x_dot(:, end)*timeStep;
    leader_q_y(:, end+1) = leader_q_y(:, end) + leader_q_y_dot(:, end)*timeStep;
    
    leader_p_x(:, end+1) = leader_p_x(:, end) + leader_p_x_dot(:, end)*timeStep;
    leader_p_y(:, end+1) = leader_p_y(:, end) + leader_p_y_dot(:, end)*timeStep;
    

%     cla;
%     hold on;
    for i = 1:N
        set(graphics_agents(i), 'XData', q_x(i, end), 'YData', q_y(i, end));
%         scatter(q_x(i, end), q_y(i, end), 'm>', 'red', 'DisplayName', sprintf("veh_%d", i));
    end

    for i = 1:N
        for j=1:N
            if neighborsAgentsSet(i,j) == 1
                temp_x = neighborsAgentsSet.*q_x(:,end);
                temp_y = neighborsAgentsSet.*q_y(:,end);
                set(graphics_edges(i,j), 'XData', [temp_x(i,j), temp_x(j,i)], 'YData', [temp_y(i,j), temp_y(j,i)]);
%                 plot([q_x(i,end), q_x(j,end)], [q_y(i,end), q_y(j,end)], LineWidth=1.5, Color="blue")
            else
                set(graphics_edges(i,j), 'XData', [0, 0], 'YData', [0, 0]);
            end

        end
    end

    set(graphics_leader(1), 'XData', leader_q_x(1, end), 'YData', leader_q_y(1, end));
    drawnow;
    pause(animationPauseTime)
end
