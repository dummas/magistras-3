function X = jacobi(A,B,X0,kmax)
%This function finds a soltuion to Ax = B by Jacobi iteration.
if nargin < 4, tol = 1e-6; kmax = 100; %called by jacobi(A,B,X0)
    elseif kmax < 1, tol = max(kmax,1e-16); kmax = 100; %jacobi(A,B,X0,tol)
    else tol = 1e-6; %jacobi(A,B,X0,kmax)
end
if nargin < 3, X0 = zeros(size(B)); end
NA = size(A,1);
X = X0; At = zeros(NA,NA);
for m = 1:NA
    for n = 1:NA
        if n ~= m, At(m,n) = -A(m,n)/A(m,m); end
    end
    Bt(m,:) = B(m,:)/A(m,m);
end
for k = 1: kmax
    X = At*X + Bt; %Eq. (2.5.3)
    if nargout == 0, X, end %To see the intermediate results
    if norm(X - X0)/(norm(X0) + eps) < tol, break; end
    X0 = X;
end