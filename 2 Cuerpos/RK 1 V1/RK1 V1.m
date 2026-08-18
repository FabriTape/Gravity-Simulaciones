clc
t=0.1 %paso del tiempo;
tf=700 %tiempo final;
T=(0:t:tf)';
%condiciones iniciales del sistema (momento y posición)
X1=[0 1 0];
X2=[0 0 0];

P1=[1.9853*10^(-7) 0 0];
P2=[0 0 0];

%constantes
G=1.18095*10^(-11);
M1=10000;
M2=33295;
for n=1:length(T)-1
  X1(n+1,:)=X1(n,:)+(t/M1)*P1(n,:);
  X2(n+1,:)=X2(n,:)+(t/M2)*P2(n,:);
  P1(n+1,:)=P1(n,:)+G*M2*M1*t*(X2(n+1,:)-X1(n+1,:))/(norm(X2(n+1,:)-X1(n+1,:)))^3;
  P2(n+1,:)=P2(n,:)-G*M1*M2*t*(X2(n+1,:)-X1(n+1,:))/(norm(X2(n+1,:)-X1(n+1,:)))^3;
endfor
plot3(X1(:,1),X1(:,2),X1(:,3),"o--b")
hold
plot3(X2(:,1),X2(:,2),X2(:,3),"o--r")
