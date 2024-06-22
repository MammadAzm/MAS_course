% clc; clear; close all;

run("CONSTANTS.m");

graphics_agents = gobjects(N,1);

figure;
hold on

title('Animating Agent Movements');
subplot(3,1,1)
grid on;
hold on;
xlabel('t');
ylabel('x');

for i = 1:N
    graphics_agents(i) = plot(0, 0, 'blue');
end

subplot(3,1,2)
graphic_event = plot(0, 0, 'red');
grid on;
hold on;
xlabel('t');
ylabel('event');


subplot(3,1,3)
hold on
graphic_error = plot(0, 0, 'blue');
graphic_th = plot(0, 0, 'red');
grid on;
hold on;
xlabel('t');
ylabel('error');

animationPauseTime = 0.01;

for t=tInit:timeStep:tFinal
    L = formNeighborhoodAgentsSets(x, r);
    for i=1:N
        L(i,i) = -1*sum(L(i, :));
    end

    for i=1:N
        xi = [x(i,end)];
        for j=1:N
            if L(i, j) == 1
                xj = [x(j,end)];
            end
        end
    end
    error = euclidean_dist(x(:, end) - xe(:, end));
    errors = [errors, error];

    th = sigma*(euclidean_dist(L*xe(:, end)))/(sqrt(max(eig(L'*L))));
    ths = [ths, th];
    if th < error
        events(end+1) = 1;
        u(:, end+1) = -L*x(:, end);
        x_dot(:, end+1) = u(:, end);
        x(:, end+1) = x(:, end) + x_dot(:, end)*timeStep;
        xe(:, end+1) = x(:, end);
    else
        events(end+1) = 0;
        u(:, end+1) = u(:, end);
        x_dot(:, end+1) = u(:, end);
        x(:, end+1) = x(:, end) + x_dot(:, end)*timeStep;
    end

    for i = 1:N
        set(graphics_agents(i), 'XData', tInit:timeStep:t+timeStep , 'YData', x(i, :));
    end
    set(graphic_event, "XData", tInit:timeStep:t, "YData", events);
    set(graphic_error, "XData", tInit:timeStep:t, "YData", ths);
    set(graphic_th, "XData", tInit:timeStep:t, "YData", errors);

    drawnow;
    pause(animationPauseTime)
end
