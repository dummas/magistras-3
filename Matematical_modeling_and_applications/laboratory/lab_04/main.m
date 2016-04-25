a = -10;
b = 10;

XX = a:0.01:b;
YY = [];
for idx=1:numel(XX)
    x = XX(idx);
    
    y = ffun(x);
    
    YY = [YY y];
end

NNa = [2 3 5 7 9];
LL_MSE = [];
LL_MAX = [];
NN_MSE = [];
NN_MAX = [];
CC_MSE = [];
CC_MAX = [];
PP_MSE = [];
PP_MAX = [];
SS_MSE = [];
SS_MAX = [];

for Na = NNa

    Nn = (b-a)/Na;
    X = a:Nn:b;
    Y = [];
    for idx=1:numel(X)
        x = X(idx);

        y = ffun(x);

        Y = [Y y];
    end

    % Lagaranzo
    [l,L] = lagran(X, Y);
    LL = polyval(l,XX);
    LL_MSE = [LL_MSE sum((LL - XX).^2)/length(XX)];
    LL_MAX = [LL_MAX max(abs(LL - XX))];

    % Niutono
    [n,DD] = niuton(X, Y);
    NN = polyval(n, XX);
    NN_MSE = [NN_MSE sum((NN-XX).^2)/length(XX)];
    NN_MAX = [NN_MAX max(abs(NN-XX))];

    % Cebysev
    [c,cx,cy] = cheby('ffun', Na, a, b);
    CC = polyval(c, XX);
    CC_MSE = [CC_MSE sum((CC-XX).^2)/length(XX)];
    CC_MAX = [CC_MAX max(abs(CC-XX))];

    % Pade 
    [num,den,t] = pade('ffun', (a+b)/2, Na, Na, a, b);
    PP = polyval(num,XX)./polyval(den,XX);
    PP_MSE = [PP_MSE sum((PP-XX).^2)/length(XX)];
    PP_MAX = [PP_MAX max(abs(PP-XX))];

    % Splain
    sp = spline(X, Y);
    SS = ppval(sp, XX);
    SS_MSE = [SS_MSE sum((SS-XX).^2)/length(XX)];
    SS_MAX = [SS_MAX max(abs(SS-XX))];
end

figure('Name', 'MSE');

subplot(5,1,1);
plot(NNa, LL_MSE);
title('Lagrange');

subplot(5,1,2);
plot(NNa, NN_MSE);
title('Niuton');

subplot(5,1,3);
plot(NNa, CC_MSE);
title('Chebysev');

subplot(5,1,4);
plot(NNa, PP_MSE);
title('Pade');

subplot(5,1,5);
plot(NNa, SS_MSE);
title('Spline');

figure('Name', 'Max Error');
subplot(5,1,1);
plot(NNa, LL_MAX);
title('Lagrange');

subplot(5,1,2);
plot(NNa, NN_MAX);
title('Niuton');

subplot(5,1,3);
plot(NNa, CC_MAX);
title('Chebysev');

subplot(5,1,4);
plot(NNa, PP_MAX);
title('Pade');

subplot(5,1,5);
plot(NNa, SS_MAX);
title('Spline');