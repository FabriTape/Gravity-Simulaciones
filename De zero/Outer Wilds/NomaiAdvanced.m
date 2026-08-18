##pkg load image
#------------------------------------------------------------------------------#
#Programa para integración de órbitas
#------------------------------------------------------------------------------#

tic
clear all
profile off
profile clear
##clc
profile on
#------------------------------------------------------------------------------#
#Control de parámetros
#------------------------------------------------------------------------------#
Particulas = 100;
Integracion = 0.01;
Paso = 0.00002;
#------------------------------------------------------------------------------#
#Condiciones Iniciales
#------------------------------------------------------------------------------#
Generador = @(sigma,promedio,n) randn(n,1,3) * sigma + promedio;

Rsigma = 2;
Rpromedio = 800;
##randn('seed',0)
R(:,2,:) = Generador(Rsigma,Rpromedio,Particulas);

Vsigma = 4;
Vpromedio = 10;
##randn('seed',0)
V(:,1,3)=zeros(Particulas,1,1);
V(:,1,1:2)=cat(3,-R(:,2,2),R(:,2,1));
#------------------------------------------------------------------------------#
#Fórmula de cálculo de aceleaciones
#------------------------------------------------------------------------------#
function [A] = aceleracion(R)
  Rij=bsxfun(@minus,R,permute(R,[2,1,3]));
  A = sum(bsxfun(@times,(vecnorm(Rij,2,3)+0.025).^3,Rij),2);
endfunction
#------------------------------------------------------------------------------#
#Función guardado y extracción de datos
#------------------------------------------------------------------------------#


function guardar_en_archivo_binario(M, archivo)
     if exist(archivo, 'file')
        % Si el archivo existe, leer los datos anteriores
        fid = fopen(archivo, 'r');
        dimension = fread(fid, 3, 'uint32');
        datos_anteriores = fread(fid, prod(dimension), 'double');
        fclose(fid);

        % Concatenar los datos anteriores con los nuevos datos
        M_concatenado = cat(2, reshape(datos_anteriores, dimension'), M);

        % Sobrescribir el archivo con los datos concatenados
        fid = fopen(archivo, 'w');
        fwrite(fid, size(M_concatenado), 'uint32');
        fwrite(fid, M_concatenado, 'double');
        fclose(fid);
    else
        % Si el archivo no existe, simplemente guardar los datos
        fid = fopen(archivo, 'w');
        dimension = size(M);
        fwrite(fid, dimension, 'uint32');
        fwrite(fid, M, 'double');
        fclose(fid);
    end
end
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
nombre='simulacionposta8.bin'
R(:,1,:) = R(:,2,:) - V * Paso - 0.5 * aceleracion(R(:,2,:)) * Paso ^ 2;
guardar_en_archivo_binario(R(:,1,:),nombre)
guardar_en_archivo_binario(R(:,2,:),nombre)
h = waitbar(0,'Calculando Órbitas...');
clearAllMemoizedCaches
clear Generador Rpromedio Rsigma Vpromedio Vsigma
for j=1:ceil(Integracion/Paso)

  R(:,mod(j+1,3)+1,:) = 2 * R(:,mod(j,3)+1,:) - R(:,mod(j-1,3)+1,:) - aceleracion(R(:,mod(j,3)+1,:)) * Paso ^ 2;
  guardar_en_archivo_binario(R(:,mod(j+1,3)+1,:),nombre)
  waitbar(j*Paso/Integracion);

end
close(h);
profile off
u=toc;
##rgbImage = imread('check.png');
##myIcon = imresize(rgbImage, [64, 64]);
E=sprintf('Su integración fue realizada con exito en %d segundos \n',u);
##msgbox(E,"Felicitacioness!!","custom",myIcon)
M = leer_desde_archivo_binario(nombre);
PloterNomai

