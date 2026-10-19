% Model: U = RI + L dI
syms U I dI R L

y = U;
phi = [I, dI];
theta = [R; L];

%% Model: F = m ddx + b dx + k x
syms F x dx ddx m b k

y = F;
% phi1 = ddx; theta1 = m
% phi2 = dx; theta2 = b
% phi3 = x; theta3 = k
phi = [ddx, dx, x];
theta = [m; b; k]; % This should be column
y = phi*theta

%% Model: z = a*1 + b u + cu^2
syms z u a b c
y = z;
% phi1 = 1; theta1 = a
% phi2 = u; theta2 = b
% phi3 = u^2; theta3 = c
phi = [1, u, u^2]; % This should be row
theta = [a; b; c]; % This should be column
y = phi*theta

