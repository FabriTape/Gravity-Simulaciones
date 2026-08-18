EP=diff(mean(M,1));
EEP=vecnorm((EP-EP(1,1,:))./EP(1,1,:),2,3);
Q=cumsum(EEP);
AA=[(0:Paso:Tiempo).^0' (0:Paso:Tiempo)' (0:Paso:Tiempo).^2' (0:Paso:Tiempo).^3' (0:Paso:Tiempo).^4' (0:Paso:Tiempo).^5' (0:Paso:Tiempo).^6'];
Param=AA'*AA\AA'*Q';
plot((0:Paso:Tiempo),AA*Param,'r')
hold on
plot((0:Paso:Tiempo),Q,'b')

