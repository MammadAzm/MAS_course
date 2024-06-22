rng(5);

tInit = 0;
timeStep = 0.01;
tFinal = 25;

% MAS vars
N = 10;  % Agents Nums

% Setting the Initial Conditions for Agents
q_dot_x = [];
q_dot_y = [];
q_dot_z = [];

p_dot_x = [];
p_dot_y = [];
p_dot_z = [];

q_x = [];
q_y = [];
q_z = [];

p_x = [];
p_y = [];
p_z = [];

q_x = [q_x, rand(N, 1)*5];
q_y = [q_y, rand(N, 1)*5];
q_z = [q_z, rand(N, 1)*5];

p_x = [p_x, rand(N, 1)*2];
p_y = [p_y, rand(N, 1)*2];
p_z = [p_z, rand(N, 1)*2];

ux = [];
uy = [];
uz = [];

% params-------------------------
d = 3.3;
r = 4;
epsilon = 0.1;
a = 5;
b = 5;
h_a = 0.9;

c1_alpha = 0.25;
c2_alpha = 10;
