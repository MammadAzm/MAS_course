rng(45);

tInit = 0;
timeStep = 0.01;
tFinal = 12;


% MAS vars
N = 25;  % Agents Nums

% Setting the Initial Conditions for Leaders
leader_q_x = [50];
leader_q_y = [-15];

leader_p_x = [10];
leader_p_y = [0];

leader_q_x_dot = [];
leader_q_y_dot = [];

leader_p_x_dot = [];
leader_p_y_dot = [];

% Setting up the Obstacles
obstacle_1 = [36;0];
obstacle_2 = [38;0];
obstacle_3 = [40;0];
obstacle_4 = [42;0];
obstacle_5 = [44;0];
obstacle_6 = [46;0];
obstacle_7 = [48;0];
obstacle_8 = [50;0];
% obs = [obstacle_1, obstacle_2, obstacle_3, obstacle_4, obstacle_5, obstacle_6, obstacle_7];
obs = [obstacle_1];
Rk1 = 5;
Rk2 = 5;
Rk3 = 5;
Rk4 = 5;
Rk = [Rk1;Rk2;Rk3;Rk4;Rk4;Rk4;Rk4;Rk4];

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
dPrime = 20;
rPrime = 1.2*dPrime;
dZegond = 0.5*d;
rZegond = 1.2*dZegond;
epsilon = 0.1;
a = 5;
b = 5;
h_a = 0.2;
h_b = 0.9;

c1_alpha = 50;
c1_gamma = [5; 1];
c1_beta = 100;
c1_boundary = 100;

c2_alpha = 2*sqrt(c1_alpha);
c2_gamma = 2*sqrt(c1_gamma);
c2_beta = 2*sqrt(c1_beta);
c2_boundary = 2*sqrt(c1_boundary);