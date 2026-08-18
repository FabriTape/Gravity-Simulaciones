% graficador_orbitas.m - Grafico 3D de orbitas planetarias
% Parametros: X (tensor posiciones), V (tensor velocidades), M (masas), T (tiempo), s (modo)
%
% Uso: graficador_orbitas(X, V, M, T, 1)

function []=Graficador(X,V,M,T,g)
  for n=1:length(T)
    U(n)=conservacion(X(n,:,:),M(:),1); %Energia potencial gravitatoria
    K(n)=conservacion(V(n,:,:),M(:),2); %energia cinética
    EE(n)=abs((U(n)+K(n)-(U(1)+K(1)))/(U(n)+K(n)))*100; %Error energia
    E(n)=(U(n)+K(n)); %energia total
    P(n)=abs((conservacion(V(n,:,:),M(:),3)-conservacion(V(1,:,:),M(:),3))/conservacion(V(n,:,:),M(:),3))*100 ;%error momento lineal
    CX(n)=(M(1)*norm(V(n,:,1))+M(2)*norm(V(n,:,2)))/sum(M);
  endfor
subplot(2,2,2);
  plot(T,K,'LineWidth',1,'r') %grafico de la energia cinética vs t
  hold on;
  plot(T,U,'LineWidth',1,'b') %grafico de la energia potencial vs t
  plot(T,E,'LineWidth',2,'g') %grafico de la energia del sistema vs t
  xlabel ("t[seg.]"); ylabel ("E[J]");
  h=legend({"Energía cinética", "Energia potencial", "Energia total"})

subplot(2,2,4);
  plot(T,P,'LineWidth',2,'g') %grafico del error momento del sistema vs t
  hold on;
  plot(T,EE,'LineWidth',2,'r') %grafico del error energetico del sistema vs t
  xlabel ("t[seg.]"); ylabel ("Error [%]");
  h=legend({"error reltativo del momento","error reltativo de la energía"})

subplot(1,2,1);
CM=[0,0,0];
  switch g
    case {1}
      axis("equal");
      for j=1:length(M)
        CM=CM+M(j)*X(:,:,j)/sum(M(:));
      endfor
      hold on;
        plot3(X(:,1,1),X(:,2,1),X(:,3,1),"oy")                                %Sol

        plot3(X(:,1,2),X(:,2,2),X(:,3,2),"o","MarkeredgeColor","#97A1AA")     %Mercurio
        plot3(X(:,1,3),X(:,2,3),X(:,3,3),"o","MarkeredgeColor","#FF9B00")     %Venus
        plot3(X(:,1,4),X(:,2,4),X(:,3,4),"ob")                                %Tierra
        plot3(X(:,1,5),X(:,2,5),X(:,3,5),"oc","markersize",3)                 %Luna
        plot3(X(:,1,6),X(:,2,6),X(:,3,6),"o","MarkeredgeColor","#f16b39")     %Marte

#        plot3(X(:,1,7),X(:,2,7),X(:,3,7),"o","MarkeredgeColor","#c5b22f")     %Jupiter
#        plot3(X(:,1,8),X(:,2,8),X(:,3,8),"o","MarkeredgeColor","#ffef7e")     %Saturno
#        plot3(X(:,1,9),X(:,2,9),X(:,3,9),"o","MarkeredgeColor","#463b99")     %Urano
#        plot3(X(:,1,10),X(:,2,10),X(:,3,10),"o","MarkeredgeColor","#463b99")  %Neptuno

#        plot3(X(:,1,11),X(:,2,11),X(:,3,11),"o","MarkeredgeColor","#044e55")  %Pluto
        plot3(CM(:,1),CM(:,2),CM(:,3),"o-black")
      xlabel ("x[m]"); ylabel ("y[m]"); zlabel ("z[m]");
      h=legend({"Sol","Mercurio","Venus","Tierra","Luna","Marte","Júpiter","Saturno","Urano","Neptuno","Pluto","Centro de masas"})

    case {2}
      axis("equal");
        for j=1:length(M)
          CM=CM+M(j)*X(:,:,j)/sum(M(:));
         endfor
        for i=1:length(X)
          hold on;
          plot3(X(i,1,1),X(i,2,1),X(i,3,1),"oy")                                %Sol

          plot3(X(i,1,2),X(i,2,2),X(i,3,2),"o","MarkeredgeColor","#97A1AA")     %Mercurio
          plot3(X(i,1,3),X(i,2,3),X(i,3,3),"o","MarkeredgeColor","#FF9B00")     %Venus
          plot3(X(i,1,4),X(i,2,4),X(i,3,4),"ob")                                %Tierra
          plot3(X(i,1,5),X(i,2,5),X(i,3,5),"oc","markersize",3)                 %Luna
          plot3(X(i,1,6),X(i,2,6),X(i,3,6),"o","MarkeredgeColor","#f16b39")     %Marte

          plot3(X(i,1,7),X(i,2,7),X(i,3,7),"o","MarkeredgeColor","#c5b22f")     %Jupiter
          plot3(X(i,1,8),X(i,2,8),X(i,3,8),"o","MarkeredgeColor","#ffef7e")     %Saturno
          plot3(X(i,1,9),X(i,2,9),X(i,3,9),"o","MarkeredgeColor","#463b99")     %Urano
          plot3(X(i,1,10),X(i,2,10),X(i,3,10),"o","MarkeredgeColor","#463b99")  %Neptuno

          plot3(X(i,1,11),X(i,2,11),X(i,3,11),"o","MarkeredgeColor","#044e55")  %Pluto
          plot3(CM(i,1),CM(i,2),CM(i,3),"o-black")
          pause(1/(4*norm(V(i,:,5))))
        endfor
        xlabel ("x[m]"); ylabel ("y[m]"); zlabel ("z[m]");
        h=legend({"Sol","Mercurio","Venus","Tierra","Luna","Marte","Júpiter","Saturno","Urano","Neptuno","Pluto","Centro de masas"})
   endswitch
  endfunction
