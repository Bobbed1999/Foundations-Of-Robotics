close all;
clear all;
clc;

%% Q1
% 1) Symbols and functions
syms l1 l2 real
syms theta1 theta2 real

x = l2*cos(theta1 + theta2) + l1*cos(theta1);
y = l2*sin(theta1 + theta2) + l1*sin(theta1);

%% 2) Partial derivatives
dx_dtheta1 = simplify(diff(x, theta1));
dx_dtheta2 = simplify(diff(x, theta2));
dy_dtheta1 = simplify(diff(y, theta1));
dy_dtheta2 = simplify(diff(y, theta2));

%% 3) Display closed-form results
disp('--- Closed-form partial derivatives ---');
fprintf('dx/dtheta1 = %s\n', char(dx_dtheta1));  
fprintf('dx/dtheta2 = %s\n', char(dx_dtheta2));  
fprintf('dy/dtheta1 = %s\n', char(dy_dtheta1));  
fprintf('dy/dtheta2 = %s\n', char(dy_dtheta2));

%% Q2

mdl_puma560       % 
p560
p560.teach(qn)    % gui

%%
q0 = [0 0 0 0 0 0];
J0 = p560.jacob0(q0); 
 
fprintf('det(J0) = %.6g,  rank(J0) = %d\n', det(J0), rank(J0));

pv = [1 0 0 0 0 0]'; 
qv_dot = pinv(J0) * pv; 
% 6) Display results neatly (row form)
disp('qv_dot'' (rad/s) ='); disp(qv_dot');


%% Q3
mdl_puma560       % 
p560
p560.teach(qn)    % gui
%%
qt = [0 pi/4 -pi/4 0 0 0];
Jt = p560.jacob0(qt);
fprintf('det(Jt) = %.6g,  rank(Jt) = %d\n', det(Jt), rank(Jt));
pt = [0 0.5 0.5 0 0 0]'; 
qt_dot = pinv(Jt) * pt;
disp('qt_dot'' (rad/s) ='); disp(qt_dot');