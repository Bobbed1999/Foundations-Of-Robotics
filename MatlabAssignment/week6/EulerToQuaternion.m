clear all;
close all;
clc;

%% https://en.wikipedia.org/wiki/Conversion_between_quaternions_and_Euler_angles#Source_code

%% Angles
% roll = pi/2;
% pitch = pi/8;
% yaw = pi/4;

roll = 0;
pitch = 0;
yaw = pi/2;

%% Euler to Quaternion angles conversion
cr = cos(roll * 0.5);
sr = sin(roll * 0.5);
cp = cos(pitch * 0.5);
sp = sin(pitch * 0.5);
cy = cos(yaw * 0.5);
sy = sin(yaw * 0.5);

qw = cr * cp * cy + sr * sp * sy;
qx = sr * cp * cy - cr * sp * sy;
qy = cr * sp * cy + sr * cp * sy;
qz = cr * cp * sy - sr * sp * cy;

Quaternions = [qx qy qz qw]
unit_quaternion = sqrt(qx^2 + qy^2 + qz^2 + qw^2) 

%% Quaternion to Euler angles conversion
sinr_cosp = 2 * (qw * qx + qy * qz);
cosr_cosp = 1 - 2 * (qx * qx + qy * qy);
sinp = sqrt(1 + 2 * (qw * qy - qx * qz));
cosp = sqrt(1 - 2 * (qw * qy - qx * qz));
siny_cosp = 2 * (qw * qz + qx * qy);
cosy_cosp = 1 - 2 * (qy * qy + qz * qz);

rollAngle = atan2(sinr_cosp, cosr_cosp);
pitchAngle = 2 * atan2(sinp, cosp) - pi / 2;
yawAngle = atan2(siny_cosp, cosy_cosp);

EulerAngles = [rollAngle pitchAngle yawAngle]

