function show_data(data)
    % acceleration
    Ax = data(:,2);
    Ay = data(:,3);
    Az = data(:,4);
    % gyroscope
    Gx = data(:,5);
    Gy = data(:,6);
    Gz = data(:,7);

    %% Plot

    figure;
    plot(Ax, 'r');
    hold on;
    plot(Ay, 'b');
    plot(Az, 'g');
    grid on;
    hold off;
end