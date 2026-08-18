#------------------------------------------------------------------------------#
#Programa para integración de órbitas
#------------------------------------------------------------------------------#
tic
clear all
profile off
profile clear

profile on
#------------------------------------------------------------------------------#
#Control de parámetros
#------------------------------------------------------------------------------#
Particulas = 100;
Integracion = 0.2;
Paso = 0.00015;
#------------------------------------------------------------------------------#
#Condiciones Iniciales
#------------------------------------------------------------------------------#
Generador = @(sigma,promedio,n) randn(n,1,3) * sigma + promedio;

Rsigma = 2;
Rpromedio = 0;
randn('seed',0)
R(:,2,:) = Generador(Rsigma,Rpromedio,Particulas);

Vsigma = 400;
Vpromedio = 4000;
randn('seed',1)
V = Generador(Vsigma,Vpromedio,Particulas);

clear Generador Rpromedio Rsigma Vpromedio Vsigma
#------------------------------------------------------------------------------#
#Fórmula de cálculo de aceleaciones
#------------------------------------------------------------------------------#
function [A] = aceleracion(R,Particulas)
  Rij=R-permute(R,[2,1,3]);
  A2 = ((vecnorm(Rij,2,3)+0.0001).^-3).*Rij;
  A=sum(A2,2);
endfunction
#------------------------------------------------------------------------------#
#Función guardado y extracción de datos
#------------------------------------------------------------------------------#

function H = leer_desde_archivo_binario(archivo)
    fid = fopen(archivo, 'r'); % Abrir el archivo en modo de lectura

    % Leer la dimensión de los datos
    dimension = fread(fid, 3, 'uint32');

    % Leer los datos y reformatearlos a la dimensión original
    datos = fread(fid, prod(dimension), 'double');
    H = reshape(datos, dimension');

    fclose(fid); % Cerrar el archivo
end
#------------------------------------------------------------------------------#
#Integración
#------------------------------------------------------------------------------#
function [Nombre]=archivo(i,j)
 Nombre= sprintf('Datos/Serie%03i/Dato%04i.bin',j,i);
end

Serie=0;
Existe_dir=1;
while (Existe_dir~=0)
 Existe_dir = exist(sprintf('Datos/Serie%03i',Serie+1),"file");
 Serie=Serie+1;
 end
mkdir (sprintf('Datos/Serie%03i',Serie))

R(:,1,:) = R(:,2,:) - V * Paso - 0.5 * aceleracion(R(:,2,:),Particulas) * Paso ^ 2;
h = waitbar(0,'Calculando Órbitas');

ciclo=3;

for j=1:round(Integracion/Paso)
Contador=mod(j,ciclo);
if (Contador==1)
  R(:,mod(j+1,3)+1,:) =2 * R(:,mod(j,3)+1,:)-R(:,mod(j-1,3)+1,:)-aceleracion(R(:,mod(j,3)+1,:),Particulas) * Paso ^ 2;
        fid = fopen(archivo(j,Serie), 'w');
        dimension = [Particulas,3,3];
        fwrite(fid, dimension, 'uint32');
        fwrite(fid, R, 'double');
        fclose(fid);
  waitbar(j*Paso/Integracion);
else
  R(:,mod(j+1,3)+1,:) = 2 * R(:,mod(j,3)+1,:)-R(:,mod(j-1,3)+1,:)-aceleracion(R(:,mod(j,3)+1,:)) * Paso ^ 2;

end
end
close(h);
profile off
u=toc;
