clear all;
close all;
clc;

%% INFO

% ---- Link lengths ----
l1 = 1; 
l2 = 1; 
l3 = 1;      % 
theta1 = deg2rad(20);
theta2 = deg2rad(25);
d3 = 0.2;

% ---- HT Matrices ----
T01 = [cos(theta1) -sin(theta1) 0 0;
       sin(theta1)  cos(theta1) 0 0;
       0            0           1 l1;
       0            0           0 1];

T12 = [cos(theta2) -sin(theta2) 0 0;
       sin(theta2)  cos(theta2) 0 l2;
       0            0           1 0;
       0            0           0 1];

T23 = [1 0 0 0;
       0 1 0 l3;
       0 0 1 -d3;
       0 0 0 1];

%%
T03 = T01 * T12 * T23;

%%
% ---- Extract position and rotation ----
R = T03(1:3,1:3);
p = T03(1:3,4);

disp('T0_3 ='); disp(T03);
disp('Rotation R ='); disp(R);
disp('Position p ='); disp(p);