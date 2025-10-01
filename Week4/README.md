# Week 4 – Forward Kinematics with Denavit–Hartenberg Parameters & ROS2 Core Concepts

## Topic Description
This week introduces **Forward Kinematics (FK)**, a cornerstone of robotics that allows us to compute the position and orientation of a robot’s end-effector given its joint parameters. We focus on the **Denavit–Hartenberg (DH) convention**, a systematic way of representing kinematic chains using a minimal set of parameters.  

In parallel, we expand our ROS2 skills by covering **core concepts**: actions, logging, launch files, and recording/playing back data. These tools are essential for building scalable robotic applications and debugging system behavior.

## Learning Outcomes
By the end of Week 4, we should be able to:
- At the end of this course week, students will be able to...
- Recognize different types of actuators and sensors used in robotics
- Perform basic matrix and vector operations
- Describe a point relative to a frame
- Perform operations with MATLABLinks to an external site. programming platform (Installation Guide)

## To Read
- Chapter 5 - Bruno's book
- Chapter 2 [2.1 - 2.4] - Craig's book

## Lecture Highlights
### Forward Kinematics & DH Convention
- **Forward Kinematics (FK)**: mapping from joint space (angles, displacements) to Cartesian space (position, orientation).  
- **DH Parameters** (per joint/link):  
  1. Link length \(a_i\)  
  2. Link twist \(\alpha_i\)  
  3. Link offset \(d_i\)  
  4. Joint angle \(\theta_i\)  
- Homogeneous transformation representation (\(A_i\)): compact 4×4 matrix capturing both rotation and translation.  
- Step-by-step procedure:  
  - Assign coordinate frames  
  - Construct DH table  
  - Multiply transformations:  
    \[
    T = A_1 A_2 \cdots A_n
    \]  
- Applications: robotic arm modeling, simulation, motion planning.  

### ROS2 Core Concepts
- **Actions**: asynchronous, long-running tasks (e.g., move a robot arm to a position).  
- **Logging**: debugging and monitoring node behavior.  
- **Launch files**: orchestrating multiple nodes/processes with YAML/XML launch files.  
- **Record/Playback (ros2 bag)**: capturing message traffic for debugging and replay.  

## To Do
- **Week 4 Assignment**: Construct DH parameters and compute forward kinematics for a simple robot manipulator.  
- **Quiz 4**: Covers DH convention, forward kinematics derivations, and ROS2 core concepts.  
- **Discussion**: Compare advantages and limitations of DH convention vs. alternative representations (e.g., Product of Exponentials).  

## Robot-Lab 4
- **Task**: Use ROS2 Turtlesim to draw “WPI” with multiple turtles.  
  - Practice ROS2 **actions** by controlling turtles.  
  - Write a **launch file** to start multiple turtlesim nodes simultaneously.  
  - **Record** your turtle’s path using `ros2 bag record`.  
  - **Replay** the recorded data to reproduce the drawing.  

## Quiz 4 Focus
- Deriving forward kinematics using DH parameters  
- Constructing transformation matrices  
- ROS2 actions vs. services vs. topics  
- Using launch files and ros2 bag for logging and playback  
