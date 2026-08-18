function[P]=InitialRot(s)
##Rotacion del perihelio (ángulo tita)
T=[0 -56.879 -31.121 0 0 200.33 87.541 250.277 12.9610 171.031 27.274];

##Declinacion de la órbita (ángulo alfa)
A=[0,7,3.4,0,5.1,1.8,1.3,2.5,0.8,1.8,17.2];

%posiciones iniciales de las particulas
X(1,:,1)=[0,0,0];           V(1,:,1)=[3.9923,0.2056,00]; #Sol
X(1,:,2)=[69.818e9,0,0];    V(1,:,2)=[0,38860,0]; #Mercurio
X(1,:,3)=[108.941e9,0,0];   V(1,:,3)=[0,34790,00]; #Venus
X(1,:,4)=[152.1e9,0,0];     V(1,:,4)=[0,29240,0 ];%Tierra
X(1,:,5)=[1.5251e11,0,0];   V(1,:,5)=[0,970+29240,00]; #Luna
X(1,:,6)=[249.261e9,0,0];   V(1,:,6)=[0,21970,0];#Marte
X(1,:,7)=[816.363e9,0,0];   V(1,:,7)=[0,12440,0];#Júpiter
X(1,:,8)=[1506.527e9,0,0];  V(1,:,8)=[0,9090,0];#Saturno
X(1,:,9)=[3001.390e9,0,0];  V(1,:,9)=[0,6490,0];#Urano
X(1,:,10)=[4558.857e9,0,0]; V(1,:,10)=[0,5370,0];#Neptuno
X(1,:,11)=[7304.326e9,0,0]; V(1,:,11)=[0,3710,0];#Pluto
M=0;
M(1)= 1988500e24; #Masa en Kg
M(2)= 0.33010e24;
M(3)=  4.8673e24;
M(4)=  5.9722e24;
M(5)= 0.07346e24;
M(6)= 0.64169e24;
M(7)= 1898.13e24;
M(8)=  568.32e24;
M(9)=  86.811e24;
M(10)=102.409e24;
M(11)=0.01303e24;
##Transformacion de los vectores posicion y velocidad segun alfa y tita
switch s
  case{1}
    for i=1:length(M)
      if i~=5
        P(1,1,i)=norm(X(1,:,i))*cosd(A(i))*cosd(T(i)); #transformacion para todos los cuerpos menos para la Luna
        P(1,2,i)=norm(X(1,:,i))*cosd(A(i))*sind(T(i));
        P(1,3,i)=norm(X(1,:,i))*sind(A(i));
      else
        P(1,1,5)=norm(X(1,:,4))+norm(X(1,:,4)-X(1,:,5))*cosd(A(5))*cosd(T(5)); #Transformacion para la Luna
        P(1,2,5)=norm(X(1,:,4)-X(1,:,5))*cosd(A(5))*sind(T(5));
        P(1,3,5)=norm(X(1,:,4)-X(1,:,5))*sind(A(5));
      endif
    endfor
  case{2}
    for i=1:length(M)
      P(1,1,i)=-(V(1,2,i))*sind(T(i));
      P(1,2,i)=V(1,2,i)*cosd(T(i));
      P(1,3,i)=V(1,3,i);
    endfor
  case{3}
    P=M;
endswitch

