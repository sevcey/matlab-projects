




clc; clear; close all;

%% Sistem parametreleri
m = 100;   % kg
k = 10;    % N/m
b = 10;    % Ns/m

%% State-space matrisi tanımı
A = [0 1; -k/m -b/m];
B = [0; 1/m];
C = [1 0];
D = 0;

%% Sistem nesnesi
sys = ss(A, B, C, D);

%% b) Mode'lar (eigenvalue'lar)
disp('Eigenvalues (Modes):');
eig_A = eig(A)

%% c) Transfer fonksiyonu
G = tf(sys);
disp('Transfer function G(s):');
G

%% d) Kazanç (gain) ve sıfır/kutup verileri
[z, p, k_gain] = zpkdata(sys, 'v');
disp('Gain:');
disp(k_gain);

%% e) Damping, frekans, zaman sabiti
disp('Damping Info:');
damp(sys)

%% f) Başlangıç koşulları ile sistem tepkisi
x0 = [1; 0.1];   % x(0) = 1 m, x_dot(0) = 0.1 m/s
t = 0:0.01:10;
figure;
initial(sys, x0, t);
title('Initial Response with x0 = [1; 0.1]');
xlabel('Time (s)');
ylabel('Displacement x(t)');
grid on;

%% h) m = 1 kg için tekrar et
m = 1;
A2 = [0 1; -k/m -b/m];
B2 = [0; 1/m];
sys2 = ss(A2, B2, C, D);

disp('New eigenvalues with m = 1:');
eig(A2)

disp('New damping info with m = 1:');
damp(sys2)

figure;
initial(sys2, x0, t);
title('Initial Response with m = 1 kg');
xlabel('Time (s)');
ylabel('Displacement x(t)');
grid on;
