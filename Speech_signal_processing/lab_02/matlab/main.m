% Sukurti matlab funkcija, pateikiancia signalo laiko ir energijos
% diagramas, sinalo atkarpos ir autokoreliacijos laiko diagramas, ju
% pagalba nustatyti kalbos signalo pagrindinio tono dazni

%% Pateikti kalbos signalo diagrama. Failas su garso irasu turi buti 
% ivedamas standartinio failo pasirinkimo dialogo pagalba


% Read audio file
[filename, pathname, filterindex] = uigetfile('*.wav', '');

% Y -- sampled data
% FS -- sample rate, in Hertz
[Y, FS] = audioread(filename);

T = 1/FS;

X = linspace(0, T*(length(Y)-1), length(Y)) * 1000;

%% Pateikti signalo energijos diagrama. Energija skiaciuokite signala 
% nagrinedami persidengusiais kadrais. Kadro ilgis 15-25 ms, kadru
% persidengimas lygus mazdaug pusei daro ilgio

