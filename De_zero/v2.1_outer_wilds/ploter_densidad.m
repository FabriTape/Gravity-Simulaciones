% ploter_densidad.m - Plotter de densidad con filtrado de distancias
% Metodo: Filtrado estadistico para estimar densidad local
% Requiere: X, T, M en workspace
%
% Uso: octave ploter_densidad

velocidad=2;
n=size(M,1);
Tiempo=size(M,2);
filterFactor = 0.3;
colMap=hot(200);
l=1;

for i=1:(Tiempo-1)/velocidad
  tij=vecnorm(M(:,l,:)-permute(M(:,l,:),[2,1,3]),2,3);
  filter = bsxfun(@rdivide,filterFactor.*tij,tij+filterFactor); % normalized filter
  d(:,l) = sum(filter.*tij,2);          % generates filtered distance measure
  l=l+velocidad;
end
clear tij filter
maxd = max(d,[],1); d = d./maxd;
clear maxd
  T = linspace(0,1,size(colMap,1));
a=[min(min(M(:,:,1),[],2))-0.1, max(max(M(:,:,1)),[],2)+0.1,...
          min(min(M(:,:,2),[],2))-0.1, max(max(M(:,:,2)),[],2)+0.1,...
          min(min(M(:,:,3),[],2))-0.1, max(max(M(:,:,3)),[],2)+0.1];
#out_dir = "gravityVideo";
#mkdir (out_dir);
l=1;
for i = 1:(Tiempo-1)/velocidad
    col = interp1(T, colMap,(-d(:,l)+1).^1.5);
    scatter3(M(:,l,1),M(:,l,2),M(:,l,3),16,col,'filled');
    axis(a)
    colorbar('colormap',hot);
    title(['Paso de tiempo: ' num2str(l)])
    l=l+velocidad;
    pause(1/60)
#   fname = fullfile (out_dir, sprintf ("img%03i.png", i));
#  imwrite (getframe (gcf).cdata, fname);
endfor
clear a l col colMap d filterFactor i n u velocidad V Tiempo T
