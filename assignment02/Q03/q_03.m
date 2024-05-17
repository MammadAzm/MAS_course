clc; close; clear;
%% 

% Define initial values to use in the code:
numFollowers = 6;
numLeaders = 4;
numAgents = numFollowers + numLeaders

% Based on the given topologies, the Laplacian matrices of L1 and L2 are as follows:
L1 = [2 0 0 0 -1 0 -1 0 0 0;
      0 1 -1 0 0 0 0 0 0 0;
      0 0 1 0 0 0 0 -1 0 0;
      0 0 0 1 0 0 0 0 -1 0;
      0 0 0 -1 1 0 0 0 0 0;
      0 0 0 -1 0 2 0 0 0 -1;
      0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 0;]
L2 = [0 0 0 0 0 0 0 0 0 0;
      0 1 -1 0 0 0 0 0 0 0;
      0 -1 1 0 0 0 0 0 0 0;
      0 0 0 1 -1 0 0 0 0 0;
      0 0 0 0 1 -1 0 0 0 0;
      0 0 0 -1 0 1 0 0 0 0;
      0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 0;
      0 0 0 0 0 0 0 0 0 0;]
%% 

% Now lets set the seed value to avoid different random calues for each code run:
rng(2)

% The timespan that the multi-agent system is going to be simulated:
tFinal = 80;

% with the time step of:
timeStep = 0.1;
%% 

% and the initial conditions for both leaders and followers as in:

%% 

% Case I) Leaders at [L1, L2, L3, L4] = [10;22;15;17]  ||| zero i.c. for followers
x = [zeros(numFollowers,1)*5 ; 10;22;15;17];
x_dot = zeros(numAgents, 1);
%% 

% The system dynamics throughout the timespan will be:
L = L1;
for t=timeStep:timeStep:tFinal
    if t/floor(t) == 1
        if L == L1
            L = L2;
        elseif L == L2
            L = L1;
        end
    end
    x_dot(:, end+1) = -L*x(:, end);
    x(:, end+1) = x(:, end) + x_dot(:, end)*timeStep;
end

% and cnsequently, the results are as follows:
figure
for agent=numFollowers+1:numAgents
    plot(0:timeStep:tFinal, x(agent, :), LineWidth=3, DisplayName=sprintf('Leader-%d', agent-numFollowers))
    hold on
end


for agent=1:numFollowers
    plot(0:timeStep:tFinal, x(agent, :), LineWidth=1.25, DisplayName=sprintf('Follower-%d', agent))
end

legend
title("Case I ) Leaders at [L1, L2, L3, L4] = [10;22;15;17]  ||| zero i.c. for followers")
xlabel("Time")
ylabel("Agents State")
% Thicker lines are the leader states which are constant by the wau since their control signal are always zero, hence their state never changes. As expected, the follower agents have converged in to the convex hull of the four leaders i.e. all the follower lines are within the leader line boundaries.

%% 

% Case II) Leaders at [L1, L2, L3, L4] = [10;22;15;17]  ||| random i.c. for followers
x = [rand(numFollowers,1)*25 ; 10;22;15;17];
x_dot = zeros(numAgents, 1);
%% 

% The system dynamics throughout the timespan will be:
L = L1;
for t=timeStep:timeStep:tFinal
    if t/floor(t) == 1
        if L == L1
            L = L2;
        elseif L == L2
            L = L1;
        end
    end
    x_dot(:, end+1) = -L*x(:, end);
    x(:, end+1) = x(:, end) + x_dot(:, end)*timeStep;
end

% and cnsequently, the results are as follows:
figure
for agent=numFollowers+1:numAgents
    plot(0:timeStep:tFinal, x(agent, :), LineWidth=3, DisplayName=sprintf('Leader-%d', agent-numFollowers))
    hold on
end


for agent=1:numFollowers
    plot(0:timeStep:tFinal, x(agent, :), LineWidth=1.25, DisplayName=sprintf('Follower-%d', agent))
end

legend
title("Case II ) Leaders at [L1, L2, L3, L4] = [10;22;15;17]  ||| random i.c. for followers")
xlabel("Time")
ylabel("Agents State")
