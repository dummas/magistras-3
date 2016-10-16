%function main
    close all;
    clear all;
    clc;


    % Read audio file
    [filename, pathname, filterindex] = uigetfile('*.wav', '');

    % Y -- sampled data
    % FS -- sample rate, in Hertz
    [Y, FS] = audioread(filename);

    T = 1/FS;

    X = linspace(0, T*(length(Y)-1), length(Y)) * 1000;

    %% 2 
    figure;
    hold on;
    grid on;
    subplot(2,1,1);
    plot(X, Y);
    xlabel('ms');
    hold off;

    %% 3
    info = audioinfo(filename);

    disp(['Diskretizacijos daznis: ', num2str(info.SampleRate), ' Hz']);
    disp(['Kanalu skaicius: ', num2str(info.NumChannels)]);
    disp(['Kvantavimo bitu skaicius: ', num2str(info.BitsPerSample)]);

    %% 4

    Xfrom = input('Pradzia: ');
    Xto = input('Babaiga: ');
    
    xfrom = Xfrom * FS / 1000;
    xto = Xto * FS / 1000;

    Y = Y(xfrom:xto);
    X = linspace(0, T*(length(Y)-1), length(Y)) / 1000;

    subplot(2,1,2);
    plot(X,Y);
    xlabel('ms');

    %% 5
    [filename, pathname, filterinted] = uiputfile('*.wav', 'Issaugoti');

    if filename == 0 
        error('Do not save file');
    end

    audiowrite(filename, Y, FS);

%end
