% euler_mejorado.m - Simulacion 2 cuerpos (Tierra-Luna) con Euler Mejorado (Heun)
% Metodo: Euler Mejorado / Heun (orden 2) - predictor-corrector
% Cuerpos: 2 (Tierra 5.9722e24 kg, Luna 0.07346e24 kg)
%
% Uso: octave euler_mejorado

clear all
t=20 %paso del tiempo;
T=(0:t:332000)';
%constantes
M=condiciones_iniciales(5);
%funcion de la fuerza gravitatoria
P=@(u,v,m) 6.67*10^(-11)*M(1)*(M(2)/m)*(v-u)/(norm(v-u))^3

%posicion inicial + desplazamiento en un paso
X1(1,:)= condiciones_iniciales(1)+t*condiciones_iniciales(3);
X2(1,:)= condiciones_iniciales(2)+t*condiciones_iniciales(4);
K2=condiciones_iniciales(3);
%metodo euler mejorado
for n=1:length(T)-1
  R1(n,:)=X1(n,:)+t^2*P(X1(n,:),X2(n,:),M(1));
  R2(n,:)=X2(n,:)-t^2*P(X1(n,:),X2(n,:),M(2));

  X1(n+1,:)=X1(n,:)+t^2*0.5*(P(X1(n,:),X2(n,:),M(1))+P(R1(n,:),R2(n,:),M(1)));
  X2(n+1,:)=X2(n,:)-t^2*0.5*(P(X1(n,:),X2(n,:),M(2))+P(R1(n,:),R2(n,:),M(2)));

  K2(n+1,:)=K2(n,:)-t*0.5*(P(X1(n,:),X2(n,:),M(2))+P(R1(n,:),R2(n,:),M(2))); %Actualizar velocidades
endfor

plot3(X2(:,1),X2(:,2),X2(:,3),'LineWidth',2)
hold on;
plot3(X1(:,1),X1(:,2),X1(:,3),'LineWidth',2,'r')
h=legend({"Objeto 1", "Objeto 2"})

