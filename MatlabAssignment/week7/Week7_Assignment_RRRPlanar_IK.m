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

%% Validate Algebraic Solution

% Given (x = 1.986, y 3.117) and phi = 80 degrees,
% validate the th1 ~= 35 degrees, th2 ~= 45 degrees 
% and th3 ~= 0 degrees.

%% Inverse Kinematics - Geometric Solution

% Lecture 7 offers the methods to derive th1, th2 and th3 angles

%% Validate Geometric Solution

% Given (x = 1.986, y 3.117) and phi = 80 degrees,
% validate the th1 ~= 35 degrees, th2 ~= 45 degrees 
% and th3 ~= 0 degrees.





