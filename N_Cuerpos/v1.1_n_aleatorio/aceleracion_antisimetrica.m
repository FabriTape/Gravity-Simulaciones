% aceleracion_antisimetrica.m - Fuerza gravitatoria con matrix anti-simetrica
% Solo calcula pares i<j, luego usa O-O' para ambas direcciones
% Parametros: X (tensor posiciones), M (vector masas)
%
% Uso: A = aceleracion_antisimetrica(X, M)

function[A]=G2(X,M)

for j=1:length(M)
  for i=1:length(M)
    if i<j
      O(i,j,1:3)=(X(1,:,i)-X(1,:,j))/norm(X(1,:,i)-X(1,:,j))^3;
    else
      O(i,j,1:3)=0;
    endif
  endfor
endfor
# vector aceleracion para el progama VerletMEJORADO
A(1,1,:)=((O(:,:,1)-O(:,:,1)')*M);
A(1,2,:)=((O(:,:,2)-O(:,:,2)')*M);
A(1,3,:)=((O(:,:,3)-O(:,:,3)')*M);

# vector aceleracion para el progama Sistema-Solar Verlet
#A(1,1,:)=(M*(O(:,:,1)-O(:,:,1)'));
#A(1,2,:)=(M*(O(:,:,2)-O(:,:,2)'));
#A(1,3,:)=(M*(O(:,:,3)-O(:,:,3)'));
endfunction
