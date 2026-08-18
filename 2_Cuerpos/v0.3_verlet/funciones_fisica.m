% funciones_fisica.m - Funciones de fuerza, energia y momento del sistema 2 cuerpos
% Parametros: u,v (vectores), m,M (masas), e (tipo: 1=fuerza1, 2=fuerza2, 3=cinetica, 4=potencial, 5=momento)
%
% Uso: W = funciones_fisica(u, v, m, M, e)

function[W]=funciones_fisica(u,v,m,M,e)
G=6.67430e-11; %masa en Kg
switch e
  case{1}
W=G*M*((v-u)/(norm(v-u))^3); %ley de newton para la masa m
  case{2}
W=G*m*((v-u)/(norm(v-u))^3); %ley de newton para la masa M
  case{3}
W=0.5*(m*norm(u)^2+M*norm(v)^2);%energia cinetica
  case{4}
W=-2*G*m*M/norm(v-u); %energia potencial
  case{5}
W=(m*norm(u)+M*norm(v))/(M+m); %conservacion del momento del sistema
endswitch
endfunction
