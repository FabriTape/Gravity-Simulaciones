A=G2(X(1,:,:),M);
for n=1:q-1

    B=G2(X(n+1,:,:),M);

    V(n+1,:,:)=V(n,:,:)+(B+A)*0.5*t;

    A=B;
endfor
l=1;
for i=1:q
  if i~=2
    EE(l)=abs(2*atan(EmyNoether(V(i,:,:),X(i,:,:),M,1)/EmyNoether(V(1,:,:),X(1,:,:),M,1))-pi/2);
    EP(l)=abs(2*atan(EmyNoether(V(i,:,:),X(i,:,:),M,2)/EmyNoether(V(1,:,:),X(1,:,:),M,2))-pi/2);
    l=l+1;
  endif
endfor
