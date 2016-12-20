%         filter                 filter
% s(n) -> h^-1(n) -> v(n) -> z -> h(n) -> s~(n)
%  |         |                     |
%  --> lpc -------------------------
%
% e(n) = s(n) - s~(n)


% filteras -- filter(B, A, s)
% inversinis filtras -- filter(B, A, s)

clear all;
close all;
clc;

%% Garso iraso failas ivedamas standartinio failo pasirinkimo dialogo 
% pagalba

% Read audio file
[filename, pathname, filterindex] = uigetfile('*.wav', '');

% Y -- sampled data
% FS -- sample rate, in Hertz
[Y, FS] = audioread(filename);
Y = Y(:,1);

T = 1/FS;

X = linspace(0, T*(length(Y)-1), length(Y)) * 1000;

%% analizei pasirenkame 15-25 ms signalo atkarpa. Nagrinejamos atkarpos 
% pradzia ir pabaiga milisekundemis nurodo naudotojas

Xfrom = 250; % ms
Xto = 300; % ms

xfrom = Xfrom * FS / 1000;
xto = Xto * FS / 1000;

Y = Y(xfrom:xto);
X = linspace(0, T*(length(Y)-1), length(Y)) / 1000;

%% Siekant gauti stabilius modelio parametrus, nagrinejamasis signalas 
% turetu buti apdorotas aukstu dazniu filtru (ADF). Siame darbe panaudokite
% I eiles ADF:
%
% x(n) = x(n) - 0.95*x(n-1)

A = 1;
B = [1 -0.95];

freqz(B,A);

Yf = filter(B, A, Y);

figure;
plot(Y, 'b'),
hold on;
plot(Yf, 'r');
hold off;

%% Gaunami signalo tiesines prognozes modelio (TPM) parametru iverciai 
% (pradziai reiketu taikyti bent 100-osios eiles modeli). Panaudojus
% gautuosius parametrus ?vertinamas suzadinimo signalas

% Order
N = 3;

a = lpc(Yf, N);

% suzadinimo signalas
V = filter(a, 1, Yf);

%% Suzadinimo signalas aproksimuojamas (zemiau pateikta keletas 
% aproksimavimo pavyzdiu) ir panaudojus TPM parametrus sugeneruojamas
% (sintezuojamas) snekos signalas (signalo prognoze). Nustatoma prognozes
% klaida.

V2 = V;
V2(1:10:end) = 0;

B = a;

Y2 = filter(1, a, V2);

E = Yf-Y2;


%% Grafiskai pateikiama
% - Pasirinktosios signalo atkarpos ir jos prognozes diagramos
% - Nustatytojo suzadinimo signalo ir jo aproksimacijos diagramos
% - Suzadinimo signalo ir snekos signalo prognozes klaidu diagramos

figure;
subplot(3,2,1);
plot(X, Yf);
title('Signalo atkarpa');

subplot(3,2,2);
plot(X,V);
title('Saltinis');

subplot(3,2,3);
plot(X,Y2);
title('Signalo prognoze');

subplot(3,2,4);
plot(X,V2);
title('Aproksimuotas saltinis');

subplot(3,2,5);
plot(X,E);
title('Prognozes klaida');

subplot(3,2,6);
plot(X,V-V2);
title('Saltiniu skirtumas');


%% Diagramu abscisiu asys turetu buti isreikstos milisekundemis, visu
% diagramo orginaciu asiu masteliai -- vienodi

%% Modeliavimui parinkti ivarius garsus -- vokalizuotus, nevokalizuotus, 
% fono triuksma, modelyje panaudoti ivairias suzadinimo signalo
% aproksimacijas, varijuoti modelio eile