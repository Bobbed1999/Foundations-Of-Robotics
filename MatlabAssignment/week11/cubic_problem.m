clc
clear all
close all

%%
syms t
% Define the cubic trajectory
theta = 10 + 90*t^2 - 60*t^3;

% Compute derivatives
theta_dot = diff(theta, t);      % velocity
theta_ddot = diff(theta_dot, t); % acceleration

% Evaluate at start (t=0) and end (t=1)
theta_0 = subs(theta, t, 0);
theta_1 = subs(theta, t, 1);
vel_0   = subs(theta_dot, t, 0);
vel_1   = subs(theta_dot, t, 1);
acc_0   = subs(theta_ddot, t, 0);
acc_1   = subs(theta_ddot, t, 1);

% Display results
fprintf('Position: start = %.2f, end = %.2f\n', theta_0, theta_1);
fprintf('Velocity: start = %.2f, end = %.2f\n', vel_0, vel_1);
fprintf('Acceleration: start = %.2f, end = %.2f\n', acc_0, acc_1);