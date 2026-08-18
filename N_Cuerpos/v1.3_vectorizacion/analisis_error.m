% analisis_error.m - Analisis de error con reconstruccion de velocidad
% Reconstruye velocidades a partir de posiciones para calcular error de energia
% Parametros: XN (posiciones), M (masas), V (velocidades iniciales), T (tiempo)
%
% Uso: E = analisis_error(XN, M, V, T)
function [E]=analisis_error(XN,M,V,T)
A=fuerza_g2n(XN(1,:,:),M);
l=1;
E1=energia_momento(V(1,:,:),XN(1,:,:),M);
E=abs(energia_momento(V(1,:,:),XN(1,:,:),M)-E1)./E1;

for n=1:length(XN)-1
    B=fuerza_g2n(XN(n+1,:,:),M);
    V(n+1,:,:)=V(n,:,:)+(B+A)*0.5*T(n);
    A=B;
    E(l,:)=abs(energia_momento(V(n+1,:,:),XN(n+1,:,:),M)-E1)./E1*100;
    l=l+1;
endfor
endfunction
