% energia_momento.m - Hamiltoniano y momento del sistema N cuerpos
% Parametros: V,X (tensores), M (masas), c (1=Hamiltoniano, 2=momento)
%
% Uso: H = energia_momento(V, X, M, 1)

function [H]=EmyNoether (V,X,M,e)
tic
  g=6.67430e-11;  P=[0 0 0]; K=0;
switch e

  case{1}

    for j=1:length(M)
      K=K+0.5*M(j)*norm(V(1,:,j))^2/g;

      for i=1:length(M)
         if i<j
           U(i,j)=-M(i)/norm(X(1,:,i)-X(1,:,j));
          else
           U(i,j)=0;
         endif
      endfor

    endfor
      H=sum(M'*U)*1/g+K;
tocE

  case{2}
    for i=1:length(M)
      P=P+M(i)*V(1,:,i)/g;
    endfor
      H=norm(P);

endswitch
endfunction
