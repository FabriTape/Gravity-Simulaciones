# v1.2 - Verlet con Timestep Variable

Implementación del integrador Verlet con soporte para timesteps no uniformes mediante coeficientes de razón C(n) = dt(n)/dt(n-1).

## Método numérico
- **Velocity Verlet (position-only) con timestep variable**: usa la fórmula x_{n+1} = x_n·(1+C(n-1)) - x_{n-1}·C(n-1) + a·T(n)² donde C(n) permite variar el paso de integración.

## Condiciones iniciales
El wrapper `main_sistema_solar.m` incluye ICs del sistema solar (11 cuerpos) con paso uniforme de 1 día.

| Parámetro | Valor |
|-----------|-------|
| G | 6.67430e-11 m³/kg/s² |
| Paso dt | 86400 s (1 día) |
| Tiempo total | 300 días |
| N cuerpos | 11 |
| C(n) | 1 (uniforme por defecto) |

## Archivos
- `VerletV3.m` - Función integradora (acepta X, V, M, C, T como argumentos)
- `main_sistema_solar.m` - **Wrapper** con condiciones iniciales del sistema solar
- `G2.m` - Función de fuerza con matrix anti-simétrica
- `DNI.m` - Generador de condiciones iniciales aleatorias
- `EmyNoether.m` - Energía y momento (Hamiltoniano)
- `ErrorAnalysis.m` - Análisis de error de energía y momento (normalización arctan)

## Cómo ejecutar
```octave
cd N_Cuerpos/v1.2_timestep_variable
main_sistema_solar   % Ejecuta con sistema solar
```

## Notas
- Para usar timestep variable, modificar el vector C en el wrapper. Si C(n) > 1, el paso se agranda; si C(n) < 1, se achica.
- La función VerletV3 es genérica y acepta cualquier sistema de N cuerpos.
- ErrorAnalysis usa la transformación 2·atan(E/E0) - π/2 para mapear el error relativo a [0,1].
