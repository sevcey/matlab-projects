clc; clear; close all;

%% a) Tanım: m, b, transfer fonksiyonu
m = 1000;           % kg
b = 50;             % Ns/m
NUM = 1;
DEN = [m b];

G = tf(NUM, DEN);
disp('Transfer Function G(s):');
disp(G);

%% b) Sistem kutbu (pole)
p = pole(G);
disp('Pole:');
disp(p);

%% c) Zaman sabiti (time constant) → tau = 1 / |real(pole)|
[wn, zeta, p_damp] = damp(G);
tau = 1 / abs(real(p));
disp(tau)

%% d) Step yanıtı u(t) = 500 N
u_mag = 500;
G_scaled = u_mag * G;

figure;
step(G_scaled, 0:0.1:20);
title('Step Response (u(t) = 500 N, Theoretical Model)');
ylabel('Velocity (m/s)');
xlabel('Time (s)');
grid on;

%% e) Simulink kısmı için - YALNIZCA GÖSTERİM NOTU
disp('Part (e): Run the Simulink model named "CruiseControl.slx" with step input of 500 N');
% (Burada kullanıcı, daha önceki "Simulink cruise modelini" açıp çalıştırmalı.)

%% f) m %20 artıyor, b %10 azalıyor → m_new = 1.2*m, b_new = 0.9*b
m_new = 1.2 * m;
b_new = 0.9 * b;
DEN_new = [m_new b_new];
G_new = tf(NUM, DEN_new);

% Yeni sistem kutbu ve zaman sabiti
p_new = pole(G_new);
tau_new = 1 / abs(real(p_new));
disp(['New Pole = ', num2str(p_new)]);
disp(['New τ = ', num2str(tau_new)]);

% Step yanıtı karşılaştırması
G_new_scaled = u_mag * G_new;

figure;
step(G_scaled, 0:0.1:20); hold on;
step(G_new_scaled, 0:0.1:20);
legend('Original', 'Modified m and b');
title('Step Response Comparison');
ylabel('Velocity (m/s)');
xlabel('Time (s)');
grid on;
