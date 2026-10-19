t = (1:21)';             % t = 1, 2, ..., 21
Y = log(t);              % true output (no noise)

%% Model 1: y = a*t + b

% 1. y = Y
% 2. phi = [t, 1]; theta = [a; b]

% regressor matrix
Phi1 = [t, ones(size(t))];

% least squares estimate
theta1 = inv(Phi1' * Phi1) * Phi1' * Y; % Important to use inv function!

% predicted output
Yhat1 = Phi1*theta1;

% loss
J1 = (Y - Yhat1)' * (Y - Yhat1);

%% Model 2: y = a*t^2 + b*t + c
% Phi2 = [t^2, t, 1]
Phi2 = [t.^2, t, ones(size(t))];
% Least square estimate
theta2 = inv(Phi2' * Phi2) * Phi2' * Y;
Yhat2 = Phi2*theta2;

% Loss function
J2 = (Y - Yhat2)'*(Y - Yhat2);

%% Model 3: y = a0 + a1*t + ... + a10*t^10
% Phi = [t^10, t^9, ..., t, 1]
Phi3 = [t.^10, t.^9, t.^8, t.^7, t.^6, t.^5, t.^4, t.^3, t.^2, t, ones(size(t))];
% Least squares estimator
theta3 = inv(Phi3' * Phi3) * Phi3' * Y;
Yhat3 = Phi3*theta3;

% Loss function
J3 = (Y - Yhat3)'*(Y - Yhat3);

%% Figures

figure;
hold on; grid on;
scatter(t, Y)
plot(t, Yhat1)
plot(t, Yhat2)
plot(t, Yhat3)
legend('log(t)', 'at + b', 'at^2 + bt + c', '10 order poly')
