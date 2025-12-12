clear all;
close all;
clc;

disp('RPR-Cylindrical-and-Link-Transformations')
syms L1 L2 d2;

%% Link lengths
L1 = 0;
L2 = 1;

%% DH Parameters [theta, d, a, alpha, offset]
j1 = RevoluteMDH();
j1.qlim = pi/180*[-180 180];

j2 = PrismaticMDH('alpha', pi/2);
j2.qlim = [0 2];

j3 = RevoluteMDH('d', L2);
j3.qlim = pi/180*[-180 180];

robot = SerialLink([j1 j2 j3], 'name', 'RPR-Cylindrical')
robot.teach();

%% Link Transformations 

syms Transformation(alphai_1, ai_1, di, thi)

T1 = [cos(thi) -sin(thi) 0 ai_1];
T2 = [sin(thi)*cos(alphai_1) cos(thi)*cos(alphai_1) -sin(alphai_1) -sin(alphai_1)*di];
T3 = [sin(thi)*sin(alphai_1) cos(thi)*sin(alphai_1) cos(alphai_1) cos(alphai_1)*di];
T4 = [0 0 0 1];

Transformation(alphai_1, ai_1, di, thi) = [T1; T2; T3; T4];

syms th1 th3 d2 L2

T_0_1 = Transformation(0, 0, 0, th1);
T_1_2 = Transformation(pi/2, 0, d2, 0);
T_2_3 = Transformation(0, 0, L2, th3);

%% Final Homogeneous Transformation

T_0_3 = T_0_1 * T_1_2 * T_2_3

%% Evalaation
th1 = 0;
th3 = 0;
L2 = 1;
d2 = 2;

eval(T_0_3)
