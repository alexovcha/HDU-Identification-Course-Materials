% y = th1*x1 + th2*x2 + v
n = 10000;

x1 = linspace(-5, 5, n)';
x2 = linspace(-100, 5, n)';
X = [x1, x2];

v = normrnd(0, 2, n, 1);
y = 5*x1 + 0.3*x2 + v;

%% Check Hypotheses
% H1. Check Expected value of the Noise:
H1 = mean(v);

% H2. v is independed with x1 and x2
H21 = corrcoef(x1, v); % success (not one)
H22 = corrcoef(x2, v); % success (not one)

% H3
H3 = det(X'*X);

% H4. Check variance D is constant
D = [var(v)];
D(2) = var(v(1:n/5));
D(3) = var(v(n/5+1:2*n/5));
D(4) = var(v(2*n/5+1:3*n/5));
D(5) = var(v(3*n/5+1:4*n/5));
D(6) = var(v(4*n/5+1:n));
% success

Dd = [];
w = n/2;
for i = 1:size(v, 1) - w
    Dd(i) = var(v(i:i+w));
end
plot(Dd)
ylim([0, 6])
% success

% H5
[acf,lags] = autocorr(v);
figure(2)
hold on; grid on;
scatter(lags, acf);
% success

% estimate 
th = inv(X'*X)*X'*y;

%% Task:

% 1. load mat file
data = load('case1.mat');

% 2. Generate LRE y = ..., X = [x1, x2] ...

% 3. Estimate the parameters th = ... (send info)

% 4. plot(y) and plot(v)

% 5. Check H1 - H5 (send info, accept or denied)

% std - standard deviaton
% var - variance
% cov - co-variance
% corrcoef(A,B) - correlation 
% mean - expected value
% autocorr - autocorr function