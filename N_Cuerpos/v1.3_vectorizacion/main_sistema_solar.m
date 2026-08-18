clear all; clc;
% Wrapper para verlet_vectorizado_g2n/g3n/embebido con condiciones iniciales del sistema solar
% Compara las 3 versiones de integrador vectorizado

% Condiciones iniciales del sistema solar
X0(1,:,1)=[0,0,0];           X0(1,:,2)=[69.818e9,0,0];
X0(1,:,3)=[108.941e9,0,0];   X0(1,:,4)=[152.1e9,0,0];
X0(1,:,5)=[1.5251e11,0,0];   X0(1,:,6)=[249.261e9,0,0];
X0(1,:,7)=[816.363e9,0,0];   X0(1,:,8)=[1506.527e9,0,0];
X0(1,:,9)=[3001.390e9,0,0];  X0(1,:,10)=[4558.857e9,0,0];
X0(1,:,11)=[7304.326e9,0,0];

V0(1,:,1)=[3.9923,0.2056,0]; V0(1,:,2)=[0,38860,0];
V0(1,:,3)=[0,34790,0];       V0(1,:,4)=[0,29240,0];
V0(1,:,5)=[0,970+29240,0];   V0(1,:,6)=[0,21970,0];
V0(1,:,7)=[0,12440,0];       V0(1,:,8)=[0,9090,0];
V0(1,:,9)=[0,6490,0];        V0(1,:,10)=[0,5370,0];
V0(1,:,11)=[0,3710,0];

M=[1988500e24; 0.33010e24; 4.8673e24; 5.9722e24; 0.07346e24;
   0.64169e24; 1898.13e24; 568.32e24; 86.811e24; 102.409e24; 0.01303e24];

dt = 86400;
T = 0:dt:300*dt;
C = ones(1,length(T)-1);

% --- verlet_vectorizado_g2n (usa fuerza_g2n) ---
fprintf('Ejecutando verlet_vectorizado_g2n...\n');
tic;
X4 = verlet_vectorizado_g2n(X0, V0, M, C, T);
t4 = toc;
fprintf('verlet_vectorizado_g2n: %.3f segundos\n', t4);

% --- verlet_vectorizado_g3n (usa fuerza_g3n, fórmula de timestep mejorada) ---
fprintf('Ejecutando verlet_vectorizado_g3n...\n');
tic;
X5 = verlet_vectorizado_g3n(X0, V0, M, C, T);
t5 = toc;
fprintf('verlet_vectorizado_g3n: %.3f segundos\n', t5);

% --- verlet_vectorizado_embebido (usa G4N embebida) ---
fprintf('Ejecutando verlet_vectorizado_embebido...\n');
tic;
X6 = verlet_vectorizado_embebido(X0, V0, M, C, T);
t6 = toc;
fprintf('verlet_vectorizado_embebido: %.3f segundos\n', t6);

% Gráfico comparativo
figure;
subplot(1,3,1);
plot3(X4(:,:,1),X4(:,:,2),X4(:,:,3),'o');
title('verlet_vectorizado_g2n (fuerza_g2n)'); xlabel('x'); ylabel('y'); zlabel('z');

subplot(1,3,2);
plot3(X5(:,:,1),X5(:,:,2),X5(:,:,3),'o');
title('verlet_vectorizado_g3n (fuerza_g3n)'); xlabel('x'); ylabel('y'); zlabel('z');

subplot(1,3,3);
plot3(X6(:,:,1),X6(:,:,2),X6(:,:,3),'o');
title('verlet_vectorizado_embebido (G4N embebida)'); xlabel('x'); ylabel('y'); zlabel('z');
