% energia_momento.m - Energia y momento vectorizado (V2)
% Parametros: V (velocidades), X (posiciones), M (masas)
% Retorna: [H, P] (Hamiltoniano y momento)
%
% Uso: G = energia_momento(V, X, M)
function [G]=energia_momento(V,X,M)
g=6.67430e-11;
vn=vecnorm(permute(V,[2,3,1]),2,1);
K=0.5*vn.^2*M/g;
L=ones(length(M),1).*permute(X,[1,3,2]);
Q=L-permute(L,[2,1,3]);
P=(vecnorm(Q,2,3)+1).^-1-eye(length(M));

H=sum(M'*P)/g+K;
P=dot(vn,M/g);
G=[H P];
endfunction
