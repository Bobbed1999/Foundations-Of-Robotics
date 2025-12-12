clc
clear all
close all

%% Load Puma 560 model
% mdl_puma560
% p560

%% Load Baxter model (RTB)
mdl_baxter
arm = right
arm.teach()

%% Set the Initial and Goal positions
% Consider the end-effector moving between two Cartesian poses which 
% describe points in the xy-plane with different end-effector orientations.
% T1 = SE3(0.2,  0.3, 0) * SE3.Rx(pi)
% T2 = SE3(0.6, -0.6, 0) * SE3.Rx(pi/2)
% 
% % The joint coordinate vectors associated with these poses are:
% q1 = p560.ikine6s(T1)
% q2 = p560.ikine6s(T2)

%p560.teach(q1)
%p560.teach(q2)

%% move the arm in UI to set Initial
q1 = arm.getpos();
T1 = arm.fkine(q1);
%% move the arm in UI to set Goal positions
q2 = arm.getpos();
T2 = arm.fkine(q2);

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
plot(t, p);%
xlabel('t [s]'); ylabel('position [m]')
legend('x','y','z')

%%
figure
plot(t, Ts.torpy('xyz'));
legend('roll','pitch','yaw')

%%
% The corresponding joint-space trajectory is obtained by applying the 
% inverse kinematics
qc = arm.ikine(Ts,q1);

% The end-effector follows a straight line in the xy-plane as we see in
% this motion plot below.
figure
arm.plot(qc)

%% Plot all the nagles versus time
figure
plot(t, qc, 'LineWidth', 1.5); grid on
xlabel('t [s]'); ylabel('joint angle [rad]')
leg = arrayfun(@(i) sprintf('q%d', i), 1:size(qc,2), 'UniformOutput', false);
legend(leg, 'Location','bestoutside')