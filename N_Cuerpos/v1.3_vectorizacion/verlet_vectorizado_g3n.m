% verlet_vectorizado_g3n.m - Velocity Verlet usando fuerza G3N (compacta)
% Metodo: Verlet vectorizado con dot product en una sola linea
% Fórmula de timestep mejorada: (T(n)-T(n-1))*T(n)/2
%
% Uso: XN = verlet_vectorizado_g3n(XN, V, M, C, T)
function [XN]=verlet_vectorizado_g3n(XN,V,M,C,T)
tic
XN(2,:,:)=XN-V*T(1)+0.5*fuerza_g3n(XN,M)*T(1)^2;
for n=2:length(T)
    XN(n+1,:,:)=XN(n,:,:)*(1+C(n-1))-XN(n-1,:,:)*C(n-1)+fuerza_g3n(XN(n,:,:),M)*(T(n)-T(n-1))*T(n)/2;
endfor
toc
endfunction
