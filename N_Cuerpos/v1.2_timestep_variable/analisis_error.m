% analisis_error.m - Analisis de error de energia y momento
% Usa transformacion arctan: 2*atan(E/E0) - pi/2 para mapear a [0,1]
% Parametros: X (posiciones), M (masas), V (velocidades), q (pasos), t (dt)
%
% Uso: [EE, EP] = analisis_error(X, M, V, q, t)

A=aceleracion_antisimetrica(X(1,:,:),M);
for n=1:q-1

    B=aceleracion_antisimetrica(X(n+1,:,:),M);

    V(n+1,:,:)=V(n,:,:)+(B+A)*0.5*t;

    A=B;
endfor
l=1;
for i=1:q
  if i~=2
    EE(l)=abs(2*atan(energia_momento(V(i,:,:),X(i,:,:),M,1)/energia_momento(V(1,:,:),X(1,:,:),M,1))-pi/2);
    EP(l)=abs(2*atan(energia_momento(V(i,:,:),X(i,:,:),M,2)/energia_momento(V(1,:,:),X(1,:,:),M,2))-pi/2);
    l=l+1;
  endif
endfor
