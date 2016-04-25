a = 0;
b = 2;
N = 4;

f = inline('x.^3-2*x', 'x');

true_I = 2^4/4 - 2^2;
It = trpzds(f,a,b,N); 
errt = It-true_I; %trapezoidal

Is = smpsns(f,a,b,N);
errs = Is-true_I; %Simpson

[IR] = rmbrg(f,a,b,.00005); 
errR = IR - true_I; %Romberg