close all;
clear all;
clc;

disp('RRR Planar Manipulator - Inverse Kinematics (IK) - Closed-form (Analytical) solutions')
syms L1 L2 L3;

%% Link lengths
L1 = 2;
L2 = 2;
L3 = 1;

%% DH Parameters [theta, d, a, alpha, offset]
j1 = RevoluteMDH();
j1.qlim = pi/180*[-90 90];

j2 = RevoluteMDH('a', L1);
j2.qlim = pi/180*[-90 90];

j3 = RevoluteMDH('a', L2);
j3.qlim = pi/180*[-90 90];

robot = SerialLink([j1 j2 j3], 'name', 'RRR-Planar')
robot.teach();

%% Transformations 

syms Transformation(alphai_1, ai_1, di, thi)

T1 = [cos(thi) -sin(thi) 0 ai_1];
T2 = [sin(thi)*cos(alphai_1) cos(thi)*cos(alphai_1) -sin(alphai_1) -sin(alphai_1)*di];
T3 = [sin(thi)*sin(alphai_1) cos(thi)*sin(alphai_1) cos(alphai_1) cos(alphai_1)*di];
T4 = [0 0 0 1];

Transformation(alphai_1, ai_1, di, thi) = [T1; T2; T3; T4];

syms th1 th2 th3 L1 L2

T_0_1 = Transformation(0, 0, 0, th1)
T_1_2 = Transformation(0, L1, 0, th2)
T_2_3 = Transformation(0, L2, 0, th3)

T_0_3 = T_0_1 * T_1_2 * T_2_3

%% Inverse Kinematics - Algebraic Solution

% Lecture 7 offers the equations for th1, th2 and th3 angles derivation
x = 1.986;
y = 3.117;
phi = deg2rad(80);
% x = 1.414; % additional point1
% y = 3.414;
% phi = deg2rad(90);
% x = 0.730; % additional point2
% y = 3.294;
% phi = deg2rad(110);
L1 = 2; L2 = 2; L3 = 0;

xw = x - L3*cos(phi);
yw = y - L3*sin(phi);

c2 = (xw^2 + yw^2 - L1^2 - L2^2) / (2*L1*L2);
s2 = sqrt(1 - c2^2); 

theta2 = atan2(s2, c2);

theta1 = atan2(yw, xw) - atan2(L2*s2, L1 + L2*c2);

% Solve for theta3
theta3 = phi - theta1 - theta2;

% Convert to degrees
theta1d = rad2deg(theta1)
theta2d = rad2deg(theta2)
theta3d = rad2deg(theta3)

%% Validate Algebraic Solution

% Given (x = 1.986, y 3.117) and phi = 80 degrees,
% validate the th1 ~= 35 degrees, th2 ~= 45 degrees 
% and th3 ~= 0 degrees.

% see above

%% Inverse Kinematics - Geometric Solution

% Lecture 7 offers the methods to derive th1, th2 and th3 angles
x = 1.986; y = 3.117; phi = deg2rad(80);
% x = 1.414; % additional point1
% y = 3.414;
% phi = deg2rad(90);
% x = 0.730; % additional point2
% y = 3.294;
% phi = deg2rad(110);
L1 = 2; L2 = 2; L3 = 0;

xw = x - L3*cos(phi);
yw = y - L3*sin(phi);
r2 = xw^2 + yw^2;

c2 = (r2 - L1^2 - L2^2)/(2*L1*L2);
s2 = sqrt(max(0,1 - c2^2)); 
s2b = -s2;  

theta2a = atan2(s2,  c2);
theta2b = atan2(s2b, c2);

% 2) β, ψ
r  = hypot(xw, yw);
beta = atan2(yw, xw);
psi  = acos( (r^2 + L1^2 - L2^2) / (2*L1*r) );

% 3) θ1（± 2 solutions）
theta1a = beta - psi;   % 1
theta1b = beta + psi;   % 2

% 4) θ3
theta3a = phi - theta1a - theta2a;
theta3b = phi - theta1b - theta2b;

solA = rad2deg([theta1a, theta2a, theta3a])  % ≈ [35, 45, 0]
solB = rad2deg([theta1b, theta2b, theta3b])  % sloB
%% Validate Geometric Solution

% Given (x = 1.986, y 3.117) and phi = 80 degrees,
% validate the th1 ~= 35 degrees, th2 ~= 45 degrees 
% and th3 ~= 0 degrees.

% see above



