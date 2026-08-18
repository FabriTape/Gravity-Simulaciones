clear all; clc;
% Wrapper para VerletV3 con condiciones iniciales del sistema solar
% Sistema solar: 11 cuerpos (Sol + planetas + Luna + Plutón)

% Condiciones iniciales del sistema solar (usando InitialRot-like data)
% Posiciones (metros)
X0(1,:,1)=[0,0,0];           % Sol
X0(1,:,2)=[69.818e9,0,0];    % Mercurio
X0(1,:,3)=[108.941e9,0,0];   % Venus
X0(1,:,4)=[152.1e9,0,0];     % Tierra
X0(1,:,5)=[1.5251e11,0,0];   % Luna
X0(1,:,6)=[249.261e9,0,0];   % Marte
X0(1,:,7)=[816.363e9,0,0];   % Jupiter
X0(1,:,8)=[1506.527e9,0,0];  % Saturno
X0(1,:,9)=[3001.390e9,0,0];  % Urano
X0(1,:,10)=[4558.857e9,0,0]; % Neptuno
X0(1,:,11)=[7304.326e9,0,0]; % Plutón

% Velocidades (m/s)
V0(1,:,1)=[3.9923,0.2056,0];
V0(1,:,2)=[0,38860,0];
V0(1,:,3)=[0,34790,0];
V0(1,:,4)=[0,29240,0];
V0(1,:,5)=[0,970+29240,0];
V0(1,:,6)=[0,21970,0];
V0(1,:,7)=[0,12440,0];
V0(1,:,8)=[0,9090,0];
V0(1,:,9)=[0,6490,0];
V0(1,:,10)=[0,5370,0];
V0(1,:,11)=[0,3710,0];

% Masas (kg)
M=[1988500e24; 0.33010e24; 4.8673e24; 5.9722e24; 0.07346e24;
   0.64169e24; 1898.13e24; 568.32e24; 86.811e24; 102.409e24; 0.01303e24];

% Vector de tiempo con paso fijo (dt = 1 día)
dt = 86400;
T = 0:dt:300*dt;
C = ones(1,length(T)-1);  % C(n) = 1 para timestep uniforme

% Ejecutar VerletV3
tic;
X = VerletV3(X0, V0, M, C, T);
toc;

% Gráfico de trayectorias
plot3(X(:,:,1),X(:,:,2),X(:,:,3),'o');
xlabel("x [m]"); ylabel("y [m]"); zlabel("z [m]");
title("Sistema Solar - VerletV3 (Timestep Uniforme)");
legend({"Sol","Mercurio","Venus","Tierra","Luna","Marte","Jupiter","Saturno","Urano","Neptuno","Plutón"});
