clc
clear all
close all

%% Load Puma 560 model
mdl_puma560
p560

%% Set the Initial and Goal positions
% Consider the end-effector moving between two Cartesian poses which 
% describe points in the xy-plane with different end-effector orientations.
T1 = SE3(0.2,  0.3, 0) * SE3.Rx(pi)
T2 = SE3(0.6, -0.6, 0) * SE3.Rx(pi/2)

% The joint coordinate vectors associated with these poses are:
q1 = p560.ikine6s(T1)
q2 = p560.ikine6s(T2)

%p560.teach(q1)
%p560.teach(q2)

%% Set the time period to execute a trajectory
% We require the motion to occur over a time period of 2 seconds 
% in 50 ms time steps
t = [0:0.1:2]';

%% CARTESIAN MOTION

% For many applications we require straight-line motion in Cartesian space 
% which is known as Cartesian motion. This is implemented using the Toolbox 
% function ctraj which is very similar to jtraj where the arguments are the 
% initial and final pose and the number of time steps and it returns the 
% trajectory as an array of SE3 objects.
Ts = ctraj(T1, T2, length(t));

% As for the previous joint-space example we will extract and plot the 
% translation and orientation components of this motion.
% The translational part of this trajectory is
p = Ts.transl;
figure
plot(t, p);
figure
plot(t, Ts.torpy('xyz'));

% The corresponding joint-space trajectory is obtained by applying the 
% inverse kinematics
qc = p560.ikine6s(Ts);

% The end-effector follows a straight line in the xy-plane as we see in
% this motion plot below.
figure
p560.plot(qc)