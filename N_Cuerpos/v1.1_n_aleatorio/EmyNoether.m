function [K,U,P]=EmyNoether (V,X,M)
  g=6.67430e-11;  E=0; P=[0 0 0]; K=0;

for i=1:length(M)
  o(i)=0.5*M(i)*norm(V(1,:,i))^2/g;
endfor
  K=sum(o)


for j=1:length(M)
  for i=1:length(M)
     if i<j
       A(i,j)=-M(i)/norm(X(1,:,i)-X(1,:,j));
     else
       A(i,j)=0;
     endif
  endfor
endfor
  U=sum(M'*A)*1/g


for i=1:length(M)
  P=P+M(i)*V(1,:,i);
endfor
  P=norm(P)
endfunction
