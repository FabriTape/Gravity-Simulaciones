% verlet_unidades_adimensionales.m - Verlet Tierra-Luna en unidades adimensionales
% Metodo: Position Verlet vectorizado (sin constante G explicita)
% Cuerpos: 2 (masas y distancias normalizadas)
% Ventana: rapida, sin constantes fisicas
%
% Uso: octave verlet_unidades_adimensionales

clearvars
tic
n=2
#Tensor de posiciones
X(2,:,1)=[0,4.055];#Posición de la Tierra y Luna en x
X(2,:,2)=[0,0];       #Posición de la Tierra y Luna en y
X(2,:,3)=[0,0];       #Posición de la Tierra y Luna en z



#Tensor de velocidades
V(1,:,1)=[0,0];   #Velocidad de la Tierra y Luna en x
V(1,:,2)=[0,1.131408]; #Velocidad de la Tierra y Luna en y
V(1,:,3)=[0,0];   #Velocidad de la Tierra y Luna en z


#Condiciones de integracion
dt=0.1;   #Paso de integración
T=2000;    #Tiempo total de simulación
N=T/dt;

  #Vector de masas del sitema
  M=[5.9724;0.07346];

  Mexpa=repmat(M,[1,n,3]); #Tensor de masa expandida

function [A]=aceleracion(X,M,n)

% Tensor de coordenadas repetidas
K = repmat(X, [n, 1, 1]);

% Tensor de vectores rj-ri
Rij = K - permute(K, [2, 1, 3]);

% Cálculo de la matriz de coeficientes 1/r^3
R_norm = vecnorm(Rij, 2, 3);
R_norm_3 = (R_norm.^3 + 1).^(-1) - eye(n);


% Cálculo de la aceleración
A = - dot(R_norm_3 .* Rij, M, 1);

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

