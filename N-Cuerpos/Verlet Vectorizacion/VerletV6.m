function [XN]=VerletV6(XN,V,M,C,T)
tic
XN(2,:,:)=XN-V*T(1)+0.5*G4N(XN,M)*T(1)^2; %actualizar tensor posiciones para n=-1
for n=2:length(T)       %Integrador de posiciones de Verlet
    XN(n+1,:,:)=XN(n,:,:)*(1+C(n-1))-XN(n-1,:,:)*C(n-1)+G4N(XN(n,:,:),M)*(T(n)-T(n-1))*T(n)/2 ;%actualizar tensor posiciones
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
