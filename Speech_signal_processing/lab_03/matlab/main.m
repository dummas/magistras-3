% Sukurti matlab funkcija, pateikiancia signalo laiko ir energijos
% diagramas, sinalo atkarpos ir autokoreliacijos laiko diagramas, ju
% pagalba nustatyti kalbos signalo pagrindinio tono dazni

close all;
clear all;
clc;

%% Pateikti signalo diagrama. Failas su garso irasu turi buti ivedamas 
% standartinio failo pasirinkimo dialogo pagalba

% Read audio file
[filename, pathname, filterindex] = uigetfile('*.wav', '');

% Y -- sampled data
% FS -- sample rate, in Hertz
[Y, FS] = audioread(filename);
Y = Y(:,1);

T = 1/FS;

X = linspace(0, T*(length(Y)-1), length(Y)) * 1000;

figure;

plot(X, Y);
title('Audio signalas');

%% Patiekti signalo atkarpos laiko diagrama. Atkartpos pradzia ir pabaiga
% milisekundemis nurodo naudotas (analizei pasirinkite 10-30 ms signalo
% atkarpas)

Xfrom = 200; % ns
%Xfrom = input('Pradzia: ');
Xto = 300; % 1s
%Xto = input('Babaiga: ');

xfrom = Xfrom * FS / 1000;
xto = Xto * FS / 1000;

Y = Y(xfrom:xto);
X = linspace(0, T*(length(Y)-1), length(Y)) / 1000;

figure;
plot(X, Y);
title('Signalo atkarpa');

%% Apskaiciuoti ir pateikti pasirinktos atkarpos spektro diagrama.
% Diagramos abscisiu aci isreikskite hercais

Yf = fft(Y);
L = length(Y);
P2 = abs(Yf/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = FS *(0:(L/2))/L;

figure;
plot(f,P1);
title('Spektro diagrama');
xlabel('f (Hz)');

%% Apskaiciuoti ir pateikti pairinktos atkarpos kepstro diagrama.
% Diagramos absciiu aci isreiskite milisekundemis

Yf = fft(Y);
L = length(Y);
P2 = abs(Yf/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

K1 = abs(ifft(log(abs(P2).^2)));

figure;
plot(X*10000, K1);
title('Kepstro diagrama');
xlabel('t, ms');


%% Apskaiciuoti ir pateikti kalbos signalo pagrindinio tono dazni. 
% Realizuokite pagrindinio tono daznio automatinio nustatymo is krepstro
% reiksmiu galimybe
% Stebejimui pasirinkite ivairius garsus -- vokalizuotus, nevokalizuotus,
% fono triuksma. Gautus pagrindinio tono daznio rezultatus palyginkite su
% autokoreliaciniu metodu gautaisiais rezultatais

[peaks, location] = findpeaks(K1);
deltaT = location(peaks==max(peaks(peaks<max(peaks)))) * T;

F0 = 1/deltaT;
disp(['Pagrindinis tono daznis ', num2str(F0)]);

%% Nustatytkite pagrindinio tono daznio reiksmiu priklausomybe nuo 
% analizuojamos atkarpos ilgio. Vertinimui panaudokite po du dvieju
% kalbetoju (vyro ir moters) istarimus, nagrinekite 15-30 ms atkarpas
% (atkarpos ilgio didinimo zingsnis -- 3ms, atkarpos pradzios laika
% objektyvuo delei fiksuokite). Priklausomybe lenteles ir grafiko
% pavidalais pateikite darbo ataskaitoje


