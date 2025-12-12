clc;
clear all;
close all;

disp('PUMA560 Nonplanar')
syms th1 th2 th3 th4 th5 th6;
syms a1 a2 a3 d3 d4;

%% MDH: i-1->i  (alpha_{i-1}, a_{i-1}, d_i, theta_i)
MDH = @(alp, a, d, th) [...
    cos(th),            -sin(th),           0,          a; 
    sin(th)*cos(alp),   cos(th)*cos(alp),  -sin(alp),  -sin(alp)*d;
    sin(th)*sin(alp),   cos(th)*sin(alp),   cos(alp),   cos(alp)*d;
    0,                   0,                  0,          1];

%% ---------- Part 1: Constructing a piecewise homogeneous matrix from a table ----------
% Table: (alpha_{i-1}, a_{i-1}, d_i, theta_i)
T_0_1 = MDH(  0,     0,   0,   th1);
T_1_2 = MDH(-pi/2,   0,   0,   th2);
T_2_3 = MDH(  0,    a2,  d3,   th3);
T_3_4 = MDH(-pi/2,  a3,  d4,   th4);
T_4_5 = MDH( pi/2,   0,   0,   th5);
T_5_6 = MDH(-pi/2,   0,   0,   th6);

% print
disp('T_0_1 ='); disp(simplify(T_0_1));
disp('T_1_2 ='); disp(simplify(T_1_2));
disp('T_2_3 ='); disp(simplify(T_2_3));
disp('T_3_4 ='); disp(simplify(T_3_4));
disp('T_4_5 ='); disp(simplify(T_4_5));
disp('T_5_6 ='); disp(simplify(T_5_6));


%% Transformations（0->6）
T_0_6 = simplify(T_0_1*T_1_2*T_2_3*T_3_4*T_4_5*T_5_6);
disp('T_0_6 ='); disp(T_0_6);


%% ---------- Part 2: Substitute the given values ​​and output R and p ----------
vals = {th1, th2,  th3, th4, th5, th6,  a1, a2,    a3,    d3,    d4};
nums = {  0,  pi/2, 0,   0,   0,   0,    0, 0.431, 0.431, 0.139, 0.056};

T_0_6_num = vpa(subs(T_0_6, vals, nums), 6);
R_0_6 = T_0_6_num(1:3,1:3);
p_0_6 = T_0_6_num(1:3,4);

disp('Rotation R_0_6 (numeric) ='); disp(R_0_6);
disp('Position p_0_6 (numeric) ='); disp(p_0_6);

%%  DH Parameters [theta, d, a, alpha, offset]
a2 = 0.431;    % [m]
a3 = 0.431;
d3 = 0.139;
d4 = 0.056;
% 6 MDH joint（revolute）
L(1) = RevoluteMDH('alpha',   0,    'a', 0,   'd', 0,    'offset', 0);
L(2) = RevoluteMDH('alpha', -pi/2,  'a', 0,   'd', 0,    'offset', 0);
L(3) = RevoluteMDH('alpha',   0,    'a', a2,  'd', d3,   'offset', 0);
L(4) = RevoluteMDH('alpha', -pi/2,  'a', a3,  'd', d4,   'offset', 0);
L(5) = RevoluteMDH('alpha',  pi/2,  'a', 0,   'd', 0,    'offset', 0);
L(6) = RevoluteMDH('alpha', -pi/2,  'a', 0,   'd', 0,    'offset', 0);

puma_mdh = SerialLink(L, 'name', 'PUMA560-MDH');
q_zero = [0 0 0 0 0 0];
puma_mdh.teach(q_zero);

%% check if it is correct
T_0_6_num;
disp('T_0_6_num ='); disp(T_0_6_num);

q_part2 = [0 pi/2 0 0 0 0];
T_rtb   = puma_mdh.fkine(q_part2).T;

disp('T_rtb ='); disp(T_rtb);

err = norm(T_rtb - T_0_6_num, 'fro');
fprintf('||T_RTB - T_sym||_F = %.3e\n', err);

R = T_0_6_num(1:3,1:3)
p = T_0_6_num(1:3,4)