s = tf('s');
wn = 0.5;
T = 0;
zeta = 1;
G = (T*s + 1)/(s^2 + 2*zeta*wn*s + wn^2);

% Kutuplar ve sıfırlar
zero(G)
pole(G)

% Step cevabı
step(G)
