% verlet_tierra_luna_extendido.m - Verlet Tierra-Luna en SI (tiempo extendido x10)
% Metodo: Position Verlet vectorizado
% Cuerpos: 2 (Tierra-Luna en SI)
% Tiempo total: 233280000 s (~7.4 anios)
%
% Uso: octave verlet_tierra_luna_extendido

clearvars
tic
n=2
#Tensor de posiciones
X(2,:,1)=[0,0.4055E9];#Posición de la Tierra y Luna en x (metros)
X(2,:,2)=[0,0];       #Posición de la Tierra y Luna en y (metros)
X(2,:,3)=[0,0];       #Posición de la Tierra y Luna en z (metros)



#Tensor de velocidades
V(1,:,1)=[0,0];   #Velocidad de la Tierra y Luna en x (metros/segundo)
V(1,:,2)=[0,970]; #Velocidad de la Tierra y Luna en y (metros/segundo)
V(1,:,3)=[0,0];   #Velocidad de la Tierra y Luna en z (metros/segundo)


#Condiciones de integracion
dt=11664;   #Paso de integración
T=233280000; #Tiempo total de simulación (segundos)
N=T/dt;

  #Vector de masas del sitema (Kilogramos)
  M=[5.9724e24;0.07346e24];

  Mexpa=repmat(M,[1,n,3]); #Tensor de masa expandida

function [A]=aceleracion(X,M,n)
G=6.674e-11; #Constante de gravitación

% Tensor de coordenadas repetidas
K = repmat(X, [n, 1, 1]);

% Tensor de vectores rj-ri
Rij = K - permute(K, [2, 1, 3]);

% Cálculo de la matriz de coeficientes 1/r^3
R_norm = vecnorm(Rij, 2, 3);
R_norm_3 = (R_norm.^3 + eye(n)).^(-1) - eye(n);


% Cálculo de la aceleración
A = -G * dot(R_norm_3 .* Rij, M, 1);

endfunction

#Cálculo de la posición del sitema en t=-dt
X(1,:,:)=X(2,:,:)+V*dt+0.5*aceleracion(X(2,:,:),Mexpa,n)*dt^2;

#Bucle de integracion en el tiempo
for i=2:N
  X(i+1,:,:)=2*X(i,:,:)-X(i-1,:,:)+aceleracion(X(i,:,:),Mexpa,n)*dt^2;
end
toc
#xlabel ("x[m]");
#ylabel ("y[m]");
#zlabel ("z[m]");
#plot3(X(:,:,1),X(:,:,2),X(:,:,3),'o')
#h=legend({"Tierra","Luna"})
#axis("equal")






