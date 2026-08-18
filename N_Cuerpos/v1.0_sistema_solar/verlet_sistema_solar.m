% verlet_sistema_solar.m - Simulacion del sistema solar (11 cuerpos) con Velocity Verlet
% Metodo: Velocity Verlet con loops para calculo de fuerzas
% Cuerpos: 11 (Sol, Mercurio, Venus, Tierra, Luna, Marte, Jupiter, Saturno, Urano, Neptuno, Pluton)
%
% Uso: octave verlet_sistema_solar

tic
clear all;  clc;
t=78894; %timestep
T=(0:t:5*365*t); %vector de tiempo (0s:t:tiempo final)
X=condiciones_iniciales_solar(1); %posiciones iniciales de las particulas
V=condiciones_iniciales_solar(2); %velocidades iniciales de las particulas
M=condiciones_iniciales_solar(3); %masas de las particulas

b=0; %dirección del tiempo, b=0 adelante, b=1 atras

for n=1:length(T)-1   %Integrador de velocidades de Verlet
    X(n+1,:,:)=X(n,:,:)+(-1)^b*V(n,:,:)*t+0.5*t*t*aceleracion_gravitatoria(X(n,:,:),M); %actualizar tensor posiciones
    V(n+1,:,:)=V(n,:,:)+(-1)^b*(aceleracion_gravitatoria(X(n,:,:),M)+aceleracion_gravitatoria(X(n+1,:,:),M))*0.5*t; %actualizar tensor velocidad
endfor
toc
clf;
graficador_orbitas(X,V,M,T,1)
