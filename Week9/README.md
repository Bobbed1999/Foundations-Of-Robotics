This week, we will delve into the fundamental concepts of linear and angular velocity of rigid bodies, utilizing them to analyze the motion of a manipulator through Velocity (Differential) Kinematics. Additionally, we will be introduced the Jacobian (J) matrix, a crucial entity in robotics, laying the groundwork for solving specific problems. Forward Velocity Kinematics (VK) explores the relationship between joint and end-effector velocities, crucial for tasks like motion planning. The Jacobian matrix maps these velocities, with Kinematics Singularities highlighting configurations where control may be challenging. Inverse Velocity Kinematics (IVK) solves for joint velocities to achieve desired end-effector velocities. Finally, we will master these concepts in practical application using MATLAB and the Robotics Toolbox (RTB).


![alt text](image-1.png)
![alt text](image.png)


![alt text](image-2.png)
![alt text](image-3.png)


![alt text](image-4.png)
![alt text](image-5.png)

diff between before and now. 

![alt text](image-6.png)
in the past we studied FK IK for caculate the position of end effector. 

![alt text](image-7.png)
now we are learning how to control the rate/velocity of the end effector.



![alt text](image-8.png)
This expresses how to change the reference frame for a Jacobian.
![alt text](image-9.png)
![alt text](image-10.png)
![alt text](image-11.png)




![alt text](image-12.png)
Robotics
Jacobian not invertible
Velocity control impossible in some directions
![alt text](image-13.png)


