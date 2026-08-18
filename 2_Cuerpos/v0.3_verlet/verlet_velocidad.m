% verlet_velocidad.m - Velocity Verlet para sistema Tierra-Luna
% Metodo: Verlet con almacenamiento explicito de velocidades
% Cuerpos: 2 (Tierra-Luna en SI)
% Incluye: seguimiento de energia y momento
%
% Uso: octave verlet_velocidad

clearvars;
tic
t=11664;
T=[0:t:2332800*10];

%condiciones iniciales
X(1,:,1)=condiciones_iniciales(1); X(1,:,2)=condiciones_iniciales(2); M1=5.9722e24;
V(1,:,1)=condiciones_iniciales(3); V(1,:,2)=condiciones_iniciales(4); M2=0.07346e24;

for n=1:length(T)-1   %nuevas pocisiones de las particulas

  X(n+1,:,1)=X(n,:,1)+V(n,:,1)*t+0.5*t*t*funciones_fisica(X(n,:,1),X(n,:,2),M1,M2,1);
  X(n+1,:,2)=X(n,:,2)+V(n,:,2)*t+0.5*t*t*funciones_fisica(X(n,:,2),X(n,:,1),M1,M2,2);

    V(n+1,:,1)=V(n,:,1)+(funciones_fisica(X(n,:,1),X(n,:,2),M1,M2,1)+funciones_fisica(X(n+1,:,1),X(n+1,:,2),M1,M2,1))*0.5*t;
    V(n+1,:,2)=V(n,:,2)+(funciones_fisica(X(n,:,2),X(n,:,1),M1,M2,2)+funciones_fisica(X(n+1,:,2),X(n+1,:,1),M1,M2,2))*0.5*t;

endfor
for n=1:length(T)

  U(n)=funciones_fisica(X(n,:,1),X(n,:,2),M1,M2,4);
  K(n)=funciones_fisica(V(n,:,1),V(n,:,2),M1,M2,3);
  E(n)=U(n)+K(n);
  P(n)=(funciones_fisica(V(n,:,1),V(n,:,2),M1,M2,5)-funciones_fisica(V(1,:,1),V(1,:,2),M1,M2,5))/funciones_fisica(V(n,:,1),V(n,:,2),M1,M2,5);

endfor
toc
  grafico_trayectorias(X(:,:,:),M1,M2);
##graficos_energia(2,T,K,U,E,P)
