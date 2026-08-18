% aceleracion_gravitatoria.m - Fuerza gravitatoria N-cuerpos con softening
% Parametros: X (tensor posiciones), M (vector masas)
% Softening: +1 en denominador para evitar singularidades
%
% Uso: A = aceleracion_gravitatoria(X, M)

function[a]=G(u,M)
g=6.67430e-11; %Constante G en [S.I.]

a=zeros(size(u));
G=[0,0,0];
for i=1:length(M)
  for j=1:length(M)
    a(1,:,i)=a(1,:,i)+g*M (j)*(u(:,:,j)-u(:,:,i))/(1+norm(u(:,:,j)-u(:,:,i)))^3; %aceleracion de la gravedad newtoniana
  endfor
endfor
endfunction
