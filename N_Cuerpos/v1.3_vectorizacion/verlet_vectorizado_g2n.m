% verlet_vectorizado_g2n.m - Velocity Verlet usando fuerza G2N
% Metodo: Verlet vectorizado con fuerza por componentes (permute + vecnorm)
% Parametros: XN (posiciones), V (velocidades), M (masas), C (razon dt), T (tiempo)
%
% Uso: XN = verlet_vectorizado_g2n(XN, V, M, C, T)
function [XN]=verlet_vectorizado_g2n(XN,V,M,C,T)
tic
XN(2,:,:)=XN-V*T(1)+0.5*fuerza_g2n(XN,M)*T(1)^2;
for n=2:length(T)
    XN(n+1,:,:)=XN(n,:,:)*(1+C(n-1))-XN(n-1,:,:)*C(n-1)+fuerza_g2n(XN(n,:,:),M)*T(n)^2;
endfor
toc
endfunction
