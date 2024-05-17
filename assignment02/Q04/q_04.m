clc; close; clear;
%% 

% Define initial values to use in the code:
numFollowers = 6;
numLeaders = 2;
numAgents = numFollowers + numLeaders;

% Based on the given topologies, the Laplacian matrices of L1 and L2 are as follows:
L = [ 3 -1  0 -1  0  0 -1  0;
     -1  2 -1  0  0  0  0  0;
      0 -1  3  0  0 -1  0 -1;
     -1  0  0  2 -1  0  0  0;
      0  0  0 -1  2 -1  0  0;
      0  0 -1  0 -1  2  0  0;
      0  0  0  0  0  0  0  0;
      0  0  0  0  0  0  0  0];

L1 = [ 2 -1  0 -1  0  0;
      -1  2 -1  0  0  0;
       0 -1  2  0  0 -1;
      -1  0  0  2 -1  0;
       0  0  0 -1  2 -1;
       0  0 -1  0 -1  2];

%% 

% Now lets set the seed value to avoid different random calues for each code run:
rng(2)

% The timespan that the multi-agent system is going to be simulated:
tFinal = 35;

% with the time step of:
timeStep = 0.01;

rho1 = 1;
rho2 = 1;
r1 = floor(rho1) + 1;
r2 = floor(rho2) + 1;

eigsL = round(eig(L1), 3);
minL = min(eigsL(find(eigsL ~= 0)));
alphaMin = (2*r2^2 + r1)/(r2^2*minL);
alpha = alphaMin*0.08; 
% alpha = 22.5;  % maximum possible value before divergence

rng(42);
x_dot = zeros(numAgents, 1);
x = [rand(numAgents, 1)*10];

v_dot = zeros(numAgents, 1);
v = zeros(numAgents, 1)*10;

f = [zeros(numAgents,1)];
u = [zeros(numAgents,1)];

for t=timeStep:timeStep:tFinal
    f(:, end+1) = (x(:, end)*cos(t)) + (v(:, end)*sin(t));
    u(:,end+1) = -alpha*(r1*L*x(:, end) + r2*L*v(:, end));
    
    x_dot(:, end+1) = v(:, end);
    x(:,end+1) = x(:,end) + x_dot(:, end)*timeStep;

    v_dot(:, end+1) = f(:, end) + u(:,end);
    v(:, end+1) = v(:, end) + v_dot(:, end)*timeStep;    
end

figure
hold on

for agent=numFollowers+1:numAgents
    plot(timeStep:timeStep:tFinal+timeStep, x(agent, :), DisplayName=sprintf("Leader-%d", agent-numFollowers), LineWidth=2.5)
end

for agent=1:numFollowers
    plot(timeStep:timeStep:tFinal+timeStep, x(agent, :), DisplayName=sprintf("Follower-%d", agent), LineWidth=1)
end

title("x_i(t) - Position")
xlabel("time")
ylabel("position value")
legend


figure
hold on

for agent=numFollowers+1:numAgents
    plot(timeStep:timeStep:tFinal+timeStep, v(agent, :), DisplayName=sprintf("Leader-%d", agent-numFollowers), LineWidth=2.5)
end

for agent=1:numFollowers
    plot(timeStep:timeStep:tFinal+timeStep, v(agent, :), DisplayName=sprintf("Follower-%d", agent), LineWidth=1)
end

title("v_i(t) - Velocity")
xlabel("time")
ylabel("velocity value")
legend
