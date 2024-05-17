clc; clear
%% 
A = [0, 0, 0, 1, 0, 0; 0, 0, 0, 0, 1, 0; 0, 0, 0, 0 ,0 ,1;
     0, 0, -0.2003, -0.2003, 0, 0; 0, 0, 0.2003, 0, -0.2003, 0;
     0, 0, 0, 0, 0, -1.6129;];

B = [0, 0; 0, 0; 0, 0; 0.9441, 0.9441; 0.9441, 0.9441; -28.7097, 28.7097;];
%% 

% cvx_begin
%     variable P(6,6) symmetric
%     A*P + P*A' - 2*B*B' <= 0
% cvx_end

% eig(P)
%% 
rng(42)
F = place(A,B,-5*rand(6,1));
% F = -B'*inv(P)
%% 

NumFollowers = 6;
NumLeaders = 3;
NumAgents = NumLeaders + NumFollowers;
NumStates = 6;

L_Followers = [3, 0, 0, -1, -1, -1; -1, 1, 0, 0, 0, 0;
               -1, -1, 2, 0, 0, 0; -1, 0, 0, 1, 0, 0;
               0, 0, 0, -1, 1, 0; -1, 0, 0, 0, 0, 1;];
eigs_L = eig(L_Followers);

L_total =    [3, 0, 0, -1, -1, -1, 0, 0, 0;
       -1, 1, 0, 0, 0, 0, 0, 0, 0;
       -1, -1, 2, 0, 0, 0, 0, 0, 0;
       -1, 0, 0, 2, 0, 0, 0, 0, -1;
        0, 0, 0, -1, 2, 0, 0, -1, 0;
        -1, 0, 0, 0, 0, 2, -1, 0, 0;
        0, 0, 0, 0, 0, 0, 0, 0, 0;
        0, 0, 0, 0, 0, 0, 0, 0, 0;
        0, 0, 0, 0, 0, 0, 0, 0, 0;];

L = L_total;
% L = L_Followers;
%%

% L = L_total;
% D = [3 0 0 0 0 0 0 0 0;
%      0 1 0 0 0 0 0 0 0;
%      0 0 2 0 0 0 0 0 0;
%      0 0 0 2 0 0 0 0 0;
%      0 0 0 0 2 0 0 0 0;
%      0 0 0 0 0 2 0 0 0;
%      0 0 0 0 0 0 0 0 0;
%      0 0 0 0 0 0 0 0 0;
%      0 0 0 0 0 0 0 0 0;];
% A = D - L;     
%% 

indx = find(round(eigs_L, 4) > 0);
lambda_min = min(real(eigs_L(indx)))

c_th = 1/lambda_min;

c = c_th*1.25;

%% 

states = repmat(struct("x_dot", [], "x", []), NumFollowers, 1);
for agent=1:NumFollowers
    agents(agent).x = rand(6,1)*10;
    agents(agent).x_dot = zeros(6,1);
end

agents(7).x = -1*[1,1,1,1,1,1]';
agents(8).x = 3*[1,1,1,1,1,1]';
agents(9).x = 7*[1,1,1,1,1,1]';

agents(7).x = rand(6,1)*2;
agents(8).x = rand(6,1)*10;
agents(9).x = rand(6,1)*-10;

agents(7).x_dot = [0,0,0,0,0,0]';
agents(8).x_dot = [0,0,0,0,0,0]';
agents(9).x_dot = [0,0,0,0,0,0]';

%% 

allStates = [];
allStates_dot = [];
for agent=1:NumAgents
    allStates = [allStates; agents(agent).x];
    allStates_dot = [allStates_dot; agents(agent).x_dot];
end

tFinal = 25;
timeStep = 0.01;
for t=0:timeStep:tFinal   
    allStates_dot(:, end+1) = (kron(eye(NumAgents), A) - (c*kron(L, B*F)))*allStates(:, end);
    allStates(:, end+1) = allStates(:, end) + allStates_dot(:, end)*timeStep;
end
%% 

div = size(allStates, 1)/NumAgents;
for agent=1:NumFollowers
    agents(agent).x = allStates((agent-1)*div+1:1:agent*div, :);
    agents(agent).x_dot = allStates_dot((agent-1)*div+1:1:agent*div, :);
end

for agent=NumFollowers+1:NumAgents
    agents(agent).x = repmat(agents(agent).x, 1, size(agents(1).x,2));
    agents(agent).x_dot = allStates_dot((agent-1)*div+1:1:agent*div, :);
end

%% 

% figure
for state=1:NumStates
    figure
%     subplot(3,2,state)
    hold on
    for agent=NumFollowers+1:NumAgents
        plot(0:timeStep:tFinal+0.01, agents(agent).x(state, :), DisplayName=sprintf("Leader-%d", agent-NumFollowers), LineWidth=2.5)
    end
    
    for agent=1:NumFollowers
        plot(0:timeStep:tFinal+0.01, agents(agent).x(state, :), DisplayName=sprintf("Follower-%d", agent), LineWidth=1)
    end
    title(sprintf("State %d Response", state))
    xlabel("time")
    ylabel("state value")
    legend
end
