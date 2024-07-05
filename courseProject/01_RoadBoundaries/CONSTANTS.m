rng(45);

tInit = 0;
timeStep = 0.01;
tFinal = 12;


% MAS vars
N = 30;  % Agents Nums

% Setting the Initial Conditions for Leaders
leader_q_x = [15];
leader_q_y = [0];

leader_p_x = [9];
leader_p_y = [0];

leader_q_x_dot = [];
leader_q_y_dot = [];

leader_p_x_dot = [];
leader_p_y_dot = [];

% Setting up the Obstacles
obstacle_1 = [35;30];
obstacle_2 = [35; 80];
obstacle_3 = [20;30];
obstacle_4 = [55;60];
obs = [obstacle_1, obstacle_2, obstacle_3, obstacle_4];
obs = [];
Rk1 = 5;
Rk2 = 8;
Rk3 = 5;
Rk4 = 4;
Rk = [Rk1;Rk2;Rk3;Rk4];

roadLeftLimit = 25;
roadRightLimit = -25;
roadWidth = roadLeftLimit - roadRightLimit;
roadLeftBoundary = [0; roadLeftLimit];
roadRightBoundary = [0; roadRightLimit];
bounds = [roadRightBoundary, roadLeftBoundary];

% Setting the Initial Conditions for Agents
q_dot_x = [];
q_dot_y = [];

p_dot_x = [];
p_dot_y = [];

q_x = [];
q_y = [];

p_x = [];
p_y = [];

q_x = [q_x, rand(N, 1)*(-50)];
q_y = [q_y, rand(N, 1)*roadWidth - 25];

p_x = [p_x, zeros(N, 1)];
p_y = [p_y, zeros(N, 1)];

ux = [];
uy = [];

 
% params-------------------------
d = 7;
r = 1.2*d;
dPrime = 0.8*d;
rPrime = 1.2*dPrime;
dZegond = 0.5*d;
rZegond = 1.2*dZegond;
epsilon = 0.1;
a = 5;
b = 5;
h_a = 0.2;
h_b = 0.9;

c1_alpha = 50;
c1_gamma = [5; 2];
c1_beta = 50;
c1_boundary = 150;

c2_alpha = 2*sqrt(c1_alpha);
c2_gamma = 2*sqrt(c1_gamma);
c2_beta = 2*sqrt(c1_beta);
c2_boundary = 2*sqrt(c1_boundary);