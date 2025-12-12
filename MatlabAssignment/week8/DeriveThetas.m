
close all;
clear all;
clc;

%%
T = [ 0.2432  0.3420  0.9077  1.6276;
      0.0885 -0.9397  0.3304  0.5924;
      0.9659  0      -0.2588  4.0000;
      0       0       0       1      ];
l1 = 3; l2 = 2; l3 = 1.1;

R = T(1:3,1:3);
p = T(1:3,4);

clip     = @(x) max(-1,min(1,x));
wrapToPi = @(x) atan2(sin(x),cos(x));

%% % ---------- Step A (Lecture 8: from rotation) ----------
% phi = theta2 + theta3;  theta1 from R
phi    = atan2(R(3,1), -R(3,3));  
theta1 = atan2(R(2,3),  R(1,3));  
% ---------- Step B (from position pz) ----------
% pz = l1 + l2*sin(theta2)  ->  s2 = (pz - l1)/l2
s2 = clip((p(3) - l1)/l2); % sin(theta2)
c2a =  sqrt(max(0,1 - s2^2));               % elbow-up
c2b = -c2a;                                  % elbow-down
% ---------- Step C (radial consistency with px,py) ----------
A_meas = p(1)*cos(theta1) + p(2)*sin(theta1); 
sols = [];
for c2 = [c2a c2b]
    t2 = atan2(s2, c2);
    A_pred = l2*c2;
    if abs(A_meas - A_pred) < 1e-4          % keep only consistent branch(es)
        t3 = phi - t2;
        sols = [sols; wrapToPi([theta1, t2, t3])]; %#ok<AGROW>
    end
end
sols = unique(round(sols,12),'rows');

% ---------- Print answers (degrees) ----------
if isempty(sols)
    fprintf('No valid solution under this model.\n');
else
    fprintf('Solutions (deg):\n');
    for i = 1:size(sols,1)
        th = sols(i,:);
        fprintf('#%d: [theta1=%.2f, theta2=%.2f, theta3=%.2f]\n', ...
            i, rad2deg(th(1)), rad2deg(th(2)), rad2deg(th(3)));
    end
end

% ---------- Quick verification (rebuild T and report error) ----------
if ~isempty(sols)
    th = sols(1,:);
    c1=cos(th(1)); s1=sin(th(1));
    c2=cos(th(2)); s2=sin(th(2));
    c23=cos(th(2)+th(3)); s23=sin(th(2)+th(3));

    % Rotation from the statement
    Rchk = [ c1*c23   s1     c1*s23
             s1*c23  -c1     s1*s23
               s23     0     -c23 ];
    % Position (NO l3 term)
    pchk = [ l2*c1*c2
             l2*s1*c2
             l1 + l2*s2 ];
    Terr = norm([Rchk pchk; 0 0 0 1] - T, 'fro');
    fprintf('||T_rebuilt - T||_F = %.3e\n', Terr);
end