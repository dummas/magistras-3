% t_c = k_1 * t_F + k_2

tt_C = [13, 14, 17, 18, 19, 15, 13, 31, 32, 29, 27];
tt_F = [55, 58, 63, 65, 66, 59, 56, 87, 90, 85, 81];

NA = 2;
t = zeros(NA, 1);
P = 100*eye(NA, NA);

tt = [];
for idx=1:numel(tt_C)
    t_C = tt_C(idx);
    t_F = tt_F(idx);
    A(idx,:) = [t_F 1];
    b(idx,:) = t_C;
    [t,K,P] = rlse_online(A(idx,:), b(idx,:), t, P);
    tt = [tt t];
end

fprintf('x ivertis taikant RLSE = %f %f\n', t(1),t(2));

% t1=A\b;
% fprintf('Palyginimui A\\b = %f\n\t\t  %f\n',t1);

t2 = pinv(A)*b;
fprintf('x ivertis taikant pinv = %f %f\n',t2(1),t2(2));


plot(tt'); grid



