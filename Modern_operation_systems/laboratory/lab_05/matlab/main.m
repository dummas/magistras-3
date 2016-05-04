close all;
clc;

% Trys resursu klases
m = 3; % p
% Penki procesai
n = 5; % r

% Vektorius, apibudinantis esamus resursus
%RESOURCES = [10, 5 ,7]; % STABLE
RESOURCES = [7, 5 ,7]; % NOT STABLE
% Matrica, apibudinanti didziausia poreiki kiekvienam resursui
MAX = [
    [7, 5, 3]
    [3, 2, 2]
    [9, 0, 2]
    [2, 2, 2]
    [4, 3, 3]
];
% Matrica apibudinanti skaiciu resursu, kiekvieno klases duotu momentu
% skirtu kiekvienam procesui. [i,j] = k, P_i procesui duotu momentu skirta
% k elementu R_j resurso klases
% ALLOCATION = zeros(n, m);
ALLOCATION = [
    [0, 1, 0]
    [2, 1, 0]
    [3, 0, 2]
    [2, 1, 1]
    [0, 0, 2]
];

% i-tasis elementas zymes i-tojo proceso baigties fakta
FINNISH = zeros(1, n);
% Matrica apibudinani kiekvieno proceso likusius poreikius resursams. Jeigu
% [i, j] = k, reiskia P_i procesui savo uzduociai atlikti gali prireikti
% iki k elementu R_j resurso klases
% NEED[i,j] = MAX[i,j] - ALLOCATION[i,j]
NEED = MAX - ALLOCATION;

WORK = RESOURCES - sum(ALLOCATION);

for j=1:size(RESOURCES, 2)
    k = 1;
    for k=1:size(NEED, 1)
        if FINNISH(k) == false && all(WORK >= NEED(k,:))
            disp(['ENOUGHT for ', num2str(k)]);
            FINNISH(k) = 1;
            WORK = WORK + ALLOCATION(k,:);
        end
    end
end

if all(FINNISH)
    disp('System is safe')
else
    disp('System is not safe')
end