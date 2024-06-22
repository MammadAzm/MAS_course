clc; clear; close all;

run("CONSTANTS.m");

graphics_edges = gobjects(N,N);
graphics_agents = gobjects(N,1);

graphic_velocity_x = gobjects(N,1);
graphic_velocity_y = gobjects(N,1);
graphic_velocity_z = gobjects(N,1);

figure;
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
    graphics_agents(i) = scatter3(x(i, end), q_y(i, end), q_z(i, end),  '>', 'black', 'filled');
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
    neighborsAgentsSet = formNeighborhoodAgentsSets(x, q_y, q_z, r)
    for i=1:N
        xi = [x(i,end)];

        for j=1:N
            if neighborsAgentsSet(i, j) == 1
                xj = [x(j,end)];
                bowl(i,1) = bowl(i,1) + (xj - xi);
            end
        end
    end
    
    idx = find(bolw < bowlCapacity);
    nidx = find(bolw >= bowlCapacity);
    events(idx, end+1) = 0;
    events(nidx, end) = 1;

    bowl(idx) = 0;
    u = bowl;
    x(:, end+1) = x(:, end) + leaderGain*(xl(:, end) - x(:, end)) + neighborGain*u;

    xl_dot(:, end+1) = leaderGain*
    
    for i = 1:N
        set(graphics_agents(i), 'XData', x(i, end), 'YData', q_y(i, end), "ZData", q_z(i, end));
%         scatter(x(i, end), q_y(i, end), 'm>', 'red', 'DisplayName', sprintf("veh_%d", i));
    end

    for i = 1:N
        for j=1:N
            if neighborsAgentsSet(i,j) == 1
                temp_x = neighborsAgentsSet.*x(:,end);
                temp_y = neighborsAgentsSet.*q_y(:,end);
                temp_z = neighborsAgentsSet.*q_z(:,end);
                set(graphics_edges(i,j), 'XData', [temp_x(i,j), temp_x(j,i)], 'YData', [temp_y(i,j), temp_y(j,i)], 'ZData', [temp_z(i,j), temp_z(j,i)]);
%                 plot([x(i,end), x(j,end)], [q_y(i,end), q_y(j,end)], LineWidth=1.5, Color="blue")
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
