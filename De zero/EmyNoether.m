function [G]=EmyNoether (V,R,n)

  K=sum(vecnorm(V,2,3).^2,2)*1/2

  Rij = repmat(R,n,1) - repmat(permute(R,[2,1,3]),1,n);

  tij = vecnorm(Rij,2,3);

  Reord = sort(tij);
  desv = std(Reord(2:end,:),1,1);
  mean = mean(Reord(2:end,:),1);

  Recorte = abs(tij - repmat(mean,n,1));
  Recorte(Recorte <= 2*desv) = -1;
  Recorte(Recorte ~= -1) = 0;
  Recorte(eye(n)==1) = 0;

  Rij2 = (tij.*-1*Recorte).^-1;
  Rij2(Rij2 == Inf) = 0;

  U = sum(sum(Rij2,1),2);

H=U+K;
P=sum(vecnorm(V,2,3),2);
G=[H P];
endfunction
