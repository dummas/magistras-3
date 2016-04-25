function [y] = ffun(x)

%y = (1+x)/log(1+x);
y = 1./(1+exp(x));