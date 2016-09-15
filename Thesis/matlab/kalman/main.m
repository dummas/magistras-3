X = 1:0.1:50; 
X = X * rand(length(X))/10000; 
Y = sin(X);
plot(Y);