clc; clear;

%% a) Sistem tanımı
A = [-1 0 0; 0 -6 5; 5 -10 4];
B = [1; 1; 2];
C = [1 0 0; -1 1 0];
D = [1; 0];
sys = ss(A, B, C, D);

%% b) Transfer fonksiyonunu bul
% (i) ss2tf
[num, den] = ss2tf(A, B, C, D);

% (ii) tf ile
G = tf(sys);

% Farkı görmek için:
disp('TFM via ss2tf:'); disp(num); disp(den);
disp('TFM via tf(sys):'); disp(G);

%% c) Kutuplar ve Özdeğerler
% (i) roots ile
roots1 = roots(den(1,:));

% (ii) pole ile
poles_tf = pole(sys);

% (iii) eig ile
eig_A = eig(A);

disp('Roots (from ss2tf):'), disp(roots1);
disp('Poles (pole(sys)):'), disp(poles_tf);
disp('Eigenvalues (eig(A)):'), disp(eig_A);

%% d) tf2ss ile tekrar state-space'e dön
[A2, B2, C2, D2] = tf2ss(num, den);

% Kontrol edelim
disp('A2, B2, C2, D2:');
disp(A2); disp(B2); disp(C2); disp(D2);

% Similarity transform kontrolü
C1 = [B A*B A^2*B];
C2_check = [B2 A2*B2 A2^2*B2];

if rank(C1) == size(C1,1)
    T = C2_check * inv(C1);
    disp('Similarity transform matrix T:');
    disp(T);
else
    disp('C1 is not invertible. Cannot compute T.');
end

%% e) Step yanıtı (0 ≤ t ≤ 5)
t = 0:0.01:5;
figure;
step(sys, t);
title('Step Response (0 ≤ t ≤ 5)');

%% f) x(0)=0, u(t)=1 için lsim ile yanıt
u = ones(size(t));
x0 = [0; 0; 0];
[y_lsim, t_out] = lsim(sys, u, t, x0);

figure;
plot(t_out, y_lsim);
title('LSIM Response (x0 = 0, u(t) = 1)');
legend('y_1(t)', 'y_2(t)');

%% g) x(0) rastgele [-1,1], tekrar lsim
x0_rand = -1 + 2*rand(3,1);
[y_rand, t_out] = lsim(sys, u, t, x0_rand);

figure;
plot(t_out, y_rand);
title('LSIM with random x0');
legend('y_1(t)', 'y_2(t)');
disp('Random x0:'); disp(x0_rand);

