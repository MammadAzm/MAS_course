rng(11);

tInit = 0;
timeStep = 0.01;
tFinal = 25;

% MAS vars
N= 4;

% Setting the Initial Conditions for Agents
x_dot = [];
x = [];
x = [x, rand(N, 1)*10];

xe = [x];

events = [];
errors = [];
ths = [];
u = [rand(N, 1)*4];

% params-------------------------
r = 5;
epsilon = 0.1;
% sigma = 2;
sigma = 1.5;
% sigma = 1;