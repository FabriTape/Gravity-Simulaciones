n=600;
for i=1:752
  Rij = repmat(M(i,:,:),n,1) - repmat(permute(M(i,:,:),[2,1,3]),1,n);
  tij = vecnorm(Rij,2,3)+1-eye(n);
  Reord = sort(tij);
  desv = std(Reord(2:end,:),1,1);
  promedio = mean(Reord(2:end,:),1);
  Recorte = abs(tij - repmat(promedio,n,1));
  Recorte(Recorte <= 2*desv) = -1;
  Recorte(Recorte ~= -1) = 0;
  Recorte(eye(n)==1) = 0;
  Densidad(i,:)=-0.0298*sum(Recorte,1)./(desv.^3);
end
Datos=permute(M,[2,3,1]);

Dens=permute(Densidad,[2,3,1]);
Dat=cat(2,Datos,Dens);

out_dir = "gravity";
mkdir (out_dir);
for i = 1:ceil(Integracion/Paso)+2
    scatter3(Dat(:,1,i),Dat(:,2,i),Dat(:,3,i),16,Dat(:,4,i),'filled');
    axis([min(Dat(:,1,i))-0.1, max(Dat(:,1,i))+0.1, min(Dat(:,2,i))-0.1, max(Dat(:,2,i))+0.1, min(Dat(:,3,i))-0.1, max(Dat(:,3,i))+0.1]);
    colorbar;
  fname = fullfile (out_dir, sprintf ("img%03i.png", i));
  imwrite (getframe (gcf).cdata, fname);
endfor



#
#for i=2:752
#    axis([min(M(i,:,1))-5 max(M(i,:,1))+5
#          min(M(i,:,2))-5 max(M(i,:,2))+5
#          min(M(i,:,3))-5 max(M(i,:,3))+5]);  % Ajustar los límites del gráfico
#    scatter3(Dat(:,1,1),Dat(:,2,1),Dat(:,3,1),16,Dat(:,4,1),'filled');
#    xlabel('EjeX');
#    ylabel('EjeY');
#    zlabel('EjeZ');
#    title(['Paso de tiempo: ' num2str(i)]);
#    view(i,30+15*sind(i/60))
#end
#for i =1:752
#  Rij = repmat(M(i,:,:),n,1) - repmat(permute(M(i,:,:),[2,1,3]),1,n);
#
#  tij = vecnorm(Rij,2,3)+1-eye(n);
#
#  Reord = sort(tij);
#  desv = std(Reord(2:end,:),1,1);
#  promedio = mean(Reord(2:end,:),1);
#
#  Recorte = abs(tij - repmat(promedio,n,1));
#  Recorte(Recorte <= 2*desv) = -1;
#  Recorte(Recorte ~= -1) = 0;
#  Recorte(eye(n)==1) = 0;
#
#  Densidad(i,:)=-0.0298*sum(Recorte,1)./(desv.^3);
#end
#
#colorbar
