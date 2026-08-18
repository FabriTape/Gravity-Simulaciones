% verlet_vectorizado_embebido.m - Velocity Verlet con G4N embebida
% Metodo: Verlet vectorizado con funcion de fuerza integrada
% Mas autocontenida: no necesita archivos externos de fuerza
%
% Uso: XN = verlet_vectorizado_embebido(XN, V, M, C, T)
function [XN]=verlet_vectorizado_embebido(XN,V,M,C,T)
tic
XN(2,:,:)=XN-V*T(1)+0.5*G4N(XN,M)*T(1)^2;
for n=2:length(T)
    XN(n+1,:,:)=XN(n,:,:)*(1+C(n-1))-XN(n-1,:,:)*C(n-1)+G4N(XN(n,:,:),M)*(T(n)-T(n-1))*T(n)/2;
endfor
toc
endfunction
function[A]=G4N(X,M,n)
g=6.67430e-11;
U=ones(length(M),1,3).*X;
U=U-permute(U,[2,1,3]);
P=(vecnorm(U,2,3)+1).^3;
A=dot(U./P,M/g,1);
endfunction
