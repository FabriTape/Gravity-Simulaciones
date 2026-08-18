% verlet_500_cuerpos.m - N cuerpos (500) con condiciones iniciales aleatorias
% Metodo: Position Verlet vectorizado
% Cuerpos: 500 (posiciones N(0,1)*3000, velocities N(0,1)/10, masas N(0,1)*5e10)
%
% Uso: octave verlet_500_cuerpos

clearvars
tic
n=500
#Tensor de posiciones
X=randn(1,n,3)*3000;

#Tensor de velocidades
V=randn(1,n,3)/10;

#Condiciones de integracion
dt=1;
T=600;
N=T/dt;

#Vector de masas del sitema
M=randn(n,1)*50000000000;

#Tensor de masa expandida
Mexpa=repmat(M,[1,n,3]);

function [A]=aceleracion(X,Mexpa,n)


  G=6.674e-11; #Constante de gravitación

  K=repmat(X,[n 1]); #Tensor con las coordenadas repetidas

  Rij=K-permute(K,[2,1,3]); #Tensor de vectores rj-ri

  R=(vecnorm(Rij,2,3).^3 +eye(n)).^(-1)-eye(n); #Matriz de coeficientes 1/r^3

  A=-G*dot(R.*Rij,Mexpa,1);

endfunction

#Cálculo de la posición del sitema en t=-dt
X(2,:,:)=X(1,:,:)+V*dt+0.5*aceleracion(X(1,:,:),Mexpa,n)*dt^2;

#Bucle de integracion en el tiempo
for i=2:N
  X(i+1,:,:)=2*X(i,:,:)-X(i-1,:,:)+aceleracion(X(i,:,:),Mexpa,n)*dt^2;
end
toc
plot3(X(:,:,1),X(:,:,2),X(:,:,3),'o')
