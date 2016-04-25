close all;
clear;
clc;

fileFormat = '%f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f';
columnsSize = [19 Inf];

coFiles = {
    'SiCo01_01.txt'
    'SiCo03_01.txt'
    'SiCo04_01.txt'
    'SiCo05_01.txt'
    'SiCo06_01.txt'
    'SiCo07_01.txt'
    'SiCo08_01.txt'
    'SiCo09_01.txt'
    'SiCo10_01.txt'
    'SiCo11_01.txt'
    'SiCo12_01.txt'
    'SiCo13_01.txt'
    'SiCo14_01.txt'
    'SiCo15_01.txt'
    'SiCo16_01.txt'
    'SiCo17_01.txt'
    'SiCo18_01.txt'
    'SiCo19_01.txt'
    'SiCo20_01.txt'
    'SiCo21_01.txt'
    'SiCo22_01.txt'
    'SiCo23_01.txt'
    'SiCo24_01.txt'
    'SiCo25_01.txt'
    'SiCo26_01.txt'
    'SiCo27_01.txt'
    'SiCo28_01.txt'
    'SiCo29_01.txt'
    'SiCo30_01.txt'
};

ptFiles = {
    'SiPt02_01.txt'
    'SiPt04_01.txt'
    'SiPt05_01.txt'
    'SiPt07_01.txt'
    'SiPt08_01.txt'
    'SiPt09_01.txt'
    'SiPt10_01.txt'
    'SiPt12_01.txt'
    'SiPt13_01.txt'
    'SiPt14_01.txt'
    'SiPt15_01.txt'
    'SiPt16_01.txt'
    'SiPt17_01.txt'
    'SiPt18_01.txt'
    'SiPt19_01.txt'
    'SiPt20_01.txt'
    'SiPt21_01.txt'
    'SiPt22_01.txt'
    'SiPt23_01.txt'
    'SiPt24_01.txt'
    'SiPt25_01.txt'
    'SiPt27_01.txt'
    'SiPt28_01.txt'
    'SiPt29_01.txt'
    'SiPt30_01.txt'
    'SiPt31_01.txt'
    'SiPt32_01.txt'
    'SiPt33_01.txt'
    'SiPt34_01.txt'
};

ptData = {};
coData = {};


ptX = [];
coX = [];

disp('Reading pt Files');

for j=1:length(ptFiles)
    
    fileId = fopen(['data/' ptFiles{j}], 'r');
    
    disp(ptFiles{j});
    
    data = fscanf(fileId, fileFormat, columnsSize);
    
    % We are interested only in the left foot
    ptData{j} = data(19,:)/max(data(19,:));
    
    % Feature Extraction
    featureA = min(var(split_data(ptData{j}(ptData{j}>=0.7), 100, 50)));
    featureB = var(var(split_data(ptData{j}, 100, 50)));
    featureC = max(var(split_data(ptData{j}(ptData{j}>=0.7), 100, 50)));
    
    featureD = min(std(split_data(ptData{j}(ptData{j}>=0.7), 100, 50)));
    featureE = std(std(split_data(ptData{j}, 100, 50)));
    featureF = max(std(split_data(ptData{j}(ptData{j}>=0.7), 100, 50)));
    
    % Sudarom feature vector
    ptX = [ptX [featureA; featureB; featureC; featureD; featureE; featureF]];
       
    fclose(fileId);
    
end

disp('Reading co Files');

for j=1:length(coFiles)
    
    fileId = fopen(['data/' coFiles{j}], 'r');
    data = fscanf(fileId, fileFormat, columnsSize);
    
    coData{j} = data(19,:)/max(data(19,:));
    
    % Feature extraction
    featureA = min(var(split_data(coData{j}(coData{j}>=0.7), 100, 50)));
    featureB = var(var(split_data(coData{j}, 100, 50)));
    featureC = max(var(split_data(coData{j}(coData{j}>=0.7), 100, 50)));
    
    featureD = min(std(split_data(coData{j}(coData{j}>=0.7), 100, 50)));
    featureE = std(std(split_data(coData{j}, 100, 50)));
    featureF = max(std(split_data(coData{j}(coData{j}>=0.7), 100, 50)));
    
    coX = [coX [featureA; featureB; featureC; featureD; featureE; featureF]];
    
    fclose(fileId);
    
end

% Plot some feature space
figure; 
plot3(ptX(1,:), ptX(3,:), ptX(4,:), 'k*'); 
hold on; 
plot3(coX(1,:), coX(3,:), coX(4,:), 'g^'); 
hold off;
grid on;

% Training

X_train = [ptX(:,1:10) coX(:,1:10)]';
Y_train = [ones(1,10), zeros(1,10)];

disp('Training');

mdl_tree = fitensemble(X_train,Y_train,'AdaBoostM1', 500, 'Tree','type','Classification');

% Checking
X_predict = [ptX(:,11:20) coX(:,11:20)]';
Y_check = [ones(1,10), zeros(1,10)];

Y_predict = predict(mdl_tree, X_predict)


