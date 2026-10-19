%% Case 1
x1 = linspace(-5, 10, 1000)';
x2 = linspace( 1,  3, 1000)';
x  = 1:1:size(x2, 1);

muv = 0; sv  = 1;
v = normrnd(muv, sv, size(x1, 1), 1);

y = 2*x1 + 5*x2 + v;

save case1.mat x1 x2 y v

%% Case 2
x1 = linspace(-5, 10, 1000)';
x2 = linspace( 1,  3, 1000)';
x  = 1:1:size(x2, 1);

muv = 1; sv  = 1;
v = normrnd(muv, sv, size(x1, 1), 1);

y = -3*x1 + 8*x2 + v;

save case2.mat x1 x2 y v

%% Case 3
x1 = linspace(1, 10, 1000)';
x2 = x1;
x  = 1:1:size(x2, 1);

muv = 0; sv  = 1;
v = normrnd(muv, sv, size(x1, 1), 1);

y = -5*x1 + 2*x2 + v;

save case3.mat x1 x2 y v

%% Case 4
t = linspace(0, 15, 1000)';
x1 = sin(t);
x2 = cos(t);

muv = 0; sv  = 1;
v = normrnd(muv, sv, size(x1, 1), 1);

y = 12*x1 - 8.3*x2 + v;

save case4.mat x1 x2 y v

%% Case 5
t = linspace(0, 15, 1000)';
x1 = sin(t);
x2 = cos(t);

muv = 1; sv  = 1;
v = normrnd(muv, sv, size(x1, 1), 1);

y = 7*x1 - 3*x2 + v;

save case5.mat x1 x2 y v

%% Case 6
t = linspace(0, 15, 1000)';
x1 = sin(t);
x2 = cos(t);

n = size(x1, 1)/5;
muv = 0;
v = [normrnd(muv, 1, n, 1);  normrnd(muv, 2, n, 1); normrnd(muv, 0.5, n, 1); normrnd(muv, 1.5, n, 1); normrnd(muv, 0.8, n, 1)];

y = -2*x1 - 8*x2 + v;

save case6.mat x1 x2 y v

%% Case 7
t = linspace(0, 15, 1000)';
x1 = sin(t);
x2 = cos(t);

n = size(x1, 1)/5;
muv = 0; sv  = 1;
v = normrnd(muv, sv, size(x1, 1), 1) + 0.5*x1;

y = 1.1*x1 + 5.32*x2 + v;

save case7.mat x1 x2 y v

%% Case 8
t = linspace(0, 15, 1000)';
x1 = sin(t);
x2 = cos(t);

n = size(x1, 1)/5;
muv = 0;
v = [normrnd(muv, 1, n, 1);  normrnd(muv, 2, n, 1); normrnd(muv, 0.5, n, 1); normrnd(muv, 1.5, n, 1); normrnd(muv, 0.8, n, 1)] + 0.5*x2;

y = 1.1*x1 + 5.32*x2 + v;

save case8.mat x1 x2 y v
