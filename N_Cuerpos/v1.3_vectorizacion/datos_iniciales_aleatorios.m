% datos_iniciales_aleatorios.m - Genera condiciones iniciales aleatorias
% Parametros: t (modo layout), e (tipo: 1=masas, 2=posiciones, 3=grilla), n (cantidad)
%
% Uso: A = datos_iniciales_aleatorios(1, 2, 50)
function [A] = datos_iniciales_aleatorios(t,e,n)
switch t
  case {1}
    switch e
  case {1}
     A=abs(randn(n,1)*7.89e24*6.67430e-11);#Parametro mu (G*M)

  case {2}
  A=randn(1,n,3)*120000000000;
  case {3}
    R=10; #Radio de esfera
    u=1;
    A(1,1,:)=[0 0 0];

     for k=1:n
      for i=1:n
        for j=1:n
         P(1,n^2*(k-1)+n*(i-1)+j,:)=[R*(-1+2*i/n),R*(-1+2*j/n),R*(-1+2*k/n)];
          #Dar una forma esferica
          if norm(P(1,:,n^2*(k-1)+n*(i-1)+j))<=R
            A(1,u,:)=P(1,n^2*(k-1)+n*(i-1)+j,:)*120000000000;
            u=u+1;
          endif
        endfor
      endfor
    endfor

  endswitch
  case {2}
    switch e

  case {1}
    A=abs(randn(n,1)*7.89e24*6.67430e-11);#Parametro mu (G*M)
  case {2}
  A=randn(1,3,n)*120000000000;
  case {3}
    R=10; #Radio de esfera
    u=1;
    A(1,:,1)=[0 0 0];

     for k=1:n
      for i=1:n
        for j=1:n
         P(1,:,n^2*(k-1)+n*(i-1)+j)=[R*(-1+2*i/n),R*(-1+2*j/n),R*(-1+2*k/n)];
          #Dar una forma esferica
          if norm(P(1,:,n^2*(k-1)+n*(i-1)+j))<=R
            A(1,:,u)=P(1,:,n^2*(k-1)+n*(i-1)+j)*120000000000;
            u=u+1;
          endif
        endfor
      endfor
    endfor

endswitch
endswitch
  endfunction
