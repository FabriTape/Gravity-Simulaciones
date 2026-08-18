% outer_wilds_3d.m - Simulacion 3D con filtrado estadistico
% Metodo: Verlet + filtrado 2-sigma en 3D
% Cuerpos: 600, Paso: 0.04, Integracion: 30
% Requiere mucha RAM
%
% Uso: octave outer_wilds_3d

#------------------------------------------------------------------------------#
#Programa para integración de órbitas
#------------------------------------------------------------------------------#
tic
clear
clc
#------------------------------------------------------------------------------#
#Control de parámetros
#------------------------------------------------------------------------------#
Particulas = 600
Integracion = 30
Paso = 0.04
#------------------------------------------------------------------------------#
#Condiciones Iniciales
#------------------------------------------------------------------------------#
Generador = @(sigma,promedio,n) randn(1,n,3) * sigma + promedio

Rsigma = 30
Rpromedio = 150
R(2,:,:) = Generador(Rsigma,Rpromedio,Particulas)

Vsigma = 0.2
Vpromedio = 1
V = Generador(Vsigma,Vpromedio,Particulas)
#------------------------------------------------------------------------------#
#Fórmula de cálculo de aceleaciones
#------------------------------------------------------------------------------#
function [A] = aceleracion(R,n)
  Rij = repmat(R,n,1) - repmat(permute(R,[2,1,3]),1,n);

  tij = vecnorm(Rij,2,3)+1-eye(n);

  Reord = sort(tij);
  desv = std(Reord(2:end,:),1,1);
  promedio = mean(Reord(2:end,:),1);

  Recorte = abs(tij - repmat(promedio,n,1));
  Recorte(Recorte <= 2*desv) = -1;
  Recorte(Recorte ~= -1) = 0;
  Recorte(eye(n)==1) = 0;

  Rij2 = (tij.*(-1).*Recorte).^(-3);
  Rij2(Rij2 == Inf) = 0;
  Rij2(Rij2 == -Inf) = 0;

  A = sum(Rij2.*Rij,1);
endfunction

#------------------------------------------------------------------------------#
#Integración
#------------------------------------------------------------------------------#
Aceleracion = aceleracion(R(2,:,:),Particulas);
R(1,:,:) = R(2,:,:) - V * Paso - 0.5 * Aceleracion * Paso ^ 2;
M=R;
for i=1:ceil(Integracion/Paso)
  R(3,:,:) = 2 * R(2,:,:) - R(1,:,:) - Aceleracion * Paso ^ 2;
  Aceleracion = aceleracion(R(3,:,:),Particulas);

  M(i+2,:,:)=R(3,:,:);

  R = circshift(R,-1);
end
toc
