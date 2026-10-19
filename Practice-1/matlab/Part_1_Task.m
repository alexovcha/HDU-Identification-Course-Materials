% 1. Find the output y.
% 2. Separate known (phi_i) and unknown (theta_i$) parts.
% 3. Write the LRM in matrix form.

%% Task 1
% Equation: mg - bv = m dv
syms m g b v dv

y1 = g - dv;
phi1 = [v]; % Fill in matrix form [phi1, phi2]
theta1 = [b/m]; % Fill in matrix form


%% Task 2
% Equation: U = RI + (1/C) intI
syms R C U I intI % Last is the integral of I

y2 = 0;
phi2 = []; % Fill in matrix form [phi1, phi2]
theta2 = []; % Fill in matrix form

%% Task 3
% Equaton: z = a_0 + a_1 T + a_2 T^2 + a_3 T^3
syms z T a0 a1 a2 a3

y3 = 0;
phi3 = []; % Fill in matrix form [phi1, phi2]
theta3 = []; % Fill in matrix form