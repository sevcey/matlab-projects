s = tf('s');
G = 1 / (s^2 + 2*s + 2);
CL = feedback(G, 1);

[y, t] = step(CL);     % y(t): çıktı
r = ones(size(t));     % r(t): giriş
e = r - y;             % e(t): hata

margin(CL);