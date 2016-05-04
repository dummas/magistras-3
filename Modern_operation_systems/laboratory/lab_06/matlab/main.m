% Parasyti skripta, kuris iliustrcuoja CPI darbo planavimo principa pagal
% "pirmas atejo -- pirmas aptarnautas"
% Skripte gali buti padaryta prielaida, kad visi procesasi atsiranda
% nuliniu laiko momentu, bet tam tikra tvarka, is eiles P_1, P_2, .., P_n

% Skripte turi buti numatyta galimybe keisti procesu skaiciu ir ju CPI
% operaciju paketu trukme

% Skripte turi buti apskaiciuojama:
% * Kiekvieno proceso laukimo trukme
% * Vidutine laukimo trukme
% * Kiekvieno proceso apyvartos trukme
% * vidutine apyvartos trukme

NUMBER_OF_PROCESSES = 10;

% P yra procesu vektorius, kur vektoriaus verte apibudina proceso operaciju
% paketu trukme, milisekundemis
P = rand(1, NUMBER_OF_PROCESSES);

% Kiekvieno proceso laukimo trukme
P_w = zeros(1, NUMBER_OF_PROCESSES);

for k=2:length(P)
    P_w(k) = P_w(k-1) + P(k - 1);
end

P_w_avg = sum(P_w)/length(P_w);
P_avg = sum(P)/length(P);

disp('Kiekvieno proceso laukimo trukme');
disp(P_w);
disp(['Vidutine laukimo trukme: ', num2str(P_w_avg)]);
disp('Kiekvieno proceso apyvartos trukme');
disp(P);
disp(['Vidutine apyvartos trukme: ', num2str(P_avg)]);