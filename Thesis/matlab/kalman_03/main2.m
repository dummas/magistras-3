close all;
clear all;
clc;

%% Read the data

data_file_collection = {'g1', 'g2', 'g3', 'g4', 'g5'};
% 
% for data_file = data_file_collection
%     data = csvread(char(strcat('data/', data_file, '.txt')));
% end

data = csvread(char(strcat('data/', 'g5', '.txt')));

ss = 6;
os = 2;

tt = data(:,1);
[~, dtt] = findpeaks(diff(tt));
F = mean(diff(dtt));
dT = 1/F;
N = length(tt);
X = 0:dT:dT*(length(tt)-1);

ug1 = zeros(os, N);
% ug1(2, 70:90) = 0.02;
% ug1(2, 130:150) = -0.02;

%% Positions

Ax = data(:,2);
Ay = data(:,3);

Ax = Ax - mean(Ax);
Ay = Ay - mean(Ay);

Px = cumtrapz(X, cumtrapz(X, Ax));
Py = cumtrapz(X, cumtrapz(X, Ay));

%% Filter



F = [
    1 0 dT 0 0.5*dT^2 0;
    0 1 0 dT 0 0.5*dT^2;
    
    0 0 1 0 dT 0;
    0 0 0 1 0 dT;
    
    0 0 0 0 1 0;
    0 0 0 0 0 1
];

H = [
    0 0 0 0 1 0;
    0 0 0 0 0 1
];

Q = eye(ss)*0.3;
R = eye(os)*0.2;
B = [
    1 0 0 0 0 0;
    0 1 0 0 0 0
];

x_estimate = zeros(ss, 1);
P = ones(ss, ss)*0.3;

for t=1:N
    A = [Ax(t); Ay(t)];
    
    x_prediction = F*x_estimate + B'*ug1(:, t);
    P = F*P*F'+Q;
    
    S = H*P*H'+R;
    K = P*H'*inv(S);
    
    x_estimate = x_prediction + K * (A-H*x_prediction);
    P = P-K*H*P;
    
    x_h(:,t) = x_prediction;
end

Pkx = x_h(1,:);
Pky = x_h(2,:);


figure;
subplot(3,1,1);
plot(Px, Py, 'b');
hold on;
plot(Pkx, Pky, 'r');
axis([-0.1 0.1 -0.1 0.1]);
grid on;
hold off;

subplot(3,1,2);
plot(Ax); hold on; plot(x_h(5,:), 'r'); grid on; hold off;

subplot(3,1,3);
plot(Ay); hold on; plot(x_h(6,:), 'r'); grid on; hold off;