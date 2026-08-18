function [X]=VerletV3(X,V,M,C,T)
tic
A=G2(X(1,:,:),M);    %Vector aceleraciones en t=0
X(2,:,:)=X(1,:,:)-V(1,:,:)*T(1)+0.5*A*T(1)^2; %actualizar tensor posiciones para n=-1
for n=2:length(T)   %Integrador de posiciones de Verlet
    X(n+1,:,:)=X(n,:,:)*(1+C(n-1))-X(n-1,:,:)*C(n-1)+G2(X(n,:,:),M)*T(n)^2; %actualizar tensor posiciones
endfor
toc
endfunction
