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

number_of_values = 10;
X = linspace(0,1,number_of_values);
Y = sin(X*6);


%% Initialization

mu = 0.1;

r = 0.15;

number_of_centers = 1;

w_1 = rand;
c_1 = rand;

w_2 = rand;
c_2 = rand;

w_3 = rand;
c_3 = rand;

w_4 = rand;
c_4 = rand;

w_5 = rand;
c_5 = rand;

w_6 = rand;
c_6 = rand;

w_0 = rand;


%% Training
% figure;
% grid on;
% plot(X, Y);
% hold on;

Err = [];
Err_sum = 1;
% % % while Err_sum ~= 0
for k=1:200
    Y2 = [];
    for j=1:size(X, 2)
        y_1 = w_1 * exp(-abs(X(j) - c_1)^2/r^2);
        y_2 = w_2 * exp(-abs(X(j) - c_2)^2/r^2);
        y_3 = w_3 * exp(-abs(X(j) - c_3)^2/r^2);
        y_4 = w_4 * exp(-abs(X(j) - c_4)^2/r^2);
        y_5 = w_5 * exp(-abs(X(j) - c_5)^2/r^2);
        y_6 = w_6 * exp(-abs(X(j) - c_6)^2/r^2);
        Y2 = [Y2 sum(y_1 + y_2 + y_3 + y_4 + y_5 + y_6) + w_0];
    end
   
    Err_sum = sum(Y2-Y);
    
    w_1 = w_1 - mu * Err_sum * sum(Y);
    w_2 = w_2 - mu * Err_sum * sum(Y);
   
    w_0 = w_0 - mu * Err_sum;
%     r = r - mu * Err_sum;
    
    Err = [Err, Err_sum];
   
end

figure('Name', 'error');
plot(Err);


%% Result

figure;
grid on;
plot(X, Y, 'r');
hold on;

X2 = linspace(0,1,100);
Y2 = [];
for j=1:size(X2, 2)
    y_1 = w_1 * exp(-abs(X2(j) - c_1)^2/r^2);
    y_2 = w_2 * exp(-abs(X2(j) - c_2)^2/r^2);
    y_3 = w_3 * exp(-abs(X2(j) - c_3)^2/r^2);
    y_4 = w_4 * exp(-abs(X2(j) - c_4)^2/r^2);
    y_5 = w_5 * exp(-abs(X2(j) - c_5)^2/r^2);
    y_6 = w_6 * exp(-abs(X2(j) - c_6)^2/r^2);
    Y2 = [Y2 sum(y_1 + y_2 + y_3 + y_4 + y_5 + y_6) + w_0];
end

plot(X2, Y2, 'b');


hold off;