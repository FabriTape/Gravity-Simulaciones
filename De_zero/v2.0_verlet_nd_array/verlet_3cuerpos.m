% verlet_3cuerpos.m - Verlet para 3 cuerpos (Tierra, Luna, 3er cuerpo)
% Metodo: Position Verlet vectorizado con repmat, permute, vecnorm, dot
% Cuerpos: 3 (Tierra 5.9724e24 kg, Luna 0.07346e24 kg, 3ro masivo=0)
%
% Uso: octave verlet_3cuerpos

clearvars
tic
n=3;
#Tensor de posiciones
X(2,:,1)=[0,0.4055E9,3.6502e8];#Posición de la Tierra y Luna en x (metros)
X(2,:,2)=[0,0,0];       #Posición de la Tierra y Luna en y (metros)
X(2,:,3)=[0,0,0];       #Posición de la Tierra y Luna en z (metros)


#Tensor de velocidades
V(1,:,1)=[0,0,0];   #Velocidad de la Tierra y Luna en x (metros/segundo)
V(1,:,2)=[0,970,1045]; #Velocidad de la Tierra y Luna en y (metros/segundo)
V(1,:,3)=[0,0,0];   #Velocidad de la Tierra y Luna en z (metros/segundo)

#Condiciones de integracion
dt=11664;   #Paso de integración
T=23328000; #Tiempo total de simulación (segundos)
N=T/dt;

  #Vector de masas del sitema (Kilogramos)
  M=[5.9724e24;0.07346e24;0];

  Mexpa=repmat(M,[1,n,3]); #Tensor de masa expandida

function [A]=aceleracion(X,M,N)
G=6.674e-11; #Constante de gravitación

% Tensor de coordenadas repetidas
K = repmat(X, [N, 1, 1]);

% Tensor de vectores rj-ri
Rij = K - permute(K, [1, 3, 2]);

% Cálculo de la matriz de coeficientes 1/r^3
R_norm = vecnorm(Rij, 2, 3);
R_norm_3 = (R_norm.^3 + (R_norm == 0)) .^ (-1)-(R_norm == 0);


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
xlabel ("x[m]");
ylabel ("y[m]");
zlabel ("z[m]");
plot3(X(:,:,1),X(:,:,2),X(:,:,3),'o')
h=legend({"Tierra","Luna","algo"})
#axis("equal")






