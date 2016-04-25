% Trys resursu klases
m = 3; % p
% Penki procesai
n = 5; % r

work = ones(1, m);

running = ones(1, m);
max = ones(n,m);
allocation = ones(n,m);
finish = ones(1,n) * 0;
need = max - allocation;


k = 0;

s = 0;
for i=1:n
    if finish(i) == true
        s = s + 1;
    end
end

if s == n
    disp('Sistemos busena yra saugi');
else
    disp('Sistemos busena nera saugi');
end