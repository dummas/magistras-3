% Nenaudodami MATLAB specializuotu funkciju (newrb, train ir pan.) 
% sukurkite spindulio tipo baziniu funkciju tinkla, kurio mokymui 
% parasykite funkciju patys. Neuronu tinklas galetu, pavyzdziui, 
% interpoliuoti nesudetinga dvimate funkcija.


%% MLP

%      w1_1 -- [ y1_1 ] -- w2_1
%    /                           \
%  X - w1_2 -- [ y1_2 ] -- w2_2 -- [ y2 ] Y
%    \                           /
%      w1_3 -- [ y1_3 ] -- w2_3
%


close all;
clear;
clc;

%% Model

to = 2 * 3.14;

number_of_values = 30;
X = linspace(0,to,number_of_values);
Y = abs(sin(X));


%% Initialization

mu = 0.1;
number_of_centers = 2;
sample_per = to / (number_of_centers + 1);
r = 1.3;

%w_1 = rand; % 1.2549
w_1 = 1.2549;
c_1 = max(X)/4;
r_1 = r;

%w_2 = rand; % 1.2321
w_2 = 1.2321;
c_2 = max(X)/4*3;
r_2 = r;

w_0 = -0.2372; % -0.2372
%w_0 = rand;


%% Training
% figure;
% grid on;
% plot(X, Y);
% hold on;

Err = [];
Err_1 = [];
Err_2 = [];
Err_sum = 1;
%while Err_sum ~= 0
for k=1:500
    Y2 = [];
    for j=1:size(X, 2)
        % y = 
        y_1 = w_1 * exp(-abs(X(j) - c_1)^2/r_1^2);
        y_2 = w_2 * exp(-abs(X(j) - c_2)^2/r_2^2);
        Y2 = [Y2 sum(y_1 + y_2) + w_0];
    end
   
    Err_sum = sum(Y2 - Y);
    
    w_1 = w_1 + mu * Err_sum;
    w_2 = w_2 + mu * Err_sum;
    
    w_0 = w_0 - mu * Err_sum;
    
    Err = [Err, Err_sum];
   
end

figure('Name', 'error');
plot(Err);


%% Result

figure('Name', 'Result');
grid on;
plot(X, Y, 'r');
hold on;

Y2 = [];
Y2_1 = [];
Y2_2 = [];

X2 = linspace(0,to,number_of_values*2);

for j=1:size(X2, 2)
    y_1 = w_1 * exp(-abs(X2(j) - c_1)^2/r_1^2);
    y_2 = w_2 * exp(-abs(X2(j) - c_2)^2/r_2^2);
    Y2_1 = [Y2_1 y_1];
    Y2_2 = [Y2_2 y_2];
    Y2 = [Y2 sum(y_1 + y_2) + w_0];
end

plot(X2, Y2, 'b');
plot(X2, Y2_1, 'g');
plot(X2, Y2_2, 'g');


hold off;