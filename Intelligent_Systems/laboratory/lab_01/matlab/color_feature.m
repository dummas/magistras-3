function hsv_value = color_feature(Im)
% im - vaizdas, nuskaitytas su imread
% bw - binarinis vaizdas (nurodo sriti, kurioje yra skaiciuojamas 
% spalvos vidutine reiksme)
% atsakymas hsv_value - spalva HSV skaleje
% 

BW = im2bw(rgb2gray(Im),0.95);
BW = imfill(~BW,'holes');
BW = imopen(BW,strel('disk',12));


hsv_im=rgb2hsv(Im);
hsv=hsv_im(:,:,1);

hsv_value=mean(mean(hsv(BW)));