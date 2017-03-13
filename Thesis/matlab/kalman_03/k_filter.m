function Px = k_filter(N, dT, A)

    F = [
        1 dT dT^2/2;
        0 1 dT;
        0 0 1
    ];
    H = [1 1 0];
    x0 = [0;0;0];
    sigma_a = 0.005;
    Q = sigma_a^2;
    R = 0.01;

    x_h(:,1) = x0;
    P(:,1) = [Q;Q;Q];

    % initial Kalman gain
    K(:,1) = P(:,1)*H*(H*P(:,1)*H+R)';

    for t=1:N
        % update step
        x_h(:,t) = x_h(:,t) + K(:,t) * (A(t) - H*x_h(:,t));
        P(:,t) = P(:,t) - K(:,t) * H * P(:,t);
        K(:,t+1) = P(:,t) * H * (H*P(:,t)*H+R)';

        % prediction step
        x_h(:,t+1) = F*x_h(:,t);
        P(:,t+1) = F*P(:,t) + Q;
    end

    % Filtered position
    Px = x_h(1,:);