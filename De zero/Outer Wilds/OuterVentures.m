clearvars
clc
Particulas = 20
Integracion = 2
Paso = 0.01

Generador = @(sigma,promedio,n) randn(1,n,2) * sigma + promedio

Rsigma = 8
Rpromedio = 150
R(2,:,:) = Generador(Rsigma,Rpromedio,Particulas)


Vsigma = 1
Vpromedio = 15
V = Generador(Vsigma,Vpromedio,Particulas)


function [A] = aceleracion(R,n);
  Rij = repmat(R,n,1) - repmat(permute(R,[2,1,3]),1,n);

  tij = vecnorm(Rij,2,3);

  Reord = sort(tij);
  desv = std(Reord(2:end,:),1,1);
  mean = mean(Reord(2:end,:),1);

  Recorte = abs(tij - repmat(mean,n,1));
  Recorte(Recorte <= 2*desv) = 1;
  Recorte(Recorte >= 2*desv) = 0;
  Recorte(eye(n)==1) = 0;

  Rij2=(tij.*Recorte).^-1;
  Rij2(Rij2 == Inf) = 0;

  A=sum(Rij2.*Rij,1);
endfunction

Aceleracion = aceleracion(R(2,:,:),Particulas);

R(1,:,:) = R(2,:,:) + V * Paso + 0.5 * Aceleracion * Paso^2;

for i=1:ceil(Integracion/Paso)
  R(3,:,:) = 2 * R(2,:,:) - R(1,:,:) - Aceleracion * Paso ^ 2;

Aceleracion = aceleracion(R(3,:,:),Particulas);
R=shift(R,-1,1);
plot(R(2,:,1),R(2,:,2),'ob')
hold on
end



