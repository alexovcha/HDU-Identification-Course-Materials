%% Cases
% y = 2*x1 + 5*x2 + v; Pass all 5 Hypo
% y = -3*x1 + 8*x2 + v; Fail H1 and H5
% y = -5*x1 + 2*x2 + v; Fail H3
% y = 12*x1 - 8.3*x2 + v; Fail H5
% y = 7*x1 - 3*x2 + v;
% y = -2*x1 - 8*x2 + v;
% y = 1.1*x1 + 5.32*x2 + v;
% y = 1.1*x1 + 5.32*x2 + v;

% Useful function
% std - standard deviaton
% var - variance
% cov - co-variance
% corrcoef(A,B) - correlation
% mean - expected value
% autocorr - autocorr function

%% Here complete the task

load mat/case4.mat

% 1. Build the extended model with measuments
Y = y;
Phi = [x1, x2];

phi1 = x1; % first column of phi matrix
phi2 = x2; % second column of phi matrix

%% Error of Y

th = inv(Phi'*Phi) * Phi'*Y;
Ye = Y - Phi*th;

%% H1. Check expected value. Use mean(...) and hist(...) Pass
% Pass H1 if
% Ev < epsion * (v_max - v_min)
% Steps:
% 1. Choose eps = ...
% 2. Calculate condition eps * (v_max - v_min)
% 3. Compare mean value and condition abs(Ev) < eps * (v_max - v_min)
eps_H1 = 0.01;


Ev = mean(Ye);
H1cond = eps_H1*(max(Ye) - min(Ye));

disp("H1 (Ev, H1cond)")
[abs(Ev), H1cond]
% Ev < H1cond to pass the H1

%% H2. Here we use correlation coefficients. Use corrcoef(...) Pass
% [ corr(phi1, phi1), corr(phi1, v) ]
% [ corr(v, phi2),    corr(v, v) ]
eps_H2 = 0.1;

CorrPhi1V = corrcoef(phi1, Ye);
CorrPhi2V = corrcoef(phi2, Ye);

disp("H2 (CorrPhi1V, CorrPhi2V, eps)")
[abs(CorrPhi1V(1, 2)), abs(CorrPhi2V(1, 2)), eps_H2]

%% H3. Check X'*X singularity. Use det(...) and cond(...) Pass
% cond(Phi'*Phi) < eps_H3_cond;
eps_H3_cond = 1000;

determinantOfPhi = det(Phi'*Phi);
coditionOfPhi = cond(Phi'*Phi);

% theta = inv(Phi'*Phi) * Phi' * Y

disp("H3 (cond, eps)")
[coditionOfPhi, eps_H3_cond]
% if coditionOfPhi < eps_H3_cond then H3 will passed

%% H4. Check the variance in measumetns. Pass
% Split Phi to n parts and use var(...) in loop.
eps_H4 = 1;

% size of the window (min value is 10)
n = 20;
D = [];
for i = 1:n
    span = (i-1)*size(Ye)/n + 1:i*size(Ye)/n;
    D(i) = var(Ye(span));
end


figure(1)
title("Variance")
plot(D)

coditionOfD = max(D) - min(D);
disp("H4 (max(D)-min(D), eps)")
[coditionOfD, eps_H4]

%% H5 Pass

figure(2)
title("H5, autocorr")
autocorr(v)