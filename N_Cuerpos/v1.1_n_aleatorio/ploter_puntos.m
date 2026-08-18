% ploter_puntos.m - Grafico 3D de puntos para N cuerpos
% Recorre todas las particulas en todos los timesteps
%
% Uso: ploter_puntos (requiere X, T, M en workspace)

for i=1:length(T)
  for j=1:length(M)
   hold on;
   plot3(X(i,1,j),X(i,2,j),X(i,3,j),"ok")
endfor
endfor
