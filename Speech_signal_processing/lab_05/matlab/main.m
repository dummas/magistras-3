clear all;
close all;
clc;

%% Failas su garso irasu turi buti ivedamas standartinio failo pasirinkimo
% dialogo pagalba

% Read audio file
%[filename, pathname, filterindex] = uigetfile('*.wav', '');

% Y -- sampled data
% FS -- sample rate, in Hertz
[Y, FS] = audioread('M002_001.wav');
Y = Y(:,1);

T = 1/FS;

X = linspace(0, T*(length(Y)-1), length(Y)) * 1000;

figure;

plot(X,Y);
title('Originalus signalas');

%% Fono triuksmo atkarpos (reikalingos fono triuksmo amplitudes spektro
% iverciui gauti) pradia ir pabaiga milisekundemis nurodo naudotojas

Xfrom = 100; % ms
Xto = 300; % ms

xfrom = round(Xfrom * FS / 1000);
xto = round(Xto * FS / 1000);

Y2 = Y(xfrom:xto);
X2 = linspace(0, T*(length(Y2)-1), length(Y2)) / 1000;

figure;

plot(X2,Y2);
title('Triuksmo signalas');

%% Signalas nagrinejamas fiksuotais 20ms trukmes nepersidengianciais
% kadrais. Pries skaiciuojant DFT, signalo atkarpai reiketu pritaikyti
% lango funkcija

dT = 20; % ms
dN = round(dT * FS / 1000);

Yb = buffer(Y, dN);
Y2b = buffer(Y2, dN);

for j=1:size(Y2b,2)
    % pritaikom lango funkcija
    Y2b(:,j) = Y2b(:,j).*hann(dN);
end

% apply fft ir vidurkinam
Y2bf = mean(abs(fft(Y2b)), 2);

%% Savarankiskai parinkti (ir argumentuoti) papildomo apdorojimo schema


%Ybf = real(fft(Yb));
Ybf = abs(fft(Yb));
Ybp = atan(imag(fft(Yb))/real(fft(Yb)));

alpha = 1;

for j=1:size(Ybf, 2)
    % minus spectrum
    Ybf(:,j) = Ybf(:,j) - alpha*Y2bf;
    Ybf(:,j) = Ybf(:,j).*exp(Ybp(:,j));
end

% PADP
% for j=1:size(Ybf, 2)
%     % minus spectrum
%     if (Ybf(:,j) <= alpha*Y2bf)
%         Ybf(:,j) = alpha*Y2bf;
%     end
% end

% reverse fft

Ybfr = real(ifft(Ybf));

Yr = reshape(Ybfr, [], 1);
Xr = linspace(0, T*(length(Yr)-1), length(Yr)) * 1000;

figure;

subplot(2,1,1);
plot(X,Y);
title('Originalus signalas');
xlabel('t, ms');

subplot(2,1,2);
plot(Xr, Yr);
title('Filtruotas signalas');
xlabel('t, ms');


%% Grafiskai pateikti pradinio signalo ir isvalytojo laiko diagramas.
% Laiko asi isreiksti milisekundemis

%% Sudarykite signalu perklausos galimybe

sound(Y, FS);
pause(length(Y)/FS*2);

sound(Yr, FS);
pause(length(Y)/FS);