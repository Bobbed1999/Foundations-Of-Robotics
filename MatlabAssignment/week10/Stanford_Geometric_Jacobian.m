close all;
clear all;
clc;

%%
mdl_stanford
q0 = [0 0 0.2 0 0 0];
stanf
figure;
stanf.teach(q0)

%%
syms q1 q2 d3 q4 q5 q6 real
FK = stanf.fkine([q1 q2 d3 q4 q5 q6])

Pe = FK.t

%% Jacobian
J = stanf.jacob0([q1 q2 d3 q4 q5 q6])
