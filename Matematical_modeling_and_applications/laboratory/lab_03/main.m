% x1 = 2
% x2 = x1 + 2
% x3 = x2 + 2
% x4 = x3 + 2

Na = 4;

A=[1 0 0 0; -1 1 0 0; 0 -1 1 0; 0 0 -1 1];
b=2*ones(1,Na)';
x0=zeros(1,Na)';


x1=jacobi(A,b,x0);

disp('X pagal jakobi ');
disp(x1);

x2=A\b;

disp('X pagal A\b');
disp(x2);