% conservacion.m - Verifica conservacion de energia y momento
% Parametros: V,X (tensores), M (masas)
% Retorna: energia potencial, cinetica, momento
%
% Uso: [K,U,P] = conservacion(V, X, M)

function[W]=Noether(x,M,e)
g=6.67430e-11; %masa en Kg
W=0;
L=[0,0,0];
switch e
  case{1}
  for i=1:length(M)
    for j=1:length(M)
      if j<i
        W=W-g*M(i)*M(j)/norm(x(:,:,j)-x(:,:,i)); %energia potencial
      endif
     endfor
  endfor
  case{2}
  for i=1:length(M)
    W=W+0.5*M(i)*norm(x(:,:,i))^2;%energia cinetica
  endfor
  case{3}
  for i=1:length(M)
    L=L+M(i)*x(:,:,i); %conservacion del momento del sistema
  endfor
  W=norm(L);
endswitch
endfunction
