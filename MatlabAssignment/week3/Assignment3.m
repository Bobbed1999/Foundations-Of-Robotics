clear all;
close all;
clc;

%% INFO
disp("A frame {B} is rotated relative to frame {A} about z-axis by 20 " + ...
    "degrees and translated 5 units in x-axis plus 3 units in y-axis.");
disp("A frame {C} is rotated relative to frame {B} about z-axis by 25 " + ...
    "degrees and translated 3 units in x-axis plus 5 units in y-axis.");



%% Question 1
disp("Find the transformation from frame {A} to frame {B} --> A_T_B");
R_AB = rotz(20,'deg');   % 
A_P_BORG = [5;3;0];
A_T_B = [R_AB, A_P_BORG; 0, 0, 0, 1]

%% Question 2
disp("Find the transformation from frame {B} to frame {C} --> B_T_C");

R_BC = rotz(25,'deg'); 
B_P_C = [3; 5; 0]; 
B_T_C = [R_BC, B_P_C; 0, 0, 0, 1]


%% Question 3
disp("Find the transformation from frame {A} to frame {C} --> A_T_C");
A_T_C = A_T_B * B_T_C  % Compute the transformation from frame {A} to frame {C}


%% INFO
disp("Given point P with reference frame {C} equal to C_P = [1; 1; 0]");
C_P = [1; 1; 0];


%% Question 4
disp("What is the point P with reference frame {A} --> A_P?");
C_P = [1; 1; 0; 1];   % (x, y, z, 1)
A_P = A_T_C * C_P  % The first three items are xyz.

%% Question 5
disp("What is the point P with reference frame {B} --> B_P?");
B_P = B_T_C * C_P

%% Question 6
disp("Find the transformation from frame {B} to frame {A} --> B_T_A");
R_BA = inv(R_AB); 
B_P_A = -R_BA * A_P_BORG; 
B_T_A = [R_BA, B_P_A; 0, 0, 0, 1] % 

%% Question 7
disp("Find the transformation from frame {C} to frame {B} --> C_T_B");
R_CB = inv(R_BC);
C_P_B = -R_CB * B_P_C;
C_T_B = [R_CB, C_P_B; 0, 0, 0, 1]

%% Question 8
disp("Calculate rotation matrix (A_R_ZYX_B) using Z-Y-X Euler Angle-set convention when:")
alpha = -30;
beta = 30;
gamma = -45;

% alpha = 30;
% beta = 30;
% gamma = 30;

rotz(alpha,'deg')

roty(beta,'deg')

rotx(gamma,'deg')

A_R_ZYX_B = rotz(alpha,'deg') * roty(beta,'deg') * rotx(gamma,'deg')
