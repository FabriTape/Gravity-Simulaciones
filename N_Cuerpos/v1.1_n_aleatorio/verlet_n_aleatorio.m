% verlet_n_aleatorio.m - N cuerpos aleatorios con Velocity Verlet
% Metodo: Verlet con matrix anti-simetrica para fuerza gravitatoria
% Cuerpos: 50 (masas y posiciones Gaussianas, velocities=0)
%
% Uso: octave verlet_n_aleatorio

tic
clear all;  clc;
t=3600*24;             %timestep (21,9 horas aprox.)
T=(0:t:300*t);       %vector de tiempo (0s:t:tiempo final)

X=datos_iniciales_aleatorios(2,50);         %posiciones iniciales de las particulas
V=zeros(size(X));    %velocidades iniciales de las particulas
M=datos_iniciales_aleatorios(1,50);         %masas de las particulas

A=aceleracion_antisimetrica(X(1,:,:),M);    %Vector aceleraciones en t=0

for n=1:length(T)-1   %Integrador de velocidades de Verlet

    X(n+1,:,:)=X(n,:,:)+(V(n,:,:)+0.5*t*A)*t; %actualizar tensor posiciones

    B=aceleracion_antisimetrica(X(n+1,:,:),M); %actualizar aceleraciones para la posicion X(n+1)

    V(n+1,:,:)=V(n,:,:)+(B+A)*0.5*t; %actualizar tensor velocidad ffffffiiiiuumba

    A=B;
endfor

toc
#clf;
#graficador_orbitas(X,V,M,T,1) #NO FUNCIONA, AUN...
