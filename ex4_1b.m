num = [100 4500 45000];
den = [1 38 457 2120 3700 2000];
G = tf(num, den);

z = zero(G);    % sıfırlar
p = pole(G);    % kutuplar
margin(G);      % Bode + margin
% G(s) tanımlıysa:
K = 0.3;                     % örnek başlama değeri
GK = K * G;                  % G_K(s) = K * G(s)
margin(GK);                  % GM ≈ 10 dB olana kadar ayarla
[GM, PM_deg, Wcg, ~] = margin(K * G);
PM_rad = deg2rad(PM_deg);   % derece → radyan çevir

Tmax = PM_rad / Wcg;

fprintf('Maksimum zaman gecikmesi: %.4f saniye\n', Tmax);
G0 = dcgain(K * G);  % s = 0 kazancı
ess = 1 / (1 + G0);  % step için steady-state error

fprintf('Low-frequency kazanç: %.3f\n', G0);
fprintf('Steady-state error: %.4f\n', ess);
G0 = dcgain(K * G);  % s = 0 kazancı
ess = 1 / (1 + G0);  % step için steady-state error

fprintf('Low-frequency kazanç: %.3f\n', G0);
fprintf('Steady-state error: %.4f\n', ess);
s = tf('s');
Lag = (s + 0.1) / (s + 0.01);

G_new = K * Lag * G;
margin(G_new);  % Yeni margin'leri gör
% Açık çevrim sistem (OL)
OL = K * Lead * Lag * G;

% Kapalı çevrim sistem
CL = feedback(OL, 1);

% Step cevabı
step(CL)
title('Kapalı Çevrim Step Cevabı')

% Steady-state error
ess = abs(1 - dcgain(CL));
fprintf('Steady-state error: %.4f\n', ess);

