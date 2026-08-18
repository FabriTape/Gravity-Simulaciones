function [G]=EmyNoetherV2 (V,X,M)
g=6.67430e-11;
    S=ones(1,n,3).*M;
    A=S.*permute(S,[2,1,3])*g; #Cuidadito aca hay un tensor de producto de masas


m=diag(M).^(1/2);
vn=vecnorm(permute(V,[3,2,1]),2,1);
K=0.5*vn.^2*m/g;

U=ones(length(M),1,3).*X;
U=U-permute(U,[2,1,3]);
P=(vecnorm(U,2,3)+1);
P=dot(P.^-1,M/g,2);

H=sum(P)/g+K;
P=dot(vn,m/g);
G=[H P];
endfunction

