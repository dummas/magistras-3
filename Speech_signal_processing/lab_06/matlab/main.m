clear all;
close all;
clc;

%% Failas su graso irasu turi buti ivedamas standartinio failo pasirinkimo
% dialogo pagalba

[Y, FS] = audioread('a_galeti.wav');
Y = Y(:,1);

% smaller for debugging
%Y = Y(1:200);

T = 1/FS;

X = linspace(0, T*(length(Y)-1), length(Y)) * 1000;

%% Glaudinimo funkcija, pasirinkus garso faila, turetu buti grazinti 
% suglaudinto signalo duomenis (reiksmes). Isskleidimo funkcija, gavusi
% glaudinto signalo duomenis, turetu grazinti iskleistojo akustinio signalo
% reiksmes

sc = find(diff(Y>=0));

pp = [];

for j=2:length(sc)
    Ya = Y(sc(j-1):sc(j));
    Xa = X(sc(j-1):sc(j));
    Aa = max(Ya);
    if abs(min(Ya)) > Aa
        Aa = min(Ya);
    end
    Na = length(Ya);
    Xa_min = min(Xa);
    Xa_max = max(Xa);
    
    pp = [pp; Aa, Na];
end

Yr = [];

for k=1:length(pp)
    Ar = pp(k, 1);
    Nr = pp(k, 2);
   
    Xr = linspace(0, pi, pp(k,2)+1);
    Xr = Xr(2:end);
    
    Yr =[Yr Ar*sin(Xr)];
end



%% Signalas glaudinamas sinusoidemis. Algoritmai igyvendinami remiantis 
% individualiais sprendimais

%% Pagrindinis koderio vertinimo kriterijus -- suspaudimo laispsnis. Jis
% isreiskiamas pradinio ir suglaudinto garsu duomenu apimciu santykiu.

pp_c = size(pp,1)*size(pp,2);
Y_c = length(Y);
disp(['Santykis: ', num2str(Y_c/pp_c)]);


%% Taip atsizvelgiama i glaudinimo kokybe. Sprendimas apie kokybe priimamas 
% remiantis santykiu signalas-triuksamas (SST)

length(Y)
length(Yr)
% Normalize
if (length(Yr) > length(Y))
    Yr = Yr(1:length(Y));
else
    Y = Y(1:length(Yr));
end

SST = log(sum(Y.^2)/sum((Y-Yr').^2));


%% Grafiskai pateikti pradinio ir isskleistojo signalo versijas (vienoje
% plokstumoje), glaudinimo klaidos signala. Patekti SST reiksme.

figure;
subplot(2,1,1);
plot(Y);
title('Originalus signalas');

subplot(2,1,2);
plot(Yr);
title('Glaudintas signalas');

disp(['SST: ', num2str(SST)]);
