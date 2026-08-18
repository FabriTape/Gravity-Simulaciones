% funcion_choque.m - Colision elastica entre 2 cuerpos
% Parametros: v1,v2 (velocidades), x1,x2 (posiciones), M1,M2 (masas), t (1 o 2)
% Coeficiente de restitucion: e=1 (elastica)
%
% Uso: V = funcion_choque(v1, v2, x1, x2, M1, M2, 1)

function[V]=funcion_choque(v1,v2,x1,x2,M1,M2,t)
e=1;
n=(x2-x1)/norm(x2-x1);
mr=(M1*M2)/(M1+M2);
vi=dot(n,(v1-v2));
J=(1+e)*mr*vi;
switch t
  case {1}
    V=v1-J/M1*n;
  case {2}
    V=v2+J/M2*n;
  endswitch
endfunction



