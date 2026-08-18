% euler_mejorado_choques.m - Euler Mejorado con deteccion de choques elasticos
% Metodo: Euler Mejorado + colision elastica (e=1)
% Cuerpos: 2 (Tierra-Luna)
% Incluye: conservacion de energia y momento lineal
%
% Uso: octave euler_mejorado_choques

clear all; clf;
t=11664; T=(0:t:2332800)';

%condiciones iniciales
X1(1,:)=condiciones_iniciales(1); X2(1,:)=condiciones_iniciales(2); M1=5.9722e24;
V1(1,:)=condiciones_iniciales(3); V2(1,:)=condiciones_iniciales(4); M2=0.07346e24;

%metodo euler mejorado
for n=1:length(T)-1

  O1(n,:)=X1(n,:)+V1(n,:)*t;
  O2(n,:)=X2(n,:)+V2(n,:)*t;

  d=norm(O2(n,:)-O1(n,:)); %distancia radial entre el centro de las particulas

  if d<0.7 %condicion de choque (suma de los radios de ambas particulas)

    V1(n+1,:)=funcion_choque(V1(n,:),V2(n,:),O1(n,:),O2(n,:),M1,M2,1);
    V2(n+1,:)=funcion_choque(V1(n,:),V2(n,:),O1(n,:),O2(n,:),M1,M2,2);

   else

    V1(n+1,:)=V1(n,:)+(funciones_fisica(O1(n,:),O2(n,:),M1,M2,1)+funciones_fisica(X1(n,:),X2(n,:),M1,M2,1))*0.5*t;
    V2(n+1,:)=V2(n,:)-(funciones_fisica(O1(n,:),O2(n,:),M1,M2,2)+funciones_fisica(X1(n,:),X2(n,:),M1,M2,2))*0.5*t;

  endif

  %nuevas pocisiones de las particulas
  X1(n+1,:)=X1(n,:)+(V1(n,:)+V1(n+1,:))*0.5*t;
  X2(n+1,:)=X2(n,:)+(V2(n,:)+V2(n+1,:))*0.5*t;



  %cantidades fisicas del sistema (energia y momento)
  U(n+1)=funciones_fisica(X1(n+1,:),X2(n+1,:),M1,M2,4); K(n+1)=funciones_fisica(V1(n+1,:),V2(n+1,:),M1,M2,3);
  E(n+1)=U(n+1)+K(n+1); P(n+1)=funciones_fisica(V1(n+1,:),V2(n+1,:),M1,M2,5);
endfor

X(:,:,1)=X1;
X(:,:,2)=X2;

grafico_trayectorias(X,M1,M2)

##graficos_energia(1,T,K,U,E,P) %Grafica de energia
##graficos_energia(2,T,K,U,E,P) %Grafica del momento
