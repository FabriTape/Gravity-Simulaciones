% ploter_densidad_vecinos.m - Plotter de densidad por conteo de vecinos
% Metodo: Cuenta particulas dentro de radio R para estimar densidad
% Requiere: X, T, M en workspace
%
% Uso: octave ploter_densidad_vecinos

velocidad=1;
n=size(M,1);
Tiempo=size(M,2);
filterFactor = 0.3;
colMap=hot(200);
R=1;
l=1;

for i=1:(Tiempo-1)/velocidad
  Rij=bsxfun(@minus,M(:,l,:),permute(M(:,l,:),[2,1,3]));
  tij=sqrt(sum(Rij.^2,3));

Ninside(l)   = find(tij<=R) ;
d(l) = Ninside(l)'/(4*pi*R.^3/3);
l=l+velocidad;
end
clear tij


  T = linspace(0,1,size(colMap,1));
a=[min(min(M(:,:,1),[],2))-0.1, max(max(M(:,:,1)),[],2)+0.1,...
          min(min(M(:,:,2),[],2))-0.1, max(max(M(:,:,2)),[],2)+0.1,...
          min(min(M(:,:,3),[],2))-0.1, max(max(M(:,:,3)),[],2)+0.1];
l=1;
for i = 1:(Tiempo-1)/velocidad
    col = interp1(T, colMap, d(:,l));
    scatter3(M(:,l,1),M(:,l,2),M(:,l,3),16,d(:,l),'filled');
    axis(a)
    colorbar;
    title(['Paso de tiempo: ' num2str(l)])
    pause(1/80)
    l=l+velocidad;
endfor
clear a l col colMap d filterFactor i n u velocidad V Tiempo T
