% Naudodami savo sukurtas arba specializuotas MATLAB funkcijas, 
% atpa?inkite vaizde pateiktus ranka ra?ytus skai?ius. Vaizdo apdorojimui 
% galite pasinaudoti jau sukurtomis funkcijomis (vaizdo segmentavimo, 
% vienodo, 50x70 ta?k?, dyd?io kvadrat?li? su skai?iais paruo?imo, 
% 35 po?ymi? i?skyrimo...). Galite paruo?ti savo vaizdus ir po?ymiams 
% i?skirti naudoti ?i? funkcij? (reikia nurodyti paveiksl?lio pavadinim? 
% ir simboli? eilu?i? vaizde skai?i?).

close all;
clc;
clear;

I = imread('skaiciai.bmp');

% Black and white, like we all like 
I = im2bw(I, 0.86);

% Full blown canny detection
I_e = edge(I, 'canny', [0.15 0.4]);

% Bluring everything for better region detection
I_f = imfilter(I_e, magic(5));

% Go for areal statistics
stats = regionprops(I_f, 'BoundingBox', 'Area');

NNs = {};

for k=1:length(stats)
    bb = round(stats(k).BoundingBox);
   
    I_c = I(bb(2):bb(2)+bb(4),bb(1):bb(1)+bb(3),:);
    NN{k} = imresize(I_c, [32 32]);
end

for k=1:5
    X(1,k,:) = reshape(NN{k}, [], 1);
    X(2,k,:) = reshape(NN{k+5}, [], 1);
    X(3,k,:) = reshape(NN{k+10}, [], 1);
    X(4,k,:) = reshape(NN{k+15}, [], 1);
    X(5,k,:) = reshape(NN{k+20}, [], 1);
    X(6,k,:) = reshape(NN{k+25}, [], 1);
    X(7,k,:) = reshape(NN{k+30}, [], 1);
    X(8,k,:) = reshape(NN{k+35}, [], 1);
    X(9,k,:) = reshape(NN{k+40}, [], 1);
    X(10,k,:) = reshape(NN{k+45}, [], 1);
end

X_train = [
    X(1,1,:)
    X(1,2,:)
    X(1,3,:)
    
    X(2,1,:)
    X(2,2,:)
    X(2,3,:)
    
    X(3,1,:)
    X(3,2,:)
    X(3,3,:)
    
    
    X(4,1,:)
    X(4,2,:)
    X(4,3,:)
    
    X(5,1,:)
    X(5,2,:)
    X(5,3,:)
    
    X(6,1,:)
    X(6,2,:)
    X(6,3,:)
    
    X(7,1,:)
    X(7,2,:)
    X(7,3,:)
    
    X(8,1,:)
    X(8,2,:)
    X(8,3,:)
    
    X(9,1,:)
    X(9,2,:)
    X(9,3,:)
    
    X(10,1,:)
    X(10,2,:)
    X(10,3,:)
];

X_predict = [
    X(1,4,:)
    X(1,5,:)
    
    X(2,4,:)
    X(2,5,:)
    
    X(3,4,:)
    X(3,5,:)
    
    X(4,4,:)
    X(4,5,:)
    
    X(5,4,:)
    X(5,5,:)
    
    X(6,4,:)
    X(6,5,:)
    
    X(7,4,:)
    X(7,5,:)
    
    X(8,4,:)
    X(8,5,:)
    
    X(9,4,:)
    X(9,5,:)
    
    X(10,4,:)
    X(10,5,:)
];

X_train = double(reshape(X_train, [], 1024));
X_predict = double(reshape(X_predict, [], 1024));

Y_train = [1,1,1, 2,2,2, 3,3,3, 4,4,4, 5,5,5, 6,6,6, 7,7,7, 8,8,8, 9,9,9, 0, 0, 0];
Y_predict = [1,1, 2,2, 3,3, 4,4, 5,5, 6,6, 7,7, 8,8, 9,9, 0, 0];

%mdl_tree = ClassificationTree.fit(X_train, Y_train);
mdl_tree = fitensemble(X_train,Y_train,'Bag', 300,'Tree','type','Classification');

Y_tree = predict(mdl_tree, X_predict);

figure;

subplot(5,2,1);
imshow(reshape(X_predict(1,:,:), 32, 32)); title(Y_tree(1));
 
subplot(5,2,2);
imshow(reshape(X_predict(3,:,:), 32, 32)); title(Y_tree(3));

subplot(5,2,3);
imshow(reshape(X_predict(5,:,:), 32, 32)); title(Y_tree(5));

subplot(5,2,4);
imshow(reshape(X_predict(7,:,:), 32, 32)); title(Y_tree(7));

subplot(5,2,5);
imshow(reshape(X_predict(9,:,:), 32, 32)); title(Y_tree(9));

subplot(5,2,6);
imshow(reshape(X_predict(11,:,:), 32, 32)); title(Y_tree(11));

subplot(5,2,7);
imshow(reshape(X_predict(13,:,:), 32, 32)); title(Y_tree(13));

subplot(5,2,8);
imshow(reshape(X_predict(15,:,:), 32, 32)); title(Y_tree(15));

subplot(5,2,9);
imshow(reshape(X_predict(17,:,:), 32, 32)); title(Y_tree(17));

subplot(5,2,10);
imshow(reshape(X_predict(19,:,:), 32, 32)); title(Y_tree(19));