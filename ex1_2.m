% Matrisleri tanımla
B = [-1 4 -2; -2 5 -2; -1 2 0];
C = [1; 2; 3];

% Kullanıcıdan N al
N = input('Enter N > ');

% Hata kontrolü: N tam sayı mı?
if floor(N) ~= N
    error('Hata: N tam sayı olmalıdır.')
end

% B'nin tersi hazırda dursun
invB = inv(B);

% Başlangıç
x = zeros(1, abs(N) + 1);  % x(n) değerlerini tutacak vektör

if N >= 0
    for n = 0:N
        sumVal = 0;
        for k = 0:n
            if k == 0
                Bk = eye(size(B));  % B^0 = I
            else
                Bk = B^k;
            end
            sumVal = sumVal + C' * Bk * C;
        end
        x(n+1) = sumVal;
    end
else
    for n = 0:(-N)
        sumVal = 0;
        for k = n:-1:0
            if k == 0
                Bk = eye(size(B));
            else
                Bk = invB^k;  % negatif kuvvet
            end
            sumVal = sumVal + C' * Bk * C;
        end
        x(n+1) = sumVal;
    end
end

% x(n) vektörünü çizdir
n_vals = 0:abs(N);
plot(n_vals, x, '-o')
xlabel('n')
ylabel('x(n)')
title(['x(n) for N = ', num2str(N)])
grid on
