close all;
clear all;
clc;

n = 1; % number of state
q = 0.01; % std of process
r = 0.01; % std of measurement
Q = q^2*eye(n); % covariance of process
R = r^2; % covariance of measurement
f = @(x)x(1); % nonlinear state equations
h = @(x)sin(x(1)); % measurement equation
s = 0.1; % initial state
x=s+q*rand(n,1); % initial state with noise
P = eye(n);
N = 200;
xV = zeros(n,N);
sV = zeros(n,N);
zV = zeros(1,N);

for k=1:N
    % measurements
    z = h(s) + r*rand;
    sV(:,k) = s; % save actual state
    zV(k) = z; % save measurement
    
    % EKF
    [x1, A] = jaccsd(f, x);
    P = A*P*A'+Q;
    [z1, H] = jaccsd(h, x1);
    P12 = P*H';
    
    K = P12*inv(H*P12+R);
    x=x1+K*(z-z1);
    P = P - K*P12';
    
    xV(:,k) = x; % save estimate
    s = f(s) + q*rand(n,1); % update process
    
end

for k=1:n
    subplot(n,1,k);
    plot(1:N, sV(k,:), '-', 1:N, xV(k,:), '--')
end
