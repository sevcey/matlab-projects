clc; clear; close all;

%% (a) Plant (kütle-yay-sönümleyici sistem)
m = 100; b = 10; k = 10;
plant = tf(1, [m b k]);   % P(s) = 1 / (ms^2 + bs + k)

%% Controller: C(s) = (100s + 5) / (s + 1)
controller = tf([100 5], [1 1]);

%% Açık çevrim sistem
Gol = controller * plant;

%% Kapalı çevrim sistem (negatif birim geribesleme)
Gcl = feedback(Gol, 1);

%% (b) Zero ve Pole bilgisi
disp('Zeros of closed-loop system:');
disp(zero(Gcl));

disp('Poles of closed-loop system:');
disp(pole(Gcl));

%% (c) Başlangıç koşulu cevabı
% Sistemin state sayısını öğren
n = order(Gcl);     % kaç durum varsa öğren

% Başlangıç vektörü oluştur (ilk 2 elemanı x(0)=1, ẋ(0)=0.1 gibi)
x0 = zeros(n, 1);
x0(1) = 1;     % x(0)
x0(2) = 0.1;   % x_dot(0)

% Durum uzayına çevir
sys_cl = ss(Gcl);

% Başlangıç cevabı
[Y, T, X] = initial(sys_cl, x0);

% Grafik
figure;
plot(T, Y, 'b', 'LineWidth', 1.5);
title('Initial Response: x(0)=1, ẋ(0)=0.1');
xlabel('Time (s)');
ylabel('x(t)');
grid on;

%% (d) r(t) = -1 birimlik referans girişi için yanıt (lsim)
r = -1 * ones(size(T));   % sabit giriş: -1
[Y_lsim, T_lsim, X_lsim] = lsim(sys_cl, r, T, x0);

figure;
plot(T_lsim, Y_lsim, 'r', 'LineWidth', 1.5);
title('Response to r(t) = -1 with x0 = [1; 0.1]');
xlabel('Time (s)');
ylabel('x(t)');
grid on;
