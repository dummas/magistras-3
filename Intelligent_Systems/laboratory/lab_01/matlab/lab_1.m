echo off

input = {
    {'images/apple_04.jpg', 'apple'},
    {'images/apple_05.jpg', 'apple'},
    {'images/apple_06.jpg', 'apple'},
    {'images/pear_01.jpg', 'pear'},
    {'images/pear_02.jpg', 'pear'},
};

threadshot = 0.1;


for i=length(input)
    image_class = input{i,1}{2};
    image_path = input{i,1}{1};
    im = imread(image_path);
    feature{i, 1} = apvalumo_skaiciavimas(im, threadshot)
    feature{i, 2} = spalvu_nustatymas(im, im2bw(im))
    imshow(im);
end