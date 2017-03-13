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

%% Make time unique

tt = data(:,1);
% tt = tt(1:70);
[~, dtt] = findpeaks(diff(tt));
F = mean(diff(dtt));
T = 1/F;
N = length(tt);
X = 0:T:T*(length(tt)-1);

%% Position part

Ax = data(:,2);
Ay = data(:,3);
Az = data(:,4);

% Remove DC component
Ax = Ax - mean(Ax(1:2));
Ay = Ay - mean(Ay(1:2));
Az = Az - mean(Az(1:2));

Px = cumtrapz(X, cumtrapz(X, Ax));
Py = cumtrapz(X, cumtrapz(X, Ay));
Pz = cumtrapz(X, cumtrapz(X, Az));

%% Kalman filter

dT = T;
% state size
ss = 9; 
% sample size
os = 3;
% Filtered position
F = [
   1 0 0 dT 0 0 0.5*dT^2 0 0;
   0 1 0 0 dT 0 0 0.5*dT^2 0;
   0 0 1 0 0 dT 0 0 0.5*dT^2;
   
   0 0 0 1 0 0 dT 0 0;
   0 0 0 0 1 0 0 dT 0;
   0 0 0 0 0 1 0 0 dT;
   
   0 0 0 0 0 0 1 0 0;
   0 0 0 0 0 0 0 1 0;
   0 0 0 0 0 0 0 0 1;
]; 

H = [
   0 0 0 0 0 0 1 0 0;
   0 0 0 0 0 0 0 1 0;
   0 0 0 0 0 0 0 0 1;
];

Q = eye(ss)*0.1;
R = eye(os)*0.8;

x_estimate = zeros(ss,1);
P = ones(ss,ss)*0.3;

% Initial Kalman gain
for t=1:N
    A = [Ax(t); Ay(t); Az(t)];
    
    % Prediction step
    x_predition = F*x_estimate;
    P = F*P*F'+Q;
    
    % Correction step
    S = H*P*H'+R;
    K = P*H'*inv(S);
    
    x_estimate = x_predition + K * (A - H*x_predition);
    P = P-K*H*P;
    
    x_h(:,t) = x_predition;
    
end


Pkx = x_h(7,:);
Pky = x_h(8,:);
Pkz = x_h(9,:);

%% Plot sensor axis

figure;
subplot(3,1,1);
plot(Ax);
hold on;
plot(Pkx, 'r');
grid on;
hold off;

subplot(3,1,2);
plot(Ay);
hold on;
plot(Pky, 'r');
grid on;
hold off;

subplot(3,1,3);
plot(Az);
hold on;
plot(Pkz, 'r');
grid on;
hold off;

%% Plot position

figure;
plot(Px, Py, 'b*');
hold on;
plot(x_h(1,:), x_h(2,:), 'ro');
xlabel('x, cm');
ylabel('y, cm');
grid on;
hold off;


%% Animate movement
%animate_plot(x_h(1,:), x_h(2,:));