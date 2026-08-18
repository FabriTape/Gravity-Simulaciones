% fuerza_g3n.m - Fuerza gravitatoria vectorizada compacta
% Usa: dot(U./P, M, 1) en una sola expresion
% Parametros: X (tensor posiciones), M (vector masas)
%
% Uso: A = fuerza_g3n(X, M)
function[A]=fuerza_g3n(X,M)
g=6.67430e-11;
U=ones(length(M),1,3).*X;
U=U-permute(U,[2,1,3]);
P=(vecnorm(U,2,3)+1).^3;
A=dot(U./P,ones(1,length(M),3).*M,1);
endfunction
