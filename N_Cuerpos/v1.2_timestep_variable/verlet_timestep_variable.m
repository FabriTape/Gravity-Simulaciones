% verlet_timestep_variable.m - Verlet con timestep variable via coeficientes C(n)
% Metodo: x_{n+1} = x_n*(1+C(n-1)) - x_{n-1}*C(n-1) + a*T(n)^2
% Parametros: X (posiciones), V (velocidades), M (masas), C (razon dt(n)/dt(n-1)), T (vector tiempo)
%
% Uso: X = verlet_timestep_variable(X, V, M, C, T)

function [X]=VerletV3(X,V,M,C,T)
tic
A=aceleracion_antisimetrica(X(1,:,:),M);    %Vector aceleraciones en t=0
X(2,:,:)=X(1,:,:)-V(1,:,:)*T(1)+0.5*A*T(1)^2; %actualizar tensor posiciones para n=-1
for n=2:length(T)   %Integrador de posiciones de Verlet
    X(n+1,:,:)=X(n,:,:)*(1+C(n-1))-X(n-1,:,:)*C(n-1)+aceleracion_antisimetrica(X(n,:,:),M)*T(n)^2; %actualizar tensor posiciones
endfor
toc
endfunction
