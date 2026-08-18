function [E]=ErrorAnalisysV2(XN,M,V,T)
A=G2N(XN(1,:,:),M);
l=1;
E1=EmyNoetherV2(V(1,:,:),XN(1,:,:),M);
E=abs(EmyNoetherV2(V(1,:,:),XN(1,:,:),M)-E1)./E1;

for n=1:length(XN)-1
    B=G2N(XN(n+1,:,:),M);
    V(n+1,:,:)=V(n,:,:)+(B+A)*0.5*T(n);
    A=B;
    E(l,:)=abs(EmyNoetherV2(V(n+1,:,:),XN(n+1,:,:),M)-E1)./E1*100;
    l=l+1;
endfor
endfunction
