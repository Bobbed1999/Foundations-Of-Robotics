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

%% Question 2
disp("Find the transformation from frame {B} to frame {C} --> B_T_C");

%% Question 3
disp("Find the transformation from frame {A} to frame {C} --> A_T_C");

%% INFO
disp("Given point P with reference frame {C} equal to C_P = [1; 1; 0]");
C_P = [1; 1; 0];

%% Question 4
disp("What is the point P with reference frame {A} --> A_P?");

%% Question 5
disp("What is the point P with reference frame {B} --> B_P?");

%% Question 6
disp("Find the transformation from frame {B} to frame {A} --> B_T_A");

%% Question 7
disp("Find the transformation from frame {C} to frame {B} --> C_T_B");

%% Question 8
disp("Calculate rotation matrix (A_R_ZYX_B) using Z-Y-X Euler Angle-set convention when:")
alpha = -30;
beta = 30;
gamma = -45;



