% graficos_energia.m - Graficos de energia y momento del sistema
% Parametros: e (1=energia, 2=momento), T (tiempo), K,U,E,P (cantidades)
%
% Uso: graficos_energia(1, T, K, U, E, P)

function[] = graficos_energia(e,T,K,U,E,P)
  switch e
    case{1}
plot(T,K,'LineWidth',1,'r') %gráfico de la energia cinética vs t
  hold on
plot(T,U,'LineWidth',1,'b') %gráfico de la energia potencial vs t
plot(T,E,'LineWidth',2,'g') %gráfico de la energia del sistema vs t
xlabel ("t[seg.]");
ylabel ("E[J]");
h=legend({"Energía cinética", "Energia potencial", "Energia total"})
    case{2}
plot(T,P,'LineWidth',2,'g') %grafico del momento del sistema vs t
xlabel ("t[seg.]");
ylabel ("Err.P[%]");
h=legend({"Momento del sistema"})
  endswitch
endfunction
