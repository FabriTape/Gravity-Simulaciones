#------------------------------------------------------------------------------#
#Programa para integración de órbitas
#------------------------------------------------------------------------------#

tic
clear all -except H
profile clear
##clc
profile on
#------------------------------------------------------------------------------#
#Control de parámetros
#------------------------------------------------------------------------------#
Particulas = 80;
Integracion = 0.5;
Paso = 0.0004;
#------------------------------------------------------------------------------#
#Condiciones Iniciales
#------------------------------------------------------------------------------#
Generador = @(sigma,promedio,n) randn(n,1,3) * sigma + promedio;

Rsigma = 2;
Rpromedio = 0;
randn('seed',0)
R(:,2,:) = Generador(Rsigma,Rpromedio,Particulas);

Vsigma = 0.1;
Vpromedio = 0.4;
randn('seed',1)
V = Generador(Vsigma,Vpromedio,Particulas);

#------------------------------------------------------------------------------#
#Fórmula de cálculo de aceleaciones
#------------------------------------------------------------------------------#
function [A] = aceleracion(R)
  Rij=bsxfun(@minus,R,permute(R,[2,1,3]));
  A = sum(bsxfun(@times,(vecnorm(Rij,2,3)+0.05).^3,Rij),2);
endfunction

#------------------------------------------------------------------------------#
#Integración
#------------------------------------------------------------------------------#
R(:,1,:) = R(:,2,:) - V * Paso - 0.5 * aceleracion(R(:,2,:)) * Paso ^ 2;
save('-binary','MejoraN2.bin','R')

h = waitbar(0,'Calculando Órbitas...');
clearAllMemoizedCaches
clear Generador Rpromedio Rsigma Vpromedio Vsigma

for i=1:ceil(Integracion/Paso)
   R(:,mod(i+1,3)+1,:) = 2 * R(:,mod(i,3)+1,:) - R(:,mod(i-1,3)+1,:) - aceleracion(R(:,mod(i,3)+1,:)) * Paso ^ 2;
  save('-binary','-append','MejoraN2.bin','R')
  waitbar(i*Paso/Integracion);
end
##fclose(fid);

close(h);
profile off
u=toc;

E=sprintf('Su integración fue realizada con exito en %d segundos \n',u);





