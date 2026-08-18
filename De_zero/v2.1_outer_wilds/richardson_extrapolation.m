% richardson_extrapolation.m - Verlet con Richardson Extrapolation
% Metodo: Integracion en multiples escalas temporales + extrapolacion
% El integrador mas preciso del proyecto (orden superior)
% Parametros: configurable (N, paso, iteraciones)
%
% Uso: octave richardson_extrapolation

function [ResultadoF] = EyeOfTheUniverse(ParametrosR,ParametrosV,Paso,Integracion,Particulas)
pkg load image;

#clear
clc
#Parametros es un vector cuya primera componente es la desviacion estadandar de
#la posiciû˚n u velocidad y la segunda componente es el valor promedio
Generador = @(Parametros,n) randn(n,1,3) * Parametros(1) + Parametros(2);

R(:,2,:) = Generador( ParametrosR , Particulas );
V = Generador( ParametrosV , Particulas );

#------------------------------------------------------------------------------#
#Fû˚rmula de cûÀlculo de aceleaciones
#------------------------------------------------------------------------------#
function [A] = aceleracion(R,n)
  Rij=bsxfun(@minus,R,permute(R,[2,1,3]));
  tij=sum(Rij.^2,3);

  Reord = sort(tij)';
  desv = std(Reord(:,2:end),1,2);
  promedio = mean(Reord(:,2:end),2);

  Recorte = abs(bsxfun(@minus,tij,promedio));
  Recorte(Recorte <= 5*desv) = -1;
  Recorte(Recorte ~= -1) = 0;
  Recorte(eye(n)==1) = 0;

  Rij2 = (bsxfun(@times,tij,(-1).*Recorte)+3).^(-3/2);
  Rij2(Rij2 == Inf) = 0;
  Rij2(Rij2 == -Inf) = 0;
  Rij2(eye(n)==1) = 0;

  A = sum(Rij2.*Rij,2);
endfunction
function [M] = Verlet(R,V,Particulas,Paso,Integracion,tanda,total)
tic
Aceleracion = aceleracion(R(:,2,:),Particulas);
R(:,1,:) = R(:,2,:) - V * Paso - 0.5 * Aceleracion * Paso ^ 2;
M=R;
h = waitbar(0,sprintf('Calculando Tanda %d de %d de orbitas\n',tanda,total));
for i=1:ceil(Integracion/Paso)

  R(:,3,:) = 2 * R(:,2,:) - R(:,1,:) - Aceleracion * Paso ^ 2;
  Aceleracion = aceleracion(R(:,3,:),Particulas);

  M(:,i+2,:)=R(:,3,:);

  R = circshift(R,[0 -1]);
  waitbar(i*Paso/Integracion);
end
close(h);
u=toc;
rgbImage = imread('check.png');
myIcon = imresize(rgbImage, [64, 64]);
E=sprintf('Su integraciû˚n fue realizada con exito en %d segundos \n',u);
msgbox(E,"Felicitacioness!!","custom",myIcon)
endfunction
#------------------------------------------------------------------------------#
#Integraciû˚n
#------------------------------------------------------------------------------#

  Longitud=length(Paso);

  Beta=(circshift(Paso,1)./Paso);
  Beta(1)=0;
  Beta=repmat(Beta',1,Longitud).^[0 (4:2:4+2*(Longitud-2))];

  for k=1:Longitud
    M=Verlet(R,V,Particulas,Paso(k),Integracion,k,Longitud);
    Saltos=Paso(1)/Paso(k);
    Resultado{k,1}=M(:,2:Saltos:end,:);
    clear M
  end
  clear i k j
  for i=2:Longitud
    for j=2:Longitud
      if j<=i
        Resultado{i,j}=(Beta(i,j)*Resultado{i,j-1}-Resultado{i-1,j-1})/(Beta(i,j)-1);
      endif
    endfor
  endfor
  ResultadoF = Resultado{Longitud,Longitud};

endfunction
