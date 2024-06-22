rng(5);

tInit = 0;
timeStep = 0.01;
tFinal = 25;

% MAS vars
NumFollowers= 10;
NumLeaders= 1;

% Setting the Initial Conditions for Agents
x_dot = [];
xl_dot = [];

x = [];
xl = [];

x = [x, rand(N, 1)*0];

u = [];

% params-------------------------
d = 5;
r = 1.2*d;
epsilon = 0.1;
a = 5;
b = 5;
h_a = 0.9;

bowlCapacity = 10;

leaderGain = 1;
neighborGain = 2;

bowl = zeros(N,1);
events = zeros(N,1);
