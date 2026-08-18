clear
tic
X1(2,:)=[0 0 0];
X2(2,:)=[0.4055e9 0 0];
V1=[0 0 0];
V2=[0 970 0];
M=[5.9724e24 0.07346e24];
G=6.67430e-11;
dt=11664;   #Paso de integración
T=23328000;
N=T/dt;
function A = aceleracion(X1, X2, M)
    G = 6.67430e-11;
    r = norm(X1 - X2, 2);
    A = -G * (M(1) * M(2) / r^3) * (X2 - X1);
end
X1(1,:)=X1(2,:)-V1*dt-0.5*aceleracion(X1(2,:),X2(2,:),M)*dt^2/M(1);
X2(1,:)=X2(2,:)-V2*dt+0.5*aceleracion(X1(2,:),X2(2,:),M)*dt^2/M(2);
for i=2:N
  X1(i+1,:)=2*X1(i,:)-X1(i-1,:)-aceleracion(X1(i,:),X2(i,:),M)*dt^2/M(1);
  X2(i+1,:)=2*X2(i,:)-X2(i-1,:)+aceleracion(X1(i,:),X2(i,:),M)*dt^2/M(2);
end
toc
plot3(X1(:,1),X1(:,2),X1(:,3),'o')
hold on
plot3(X2(:,1),X2(:,2),X2(:,3),'o')
