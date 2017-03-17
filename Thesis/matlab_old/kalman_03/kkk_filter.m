function [Px, Py, Pz] = kkk_filter(N, dT, Ax, Ay, Az)


F = [
   1 0 0 dT 0 0 dT^2/2 0 0;
   0 1 0 0 dT 0 0 dT^2/2 0;
   0 0 1 0 0 dT 0 0 dT^2/2;
   0 0 0 1 0 0 dT 0 0;
   0 0 0 0 1 0 0 dT 0;
   0 0 0 0 0 1 0 0 dT;
   0 0 0 0 0 0 1 0 0;
   0 0 0 0 0 0 0 1 0;
   0 0 0 0 0 0 0 0 1;
]; 

H = [
   1 0 0 0 0 0;
   0 1 0 0 0 0;
   0 0 1 0 0 0;
];

Q = 0.01;
R = 0.01;

x_h(:,1) = zeros(1,6);
P(:,1) = [Q, Q, Q, Q, Q, Q, Q, Q, Q];

% Initial Kalman gain
K(:,1) = P(:,1) * H * (H*P(:,1)*H+R)';

for t=1:N
    A = [Ax(t) Ay(t) Az(t)];
    
    x_h(:,t) = x_h(:,t) + K(:,t) * (A - H*x_h(:,t));
    P(:,t) = P(:,t) - K(:,t) * H * P(:,t);
    K(:,t+1) = P(:,t) * H * (H*P(:,t) * H +R)';
    
    % prediction step
    x_h(:,t+1) = F*x_h(:,t);
    P(:,t+1) = F*P(:,t) + Q;
end

Px = x_h(:,1);
Py = x_h(:,2);
Pz = x_h(:,3);


end