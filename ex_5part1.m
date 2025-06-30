s = tf('s');
G = (2*s + 1) / (s^4 + 4*s^3 + 4*s^2 - 4*s - 5);
p = pole(G)
if all(real(p<0))
    disp('BIBO')
else
    disp('not BIBO')
end
step(G)
title('Soru 2: Açık çevrim sistemin step cevabı')
K = 8;
CL = feedback(K * G, 1);
pole(CL)
step(CL)
G_ol = K * G;
ess = 1 / (1 + dcgain(G_ol));
fprintf('Steady-state error: %.4f\n', ess);
CL = feedback(G_ol, 1);
step(CL)
s = tf('s');
K = 5;                     % Deneme değeri
C = K / s;                 % PI kontrolörün integral kısmı
OL = C * G;
disp(K);
CL = feedback(OL, 1);
step(CL)

ess = 1 - dcgain(CL);
fprintf('Yeni sistemde steady-state error: %.4f\n', ess);
rlocus(G);
%rlocus(-G)
s = tf('s');
C = (s + 4) / (s + 0.2);  % Lead kompansatör örneği
OL_new = C * G;
rlocus(OL_new)
step(feedback(C * G, 1))
