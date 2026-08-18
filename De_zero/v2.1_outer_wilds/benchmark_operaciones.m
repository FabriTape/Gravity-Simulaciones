% benchmark_operaciones.m - Benchmark de operaciones matriciales
% Compara: bsxfun vs + vs vecnorm vs tril en matrices 3000x3000
%
% Uso: octave benchmark_operaciones

#clear
#clc
n=3000;
A=randn(n,n);
B=randn(n,n);
C=randn(n,n);
#U=tril(ones(n,n))-eye(n);
#tic
#B=bsxfun(@times,A,U).^-3;
#B=bsxfun(@plus,B,B');
#toc
#
#tic
#B=A.^-3;
#toc

#tic
#A+B;
#toc
#clear ans
#tic
#bsxfun(@plus,A,B);
#toc
#clear ans;

#tic
#vecnorm(A,2,3)+0.5;
#toc
#clear ans
#tic
#bsxfun(@plus,vecnorm(A,2,3),0.5);
#toc
#clear ans

#tic
#A+B+C;
#toc
#clear ans
#pause(1)
#tic
#bsxfun(@plus,A,B)+C;
#toc
#clear ans;
