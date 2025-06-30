s = tf('s');

% Parametreler
a = 5;
wn = sqrt(2);
zeta = 1 / sqrt(2);

% Ana sistem G(s)
G = (a * wn^2) / ((s + a) * (s^2 + 2*zeta*wn*s + wn^2));

% Karşılaştırma sistemleri
G1 = a / (s + a);                            % Birinci dereceden sistem
G2 = wn^2 / (s^2 + 2*zeta*wn*s + wn^2);      % İkinci dereceden sistem
figure;
step(G, G1, G2);
legend('G1(s)','G2(s)','G(s)')