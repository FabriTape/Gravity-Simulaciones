% analisis_error.m - Analisis de error con reconstruccion de velocidad
% Reconstruye velocidades a partir de posiciones para calcular error de energia
% Parametros: XN (posiciones), M (masas), V (velocidades iniciales), T (tiempo)
%
% Uso: E = analisis_error(XN, M, V, T)
function [E]=analisis_error(XN,M,V,T)
A=G4N(XN(1,:,:),M);
l=1;
E1=energia_momento(V(1,:,:),XN(1,:,:),M(:,:,1));
E=abs(energia_momento(V(1,:,:),XN(1,:,:),M(:,:,1))-E1)./E1;

for n=1:length(XN)-1
    B=G4N(XN(n+1,:,:),M);
    V(n+1,:,:)=V(n,:,:)+(B+A)*0.5*T(n);
    A=B;
    E(l,:)=abs(energia_momento(V(n+1,:,:),XN(n+1,:,:),M(:,:,1))-E1)./E1*100;
    l=l+1;
endfor
endfunction
function[A]=G4N(X,M)
g=6.67430e-11;
U=ones(length(M),1,3).*X;
U=U-permute(U,[2,1,3]);
P=(vecnorm(U,2,3)+1).^3;
A=-dot(U./P,M,1);
endfunction
