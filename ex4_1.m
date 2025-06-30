s = tf('s');

% Sistem modeli: G(s) = s / (s - 1)
G = s / (s - 1);

% PI kontrolör: C(s) = k*(s + z)/s
k = 10;
z = 1;
C = k * (s + z) / s;

% Kapalı çevrim sistemi
T = feedback(C * G, 1);

% Durum (a): sabit referans + sinüsoidal bozucu
t = 0:0.01:30;
r = ones(size(t));            % Sabit referans
d = 1 + sin(t);               % Bozucu

% Simülasyon: bozucuyu doğrudan eklemeliyiz
[y, t_out, x] = lsim(T, r - d, t);

% Hata: e(t) = r(t) - y(t)
e = r - y;

% Grafik
figure;
subplot(2,1,1);
plot(t, y); title('Çıkış y(t)');
subplot(2,1,2);
plot(t, e); title('Hata e(t) = r(t) - y(t)');
