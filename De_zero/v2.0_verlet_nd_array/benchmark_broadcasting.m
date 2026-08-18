% benchmark_broadcasting.m - Benchmark de metodos de broadcasting
% Compara: repmat+permute+vecnorm vs bsxfun para distancias par a par
%
% Uso: octave benchmark_broadcasting

R2=permute(R,[2,1,3]);
tic
  tij = vecnorm(repmat(R2,5,1) - repmat(permute(R2,[2,1,3]),1,5),2,3);
  clear tij
U=toc
tic
D2 = sum(bsxfun(@minus,R,permute(R,[2,1,3])).^2,3);
clear D2
V=toc


