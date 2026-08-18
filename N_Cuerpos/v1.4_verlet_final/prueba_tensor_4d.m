% prueba_tensor_4d.m - Fragmento de prueba para tensor 4D de aceleracion
% No es un script completo - fragmento de experimentacion
% Nota: "cuidadito" = cuidado con este codigo
UG=ones(25,1,3,1).*permute(X,[4,2,3,1]);
UG=UG-permute(UG,[2,1,3,4]);
A=-dot(UG./(vecnorm(UG,2,3)+1).^3,M.*ones(1,1,1,1001),1);
A=permute(A,[4,2,3,1]);
