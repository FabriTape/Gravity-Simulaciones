% condiciones_iniciales.m - Retorna condiciones iniciales del sistema Tierra-Luna
% Parametros: s (1=posTierra, 2=posLuna, 3=velTierra, 4=velLuna, 5=masas)
%
% Uso: V = condiciones_iniciales(1)

function[V]=condiciones_iniciales(s)
X1=[0,0,0];%posiciones iniciales de las particulas
X2=[0.4055e9,0,0];

V1=[0,0,0];%velocidades iniciales de las particulas
V2=[0,970,0];

M=[5.9722e24 0.07346e24];%Vector de masas del sistema
switch s
  case{1}
    V=X1;
  case{2}
    V=X2;
  case{3}
    V=V1;
  case{4}
    V=V2;
  case{5}
    V=M;
endswitch

