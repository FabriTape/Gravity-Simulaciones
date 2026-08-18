clearvars;
tic
t=11664;
T=[0:t:2332800*10];

%condiciones iniciales
X(1,:,1)=CondIn(1); X(1,:,2)=CondIn(2); M1=5.9722e24;
V(1,:,1)=CondIn(3); V(1,:,2)=CondIn(4); M2=0.07346e24;

for n=1:length(T)-1   %nuevas pocisiones de las particulas

  X(n+1,:,1)=X(n,:,1)+V(n,:,1)*t+0.5*t*t*FAnonimas(X(n,:,1),X(n,:,2),M1,M2,1);
  X(n+1,:,2)=X(n,:,2)+V(n,:,2)*t+0.5*t*t*FAnonimas(X(n,:,2),X(n,:,1),M1,M2,2);

    V(n+1,:,1)=V(n,:,1)+(FAnonimas(X(n,:,1),X(n,:,2),M1,M2,1)+FAnonimas(X(n+1,:,1),X(n+1,:,2),M1,M2,1))*0.5*t;
    V(n+1,:,2)=V(n,:,2)+(FAnonimas(X(n,:,2),X(n,:,1),M1,M2,2)+FAnonimas(X(n+1,:,2),X(n+1,:,1),M1,M2,2))*0.5*t;

endfor
for n=1:length(T)

  U(n)=FAnonimas(X(n,:,1),X(n,:,2),M1,M2,4);
  K(n)=FAnonimas(V(n,:,1),V(n,:,2),M1,M2,3);
  E(n)=U(n)+K(n);
  P(n)=(FAnonimas(V(n,:,1),V(n,:,2),M1,M2,5)-FAnonimas(V(1,:,1),V(1,:,2),M1,M2,5))/FAnonimas(V(n,:,1),V(n,:,2),M1,M2,5);

endfor
toc
  TrayParticulas(X(:,:,:),M1,M2);
##Graficas(2,T,K,U,E,P)
