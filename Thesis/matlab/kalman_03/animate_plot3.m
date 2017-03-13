function animate_plot3(x, y, z)

figure;

x_min = min(x);
x_max = max(x);
y_min = min(y);
y_max = max(y);
z_min = min(z);
z_max = max(z);


for t=1:length(x);
    plot3(x(1:t), y(1:t), z(1:t));
    grid on;
    axis([x_min x_max y_min y_max z_min z_max]);
    pause(0.05);
end