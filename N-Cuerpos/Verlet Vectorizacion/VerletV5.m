function [XN]=VerletV5(XN,V,M,C,T)
tic
XN(2,:,:)=XN-V*T(1)+0.5*G3N(XN,M)*T(1)^2; %actualizar tensor posiciones para n=-1
for n=2:length(T)       %Integrador de posiciones de Verlet
    XN(n+1,:,:)=XN(n,:,:)*(1+C(n-1))-XN(n-1,:,:)*C(n-1)+G3N(XN(n,:,:),M)*(T(n)-T(n-1))*T(n)/2 ;%actualizar tensor posiciones
endfor
toc
endfunction
