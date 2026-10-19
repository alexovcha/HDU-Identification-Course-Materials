clear all;

%% y = sin(t)

t = (-pi:pi/100:pi)';           % define time vector for t in [-pi, pi] with step pi/100
Y = sin(t);                     % define true output y = sin(t)

%% 1. Try different approximations:
% a) y = at + b => [t, 1]*[a ; b]
% b) y = a*t^2 + b*t + c => [t^2, t, 1] * [a; b; c]
% c) y = a10*t^10 + a9*t^9 + .... + a2*t^2 + a1*t + a0

% y = [t, 1] * [a; b]
% y = [t^2, t, 1] * [a; b; c]
% y = [t^10, t^9, ..., t, 1] * [a10; a9; ..., a1, a0]

% construct regressors
Phi1 = [t, ones(size(t))];
Phi2 = [t.^2, t, ones(size(t))];
Phi3 = [t.^10, t.^9, t.^8, t.^7, t.^6, t.^5, t.^4, t.^3, t.^2, t, ones(size(t))];

% estimate parameters with LSE using formula theta = (Phi'*Phi)^-1*Phi'*Y
theta1 = inv(Phi1'*Phi1)*Phi1'*Y;
theta2 = inv(Phi2'*Phi2)*Phi2'*Y;
theta3 = inv(Phi3'*Phi3)*Phi3'*Y;

%% 2. Calculate loss on the train dataset

Yhat1 = Phi1*theta1;
Yhat2 = Phi2*theta2;
Yhat3 = Phi3*theta3;

J1 = (Y - Yhat1)'*(Y - Yhat1);
J2 = (Y - Yhat2)'*(Y - Yhat2);
J3 = (Y - Yhat3)'*(Y - Yhat3);

%% 3. Plot figures
close all;

figure(1) % for the first approximation
plot(t, Y, '*')
hold on
plot(t, Yhat1);
hold off

%%
figure(2) % for the second approximation
plot(t, Y, '*')
hold on
plot(t, Yhat2);

%%
figure(3) % for the third approximation
plot(t, Y, '*')
hold on
plot(t, Yhat3, "LineWidth", 2);

%%
figure(4) % for all approximations
plot(t, Y, '*')
hold on
plot(t, Yhat1)
plot(t, Yhat2)
plot(t, Yhat3)
legend('$y$', '$y = at + b$', '$a*t^2 + b*t + c$', '$a_{10}*t^{10} + .... + a_0$', 'Interpreter','latex','FontSize', 14, 'Location', 'Southeast')
hold off