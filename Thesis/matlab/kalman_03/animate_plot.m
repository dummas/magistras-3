function animate_plot(x, y)

figure;

x_min = min([x, y]);
x_max = max([x, y]);


for t=1:length(x);
    plot(x(1:t), y(1:t));
    grid on;
    axis([x_min x_max x_min x_max]);
    pause(0.05);
end