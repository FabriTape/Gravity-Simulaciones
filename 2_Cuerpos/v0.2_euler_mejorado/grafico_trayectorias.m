% grafico_trayectorias.m - Grafico 3D de trayectorias de 2 cuerpos
% Parametros: u (tensor posiciones), M1, M2 (masas)
%
% Uso: grafico_trayectorias(X, M1, M2)

  function[]=grafico_trayectorias(u,M1,M2)
##CX(:,:)=(M1*u(:,:)+M2*v(:,:))/(M1+M2);
##for i=1:length(u)
axis("equal");
  hold on
  plot3(u(:,1,1),u(:,2,1),u(:,3,1),"o") %grafico de la trayectoria de la particula 1
  plot3(u(:,1,2),u(:,2,2),u(:,3,2),"o") %grafico de la trayectoria de la particula 2
##  plot3(CX(:,1),CX(:,2),CX(:,3),"black")
##pause(0.0001);
##endfor
xlabel ("x[m]");
ylabel ("y[m]");
zlabel ("z[m]");
h=legend({"Tierra","Luna"})

  endfunction
