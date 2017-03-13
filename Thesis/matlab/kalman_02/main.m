% Start the app

close all;
clear all;
clc;

%% Data
data_file = 'data/steady_data_03.dat';
fileId = fopen(data_file, 'r');
size = [7 Inf];
formatSpec = '%f %f %f %f %f %f %f';
data = fscanf(fileId, formatSpec, size);
fclose(fileId);

tt = data(1,:);
xx = data(2,:);
yy = data(3,:);
zz = data(4,:);

%% Model

% determine sampling rate
dT = mean(diff(tt)) / 100;
F = [
    1 0 0 dT 0 0;
    0 1 0 0 dT 0;
    0 0 1 0 0 dT;
    0 0 0 1 0 0;
    0 0 0 0 1 0;
    0 0 0 0 0 1;
];
H = eye(6);

x0 = [0;0;0; 0;0;0];
sigma_a = 0.001^2;
Q = sigma_a*eye(6);
R = 10*eye(6);

N = length(xx);

xx = xx(1:N);
yy = yy(1:N);
zz = zz(1:N);

a = [xx;zeros(1,N);yy;zeros(1,N);zz;zeros(1,N)];

x_h(:,1) = x0;
P = Q;

K = P*H*(H*P*H+R)';

for t=1:N
    % update step
    x_h(:,t) = x_h(:,t) + K * (a(:,t) - H*x_h(:,t));
    P = P - K *H*P;
    K = P*H*(H*P*H+R)';

    % prediction step
    x_h(:,t+1) = F*x_h(:,t);
    
    P = F*P +Q;
    %P(:,t+1) = F*P(:,t) + Q;    
    
end

%% Plot

figure;
plot(K(1,:), 'r');
hold on;
plot(P(1,:), 'b');
grid on;
hold off;

figure;
hold on;
plot(a(1,:), 'r');
plot(a(2,:), 'r');
plot(a(3,:), 'r');

plot(x_h(1,:), 'b');
plot(x_h(2,:), 'b');
plot(x_h(3,:), 'b');
grid on;
hold off;
