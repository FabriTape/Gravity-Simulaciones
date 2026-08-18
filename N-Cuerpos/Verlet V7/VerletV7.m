function [XN]=VerletV7(XN,V,M,t,Iter)
tic
XN(2,:,:)=XN;
XN(1,:,:)=XN(2,:,:)-V*t+0.5*G4N(XN(2,:,:),M)*t^2;

for n=2:Iter       %Integrador de posiciones de Verlet
    XN(n+1,:,:)=2*XN(n,:,:)-XN(n-1,:,:)+G4N(XN(n,:,:),M)*t^2 ;%actualizar tensor posiciones
endfor
toc
endfunction
function[A]=G4N(X,M)
U=ones(length(M),1,3).*X;
U=U-permute(U,[2,1,3]);
P=(vecnorm(U,2,3)+1).^3;
A=-6.67430E-11*dot(U./P,M,1);
endfunction
