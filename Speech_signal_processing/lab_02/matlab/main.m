% Sukurti matlab funkcija, pateikiancia signalo laiko ir energijos
% diagramas, sinalo atkarpos ir autokoreliacijos laiko diagramas, ju
% pagalba nustatyti kalbos signalo pagrindinio tono dazni

close all;
clear all;
clc;

%% Pateikti kalbos signalo diagrama. Failas su garso irasu turi buti 
% ivedamas standartinio failo pasirinkimo dialogo pagalba


% Read audio file
[filename, pathname, filterindex] = uigetfile('*.wav', '');

% Y -- sampled data
% FS -- sample rate, in Hertz
[Y, FS] = audioread(filename);
Y = Y(:,1);

T = 1/FS;

X = linspace(0, T*(length(Y)-1), length(Y)) * 1000;

figure;

subplot(2,2,1);
plot(X, Y);
title('Audio signalas');

%% Pateikti signalo energijos diagrama. Energija skiaciuokite signala 
% nagrinedami persidengusiais kadrais. Kadro ilgis 15-25 ms, kadru
% persidengimas lygus mazdaug pusei daro ilgio

% Kardo ilgis -- 20 ms
YBufferLength = 20 / T / 1000;

YBuffer = buffer(Y, YBufferLength, YBufferLength / 2);

YPower = sum(abs(YBuffer).^2);

subplot(2,2,3);
plot(YPower);
title('Energijos diagrama');

%%  Pateikti signalo atkarpos diagrama. Atkarpos pradzia ir pabaiga ms 
% nurodo naudotojas (analizei pasirinkite 15-25ms atkarpa)

Xfrom = 100; % ns
%Xfrom = input('Pradzia: ');
Xto = 110; % 1s
%Xto = input('Babaiga: ');

xfrom = Xfrom * FS / 1000;
xto = Xto * FS / 1000;

Y = Y(xfrom:xto);
X = linspace(0, T*(length(Y)-1), length(Y)) / 1000;

subplot(2,2,2);
plot(X, Y);
title('Signalo atkarpa');

%% Apskaiciuoki ir patiekti signalo atkarpos autokoreliacijos funkcijos
% laiko diagrama (normuoti autokoreliacijos funkcijos reikmes)

[acor, lag] = xcorr(Y/max(Y));

subplot(2,2,4);
plot(lag,acor);
title('Koreliacija');

%% Apskaicuoti ir pateikti kalbos signalo pagrindinio tono dazni. 
% Remdamiesi gretimomis  autokoreliacijos funkcijos maksimumu reiksmemis 
% apskaicuokite pagrindinio tono dazni

halfacor = acor((length(acor)-1)/2:length(acor));

[peaks, location] = findpeaks(halfacor);

deltaT = location(peaks==max(peaks(peaks<max(peaks)))) * T;

F0 = 1/deltaT;

disp(['Pagrindinis tono daznis ', num2str(F0)]);


