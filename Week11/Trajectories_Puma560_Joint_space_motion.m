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

%% JOINT-SPACE MOTION
% A joint-space trajectory is formed by smoothly interpolating between 
% the joint configurations q1 and q2.
q = jtraj(q1, q2, t);

% We can obtain the joint velocity and acceleration vectors, as a function 
% of time, through optional output arguments
[q, qd, qdd] = jtraj(q1, q2, t);

% An even more concise way to achieve the above steps is provided by the 
% jtraj method of the SerialLink class
q = p560.jtraj(T1, T2, t);

% Show the trajectory as an animation
figure
p560.plot(q)

% Plot the joint angle, for instance q2, versus time
figure
plot(t, q(:,2))

% Plot all the nagles versus time
figure
qplot(t, q);

% The joint coordinate trajectory is smooth but we do not know how the 
% robot’s end-effector will move in Cartesian space. However we can 
% easily determine this by applying forward kinematics to the joint 
% coordinate trajectory
T = p560.fkine(q);

% The translational part of this trajectory is
p = T.transl

% ,which has one column per time step, and each column is the end-effector 
% position vector. The path of the end-effector in the xy-plane
figure
plot(p(1,:), p(2,:))

% As the robot rotates about its waist joint during the motion the 
% end-effector will naturally follow a circular arc. In practice this 
% could lead to collisions between the robot and nearby ob- jects even 
% if they do not lie on the path between poses A and B. The orientation 
% of the end-effector, in XYZ roll-pitch-yaw angle form, can also be 
% plotted against time
figure
plot(t, T.torpy('xyz'))