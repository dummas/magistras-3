%
%
%     ---
%    /
% x1 \ 
%     ---
%
%

close all;
clc;

x = rand(1,40);

x1 = x(1:20);
x2 = x(21:40);

xt1 = [0.5*x1(1:5) 0.5*x1(6:10)+0.5];
xt2 = [0.5*x2(1:5) 0.5*x2(6:10)+0.5];

xc1 = [0.5*x1(11:15) 0.5*x1(16:20)+0.5];
xc2 = [0.5*x2(11:15) 0.5*x2(16:20)+0.5];

% Pirmi penki -- label1
% Antri penki -- label2
Xt = [xt1; xt2];
Xc = [xc1; xc2];

c_1 = mean(Xt(:,1:5)');
r_1 = 0.25;
w_1_1 = rand;
w_1_2 = rand;
w_2_1 = rand;
w_2_2 = rand;

c_2 = mean(Xt(:,6:10)');
r_2 = 0.25;
b_1 = rand;
b_2 = rand;

mu = 0.01;

T1 = [-1,-1,-1,-1,-1,1,1,1,1,1];
T2 = [1,1,1,1,1,-1,-1,-1,-1,-1];

ERR_1 = [];
ERR_2 = [];

for k = 1:100
    Y1 = [];
    Y2 = [];
    for j=1:10
        xt = Xt(:, j);
        y_1 = w_1_1 * exp(-abs(xt(1) - c_1(1))^2/r_1^2);
        y_2 = w_1_2 * exp(-abs(xt(2) - c_1(2))^2/r_1^2);
        Y1 = [Y1, sign(y_1 + y_2 + b_1)];
        
        y_1 = w_2_1 * exp(-abs(xt(1) - c_2(1))^2/r_2^2);
        y_2 = w_2_2 * exp(-abs(xt(2) - c_2(2))^2/r_2^2);
        Y2 = [Y2, sign(y_1 + y_2 + b_2)];
    end
    
    
    Err_1_sum = sum(Y1 - T1);
    Err_2_sum = sum(Y2 - T2);
    
    ERR_1 = [ERR_1 Err_1_sum];
    ERR_2 = [ERR_2 Err_2_sum];
    
    w_1_1 = w_1_1 - mu * Err_1_sum * sum(Xt(:,1));
    w_1_2 = w_1_2 - mu * Err_1_sum * sum(Xt(:,2));
    
    b_1 = b_1 - mu * Err_1_sum;
    
    w_2_1 = w_2_1 - mu * Err_2_sum * sum(Xt(:,1));
    w_2_2 = w_2_2 - mu * Err_2_sum * sum(Xt(:,2));
    
    b_2 = b_2 - mu * Err_2_sum;
end


figure;
hold on;
plot(xc1(1:5), xc2(1:5), 'g*');
plot(xc1(6:10), xc2(6:10), 'r*');
circle(c_1(1), c_1(2), r_1, 'g');
circle(c_2(1), c_2(2), r_2, 'r');
grid on
%line([0,1], [-b/w_2, -w_1/w_2 - b/w_2], 'Color', 'r');

hold on;
j = 0;
for j=1:length(Xc)
    xc = Xc(:, j);
    y_1 = w_1_1 * exp(-abs(xc(1) - c_1(1))^2/r_1^2);
    y_2 = w_1_2 * exp(-abs(xc(2) - c_1(2))^2/r_1^2);
    Y = sign(y_1 + y_2 + b_1);
    
    if Y == 1
        plot(xc(1), xc(1), 'g^');
    else
        plot(xc(1), xc(1), 'r^');
    end
end
hold off;

figure;

plot(ERR_1, 'g');
hold on;
plot(ERR_2, 'b');
hold off;
grid on;




