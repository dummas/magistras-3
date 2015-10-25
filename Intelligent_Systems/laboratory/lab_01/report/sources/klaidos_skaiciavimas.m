%% Error
Err_sum = 1;

% Dirbam, kol klaida nebus lygi nuliui
while Err_sum ~= 0
    Y = [];
    for i=1:size(X, 1)
        x_1 = X(i,1);
        x_2 = X(i,2);
        Y = [Y, sign(x_1 * w_1 + x_2 * w_2 + b)];
    end
   
    % Skaiciuojame klaida 
    Err_sum = sum(Y-T);
    
    % Atnaujinam kintamuosius
    w_1 = w_1 - mu * Err_sum * sum(X(:,1));
    w_2 = w_2 - mu * Err_sum * sum(X(:,2));
    b = b - mu * Err_sum;
end