A = [3 -3 1; 4 -5 2; 4 -5 2];
B = [-1 4 -2; -2 5 -2; -1 2 0];
C = [1; 2; 3];
[V_A, D_A] = eig(A);
[V_B, D_B] = eig(B);
rankA= rank(A);
rankB= rank(B);
AB = A*B;
BA = B*A;
result = A' + B;
invB = inv(B);
X = invB*C;
check = B*X;
newA = A(1 : 2, 2 : 3);
newB = B(1, :);
disp(newA);
eigenA = eig(A);
disp(eigenA);
BAC = B*A*C;
invA = inv(A);


