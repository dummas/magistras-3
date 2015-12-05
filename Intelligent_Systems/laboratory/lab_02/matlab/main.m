% Nenaudodami MATLAB specializuot? funkcij? (newff, train, sim ir pan.), 
% sukurkite daugiasluoksn? (dviej? sluoksni?) perceptron? tinkl? ir j? 
% apmokykite pasirinktai kreivei (sudarytai i? 20 atskait?) aproksimuoti. 
% Tinklo apmokymui ?gyvendinkite Backpropagation algoritm?. Aktyvavimo 
% funkcijas neuron? tinkle pasirinkite savo nuo?i?ra. Kreiv? galite 
% sukurti, pavyzd?iui, naudodami kelias trigonometrines funkcijas.

close all;
clear;
clc;


%% Model
number_of_values = 20;
X = linspace(0,10,number_of_values);
Y = sin(X/6);

%% MLP

%      w1_1 -- [ y1_1 ] -- w2_1
%    /                           \
%  X - w1_2 -- [ y1_2 ] -- w2_2 -- [ y2 ] Y
%    \                           /
%      w1_3 -- [ y1_3 ] -- w2_3
%
%
%  y^(2) = v
%  y^(1)_N = 1/(1+e^(-a * v))
%  gamma'(v(n)) = ay(n)(1-y(n))
%

%% Initialization

% First layer
w1_1 = rand;
w1_2 = rand;
w1_3 = rand;
b1_1 = rand;
b1_2 = rand;
b1_3 = rand;

% Second layer
w2_1 = rand;
w2_2 = rand;
w2_3 = rand;
b2 = rand;

%% Training

mu = 0.01;
figure('Name', 'Training')
plot(X, Y, 'g');
grid on;

for k=1:100
    
    Y2 = [];

    for i=1:length(X)
        x = X(i);
        v1_1 = w1_1 * x + b1_1;
        v1_2 = w1_2 * x + b1_2;
        v1_3 = w1_3 * x + b1_3;

        y1_1 = 1/(1+exp(-v1_1));
        y1_2 = 1/(1+exp(-v1_2));
        y1_3 = 1/(1+exp(-v1_3));

        y2 = y1_1 * w2_1 + y1_2 * w2_2 + y1_3 * w2_3 + b2;
        
        Y2 = [Y2, y2];

        % Momentine klaida
        e2 = y2 - Y(i);

        w2_1 = w2_1 - mu * (e2*y2*w2_1) * y1_1;
        w2_2 = w2_2 - mu * (e2*y2*w2_2) * y1_2;
        w2_3 = w2_3 - mu * (e2*y2*w2_3) * y1_3;
        b2 = b2 - mu * e2;

        e1_1 = y1_1 - y2;
        e1_2 = y1_2 - y2;
        e1_3 = y1_3 - y2;
        
        fe1 = (e2*y2*w2_1 + e2*y2*w2_2 + e2*y2*w2_3);

        fe1_1 = y1_1 * (1-y1_1) * fe1;
        fe1_2 = y1_2 * (1-y1_2) * fe1;
        fe1_3 = y1_3 * (1-y1_3) * fe1;

        w1_1 = w1_1 - mu * (fe1_1 * e1_1 * w1_1) * x;
        w1_2 = w1_2 - mu * (fe1_2 * e1_2 * w1_2) * x;
        w1_3 = w1_3 - mu * (fe1_3 * e1_3 * w1_3) * x;

        b1_1 = b1_1 - mu * e1_1;
        b1_2 = b1_2 - mu * e1_2;
        b1_3 = b1_3 - mu * e1_3;

    end
    
%     hold on;
%     plot(X, Y, 'g');
%     plot(X, Y2, 'r-');
%     hold off;

end

%% Validation
Y2 = [];
for i=1:length(X)
    x = X(i);
    v1_1 = w1_1 * x + b1_1;
    v1_2 = w1_2 * x + b1_2;
    v1_3 = w1_3 * x + b1_3;

    y1_1 = 1/(1+exp(-v1_1));
    y1_2 = 1/(1+exp(-v1_2));
    y1_3 = 1/(1+exp(-v1_3));

    y2 = y1_1 * w2_1 + y1_2 * w2_2 + y1_3 * w2_3 + b2;
    Y2 = [Y2, y2];
end


hold on;
plot(X, Y, 'g');
plot(X, Y2, 'r-');
hold off;


