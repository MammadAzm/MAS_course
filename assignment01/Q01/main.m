clear; clc;

%%

N = 6;
n = 1;

%% Topology 01 | Left Side Graph

fprintf("==== Study on Topology 1 ===============================================\n")

A_01 = [ 0  0  0  0  0  0;
        +1  0  0  0  0  0;
         0 +1  0  0  0  0;
         0  0 +1  0  0  0;
         0  0 +1 +1  0  0;
         0  0  0  0 +1  0;
        ];

D_01 = diag([0 1 1 1 2 1]);

L_01 = [ 0  0  0  0  0  0;
        -1 +1  0  0  0  0;
         0 -1 +1  0  0  0;
         0  0 -1 +1  0  0;
         0  0 -1 -1 +2  0;
         0  0  0  0 -1 +1;
       ];

sorted_L_eigs_01 = sort(eig(L_01)');

if L_01 == D_01-A_01
    fprintf(">>>> Equation L=D-A is satisfied. So all three A, D and L matrices are formed correctly.\n")
end

if L_01*ones(N,1) == 0
    fprintf(">>>> Equation L1=0 is satisfied.\n")
end

if ones(N,1)'*L_01 == 0
    fprintf(">>>> Equation 1TL=0 is satisfied. So the given graph is balanced.\n")
else
    fprintf(">>>> Equation 1TL=0 is NOT satisfied. So the given graph is not balanced.\n")
end

if length(find(eig(L_01) == 0)) >= 1
    fprintf(">>>> The Laplacian matrix has at least one zero eigenvalue.\n")
    if length(find(eig(L_01) == 0)) == 1
        fprintf("    |")
        fprintf(">>>> The Laplacian matrix has exactly one zero eigenvalue.\n")
    end
else
    fprintf(">>>> No Zero eigenvalue found in Laplacian matrix.\n")
end

if rank(L_01) == N-1
    fprintf(">>>> rank(L) == N-1 ; So G has a spanning tree.\n")
end

if sorted_L_eigs_01(2) ~= 0
    fprintf(">>>> The secons lowest eigenvalue of L is not 0; therefore, G is weakly connected.\n")
end


figure
G_01 = digraph(A_01');
plot(G_01);

initial_condition_01 = [10, 1, 2, 3, 4, 5]';


fprintf("========================================================================\n")

%% Topology 02 | Right Side Graph

fprintf("==== Study on Topology 2 ===============================================\n")

A_02 = [  0  0  0  0  0 +1;
         +1  0  0  0  0  0;
          0 +1  0  0  0  0;
          0  0 +1  0  0  0;
          0  0  0 +1  0  0;
          0  0  0  0 +1  0;
       ];

D_02 = diag([1 1 1 1 1 1]);

L_02 = [ +1  0  0  0  0 -1;
         -1 +1  0  0  0  0;
          0 -1 +1  0  0  0;
          0  0 -1 +1  0  0;
          0  0  0 -1 +1  0;
          0  0  0  0 -1 +1;
       ];

sorted_L_eigs_02 = sort(eig(L_02)');

if L_02 == D_02-A_02
    fprintf(">>>> Equation L=D-A is satisfied. So all three A, D and L matrices are formed correctly.\n")
end

if L_02*ones(N,1) == 0
    fprintf(">>>> Equation L1=0 is satisfied.\n")
end

if ones(N,1)'*L_02 == 0
    fprintf(">>>> Equation 1TL=0 is satisfied. So the given graph is balanced.\n")
else
    fprintf(">>>> Equation 1TL=0 is NOT satisfied. So the given graph is not balanced.\n")
end

if length(find(round(eig(L_02), 3) == 0)) >= 1
    fprintf(">>>> The Laplacian matrix has at least one zero eigenvalue.\n")
    if length(find(eig(L_02) == 0)) == 1
        fprintf("    |")
        fprintf(">>>> The Laplacian matrix has exactly one zero eigenvalue.\n")
    end
else
    fprintf(">>>> No Zero eigenvalue found in Laplacian matrix.\n")
end

if rank(L_02) == N-1
    fprintf(">>>> rank(L) == N-1 ; So G has a spanning tree.\n")
end

if sorted_L_eigs_02(2) ~= 0
    fprintf(">>>> The secons lowest eigenvalue of L is not 0; therefore, G is weakly connected.\n")
end

figure
G_02 = digraph(A_02');
plot(G_02);

initial_condition_02 = [10, 1, 2, 3, 4, 5]';

fprintf("========================================================================\n")
