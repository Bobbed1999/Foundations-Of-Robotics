close all;
clear all;
clc;

%%
syms q1 q2 q3 real

%%
% === Step 1: DH parameters ===
a1=0; a2=0; a3=0;
alpha1=-pi/2; alpha2=pi/2; alpha3=0;
theta1=0; theta2=pi/2; theta3=-pi/2;
d1=q1; d2=q2; d3=q3;

%%
% === Step 2: Compute A matrices ===
A1 = [cos(theta1) -sin(theta1)*cos(alpha1)  sin(theta1)*sin(alpha1)  a1*cos(theta1);
      sin(theta1)  cos(theta1)*cos(alpha1) -cos(theta1)*sin(alpha1)  a1*sin(theta1);
      0            sin(alpha1)              cos(alpha1)              d1;
      0 0 0 1];

A2 = [cos(theta2) -sin(theta2)*cos(alpha2)  sin(theta2)*sin(alpha2)  a2*cos(theta2);
      sin(theta2)  cos(theta2)*cos(alpha2) -cos(theta2)*sin(alpha2)  a2*sin(theta2);
      0            sin(alpha2)              cos(alpha2)              d2;
      0 0 0 1];

A3 = [cos(theta3) -sin(theta3)*cos(alpha3)  sin(theta3)*sin(alpha3)  a3*cos(theta3);
      sin(theta3)  cos(theta3)*cos(alpha3) -cos(theta3)*sin(alpha3)  a3*sin(theta3);
      0            sin(alpha3)              cos(alpha3)              d3;
      0 0 0 1];

%%
% === Step 3: Overall T ===
T03 = simplify(A1*A2*A3);

%%
% === Step 4: Extract position vector p_e ===
p_e = T03(1:3,4);

%%
% === Step 5: Compute Jp by partial derivatives ===
Jp = simplify([diff(p_e,q1), diff(p_e,q2), diff(p_e,q3)]);

%%
% === Step 6: Jo (prismatic => 0) ===
Jo = zeros(3,3);

%%
% === Step 7: Full Jacobian ===
J = [Jp; Jo];

%%
% === Step 8: Display ===
disp('T_0^3 ='); disp(simplify(T03));
disp('Jacobian J ='); disp(J);
disp(['Rank(Jp) = ', num2str(rank(Jp))]);
if rank(Jp)<3
    disp('Singular configuration found.');
else
    disp('No singularities (PPP is fully controllable).');
end