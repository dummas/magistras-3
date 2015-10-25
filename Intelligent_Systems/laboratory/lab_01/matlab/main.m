%
% Nenaudodami MATLAB specializuot? funkcij? (newp, train, sim), sukurkite 
% perceptron?-klasifikatori? ir j? apmokykite obuoli? ir kriau?i? 
% nuotraukoms klasifikuoti. Po?ymiams (spalvai ir formai) i? nuotrauk? 
% i?skirti naudokite ?ias funkcijas. Perceptrono apmokymui pasirinkite 5 
% nuotraukas: 2 su kriau??mis ir 3 su obuoliais. Apmokytas perceptronui 
% patikrinti, naudokite likusias (nenaudotas apmokymo metu) obuoli? ir 
% kriau?i? nuotraukas.
%

train = {
    'pear_01.jpg'
    'pear_02.jpg'
    'apple_04.jpg'
    'apple_07.jpg'
    'apple_11.jpg'
};

T = [1, 1, -1, -1, -1];

check = {
    'pear_03.jpg'
    'pear_09.jpg'
    'apple_05.jpg' 
    'apple_06.jpg'
    'apple_12.jpg'
    'apple_13.jpg'
    'apple_17.jpg'
    'apple_19.jpg'
};

D = [1, 1, -1, -1, -1, -1, -1, -1];

threadshot = 0.2;
mu = 0.01;

X = [];

%% Feature

for i=1:size(train, 1)
    I = imread(['img/' train{i} ]);
    X = [X; color_feature(I), shape_feature(I, threadshot)];
end

%% Figure
% figure('Name', 'Savybiu erdve');
% for i=1:2
%     hold on;
%     plot(X(i, 1), X(i, 2), 'gx');
%     hold off;
% end
% 
% for i=3:5
%     hold on;
%     plot(X(i, 1), X(i, 2), 'ro');
%     hold off;
% end

%% Initialization

w_1 = 0.6;
w_2 = 0.3;
b = 0.5;
[w_1, w_2, b]

%  0.0605    0.3993    0.5269

%% Error
Err_sum = 1;
while Err_sum ~= 0
    Y = [];
    for i=1:size(X, 1)
        x_1 = X(i,1);
        x_2 = X(i,2);
        Y = [Y, sign(x_1 * w_1 + x_2 * w_2 + b)];
    end
   
    Err_sum = sum(Y-T);
    
    w_1 = w_1 - mu * Err_sum * sum(X(:,1));
    w_2 = w_2 - mu * Err_sum * sum(X(:,2));
    b = b - mu * Err_sum;
    
    [Err_sum, w_1, w_2, b]
end


%% Result

% number_of_values = 20;
% 
% P3 = linspace(0,1.4,number_of_values);
% 
% for i=1:number_of_values
%     clear j;
%     for j=1:number_of_values
%         P4 = [P3(i);P3(j)];
%         hold on;
%         if sign(P3(i) * w_1 + P3(j) * w_2 + b) == -1
%             plot(P4(1), P4(2), 'ro');
%         else
%             plot(P4(1), P4(2), 'gx');
%         end
%         hold off;
%     end
% end
grid on
line([0,1], [-b/w_2, -w_1/w_2 - b/w_2]);

%% Check
X = [];
for i=1:size(check, 1)
    I = imread(['img/' check{i} ]);
    X = [X; color_feature(I), shape_feature(I, threadshot)];
end

for i=1:2
    hold on;
    plot(X(i, 1), X(i, 2), 'gx');
    hold off;
end

for i=3:8
    hold on;
    plot(X(i, 1), X(i, 2), 'ro');
    hold off;
end

Y = [];
for i=1:size(X, 1)
    x_1 = X(i,1);
    x_2 = X(i,2);
    Y = [Y, sign(x_1 * w_1 + x_2 * w_2 + b)];
end

Err_sum = sum(Y-D);






