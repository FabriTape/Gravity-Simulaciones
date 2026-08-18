tic
clear all;  clc;
t=78894; %timestep
T=(0:t:5*365*t); %vector de tiempo (0s:t:tiempo final)
X=InitialRot(1); %posiciones iniciales de las particulas
V=InitialRot(2); %velocidades iniciales de las particulas
M=InitialRot(3); %masas de las particulas

b=0; %dirección del tiempo, b=0 adelante, b=1 atras

for n=1:length(T)-1   %Integrador de velocidades de Verlet
    X(n+1,:,:)=X(n,:,:)+(-1)^b*V(n,:,:)*t+0.5*t*t*G(X(n,:,:),M); %actualizar tensor posiciones
    V(n+1,:,:)=V(n,:,:)+(-1)^b*(G(X(n,:,:),M)+G(X(n+1,:,:),M))*0.5*t; %actualizar tensor velocidad
endfor
toc
clf;
Graficador(X,V,M,T,1)
