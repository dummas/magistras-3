close all;
clear all;
clc;

% Konstruojam signala
Fs = 1000; % samplingas
T = 0.1; % signalo periodas
N = 1000; % tasku skaicius

Tn1 = T/4;
t = 0:T/(N-1):T; % laiko asis

S = [ones(1,N/4), -1*ones(1,N/4), ones(1,N/4), -1*ones(1,N/4)]; % signalas

% Spectras 

Y = fft(S);
f = 0:N-1;
%figure('name', 'Amplitudes spectras');
%plot(f, abs(Y/N));
%figure('name', 'Fazes spectras');
%plot(f, angle(Y/N));

% Low pass filter
fn = 10; % cut off freq
[B,A] = butter(5, fn/N, 'low');
[h,w] = freqz(A,B,N);
[phi, w] = phasez(A,B,N);

S1 = filter(B, A, S);

Y1 = fft(S1);

figure('name', 'Signalas prie is po');
subplot(2,1,1);
plot(t, S, 'r');
subplot(2,1,2);
plot(t, S1, 'g');


figure('name', 'Amplitudes spectras pries ir po');
subplot(3,1,1);
plot(f, abs(Y), 'r');
subplot(3,1,2);
plot(f, abs(Y1), 'g');
subplot(3,1,3);
plot([-w/pi w/pi], 20*log10(abs(h)))

figure('name', 'Fazes spectras pries ir po');
subplot(3,1,1);
plot(f, angle(Y), 'r');
subplot(3,1,2);
plot(f, angle(Y1), 'g');
subplot(3,1,3);
plot([-w/pi w/pi], 20*log10(abs(phi)));
