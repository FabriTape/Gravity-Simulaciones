function[A]=G2N(X,M)
g=6.67430e-11;


U=ones(length(M),1,3).*permute(X,[1,3,2])-ones(1,length(M),3).*permute(X,[3,1,2]);
P=(vecnorm(U,2,3)+1).^3;
A(1,1,:)=-(U(:,:,1)./P)*M;
A(1,2,:)=-(U(:,:,2)./P)*M;
A(1,3,:)=-(U(:,:,3)./P)*M;

#A(1,1,:)=-M*g*(U(:,:,1)./P);
#A(1,2,:)=-M*g*(U(:,:,2)./P);
#A(1,3,:)=-M*g*(U(:,:,3)./P);
endfunction
