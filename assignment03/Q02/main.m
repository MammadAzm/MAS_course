clc; clear; close all;

run("CONSTANTS.m");

graphics_edges = gobjects(N,N);
graphics_agents = gobjects(N,1);

graphic_velocity_x = gobjects(N,1);
graphic_velocity_y = gobjects(N,1);
graphic_velocity_z = gobjects(N,1);

figure('units','normalized','outerposition',[0 0 1 1]);
hold on

subplot(3, 2, [1 3 5])
title('Animating Agent Movements');
grid on;
hold on;
view(3);
xlabel('x');
ylabel('y');
zlabel('z');

for i = 1:N
    for j=1:N
        graphics_edges(i,j) = plot3([0, 0], [0, 0], [0, 0], LineWidth=1, Color="blue");
    end
end

for i = 1:N
    graphics_agents(i) = scatter3(q_x(i, end), q_y(i, end), q_z(i, end),  '>', 'black', 'filled');
end



subplot(3, 2, 2)
hold on
xlabel('t');
ylabel('V_x');
grid on
for i = 1:N
    graphic_velocity_x(i) = plot(0, 0);
end

subplot(3, 2, 4)
hold on
xlabel('t');
ylabel('V_y');
for i = 1:N
    graphic_velocity_y(i) = plot(0, 0);
end

subplot(3, 2, 6)
hold on
xlabel('t');
ylabel('V_z');
for i = 1:N
    graphic_velocity_z(i) = plot(0, 0);
end

animationPauseTime = 0.0;

for t=tInit:timeStep:tFinal
    neighborsAgentsSet = formNeighborhoodAgentsSets(q_x, q_y, q_z, r);
    for i=1:N
        qi = [q_x(i,end); q_y(i,end); q_z(i,end)];
        pi = [p_x(i,end); p_y(i,end); p_z(i,end)];

        phia_nij = 0;
        u_i_a_term01 = 0;
        u_i_a_term02 = 0;
       
        for j=1:N
            if neighborsAgentsSet(i, j) == 1
                % u_i_a -----------------------------------------
                qj = [q_x(j,end); q_y(j,end);  q_z(j,end)];
                pj = [p_x(j,end); p_y(j,end);  p_z(j,end)];

                z = qj - qi;
                z = sigma_normF(z, epsilon);
                phia = phi_alphaF(z, r, d, h_a, a, b);
                nij = nijF(qi, qj, epsilon);
                phia_nij = phia_nij + phia*nij;
                
                adjacent = formAdjacency(qi, qj, r, h_a, epsilon);
                
                diagonal_elements = 1*[1, 1, 1];
                Kv = diag(diagonal_elements);
                
                u_i_a_term01 = u_i_a_term01 + phia_nij;
%                 u_i_a_term02 = u_i_a_term02 + adjacent*tanh(Kv*(pj-pi));
                u_i_a_term02 = u_i_a_term02 + adjacent*(pj-pi);
                
                % -----------------------------------------------
            end
        end
        ui_a = -u_i_a_term01*c1_alpha + u_i_a_term02*c2_alpha;
        if ui_a == 0
            ui_a = [0; 0; 0];
        end
        ui = ui_a;
        
        if i == 1
            ux(i,end+1) = ui(1);
            uy(i,end+1) = ui(2);
            uz(i,end+1) = ui(3);
        else
            ux(i,end) = ui(1);
            uy(i,end) = ui(2);
            uz(i,end) = ui(3);
        end
    end

    q_dot_x(:, end+1) = p_x(:,end);
    q_dot_y(:, end+1) = p_y(:,end);
    q_dot_z(:, end+1) = p_z(:,end);
    
    p_dot_x(:, end+1) = ux(:, end);
    p_dot_y(:, end+1) = uy(:, end);
    p_dot_z(:, end+1) = uz(:, end);
    
    q_x(:, end+1) = q_x(:, end) + q_dot_x(:, end)*timeStep;
    q_y(:, end+1) = q_y(:, end) + q_dot_y(:, end)*timeStep;
    q_z(:, end+1) = q_z(:, end) + q_dot_z(:, end)*timeStep;

    p_x(:, end+1) = p_x(:, end) + p_dot_x(:, end)*timeStep;
    p_y(:, end+1) = p_y(:, end) + p_dot_y(:, end)*timeStep;
    p_z(:, end+1) = p_z(:, end) + p_dot_z(:, end)*timeStep;

%     cla;
%     hold on;
    for i = 1:N
        set(graphics_agents(i), 'XData', q_x(i, end), 'YData', q_y(i, end), "ZData", q_z(i, end));
%         scatter(q_x(i, end), q_y(i, end), 'm>', 'red', 'DisplayName', sprintf("veh_%d", i));
    end

    for i = 1:N
        for j=1:N
            if neighborsAgentsSet(i,j) == 1
                temp_x = neighborsAgentsSet.*q_x(:,end);
                temp_y = neighborsAgentsSet.*q_y(:,end);
                temp_z = neighborsAgentsSet.*q_z(:,end);
                set(graphics_edges(i,j), 'XData', [temp_x(i,j), temp_x(j,i)], 'YData', [temp_y(i,j), temp_y(j,i)], 'ZData', [temp_z(i,j), temp_z(j,i)]);
%                 plot([q_x(i,end), q_x(j,end)], [q_y(i,end), q_y(j,end)], LineWidth=1.5, Color="blue")
            else
                set(graphics_edges(i,j), 'XData', [0, 0], 'YData', [0, 0], 'ZData', [0, 0]);
            end

        end
    end

    for i = 1:N
        set(graphic_velocity_x(i), 'XData', tInit:timeStep:t+timeStep, 'YData', p_x(i, :));
        set(graphic_velocity_y(i), 'XData', tInit:timeStep:t+timeStep, 'YData', p_y(i, :));
        set(graphic_velocity_z(i), 'XData', tInit:timeStep:t+timeStep, 'YData', p_z(i, :));
    end

    drawnow;
    pause(animationPauseTime)
end
