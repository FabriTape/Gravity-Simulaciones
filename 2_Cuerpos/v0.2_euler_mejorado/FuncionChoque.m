function[V]=FuncionChoque(v1,v2,x1,x2,M1,M2,t)
e=1;
n=(x2-x1)/norm(x2-x1);
mr=(M1*M2)/(M1+M2);
vi=dot(n,(v1-v2));
J=(1+e)*mr*vi;
switch t
  case {1}
    V=v1-J/M1*n;
  case {2}
    V=v2+J/M2*n;
  endswitch
endfunction



