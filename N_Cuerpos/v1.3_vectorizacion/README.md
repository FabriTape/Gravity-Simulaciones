# v1.3 - Vectorización de Fuerza Gravitatoria

Tres versiones progresivamente más optimizadas del cálculo vectorizado de la fuerza gravitatoria N-cuerpos.

## Método numérico
- **Velocity Verlet vectorizado**: elimina loops anidados usando operaciones tensoriales (`permute`, `vecnorm`, `dot`, `bsxfun`).

### Evolución de la función de fuerza
| Versión | Función | Descripción |
|---------|---------|-------------|
| V4 | `G2N.m` | Fuerza con `permute` + `vecnorm` + componentes separadas |
| V5 | `G3N.m` | Fuerza compacta con `dot` en una sola línea |
| V6 | `G4N` embebida | Fuerza integrada dentro del Verlet (función local) |

## Condiciones iniciales
El wrapper `main_sistema_solar.m` incluye ICs del sistema solar (11 cuerpos) con paso uniforme de 1 día.

| Parámetro | Valor |
|-----------|-------|
| G | 6.67430e-11 m³/kg/s² |
| Paso dt | 86400 s (1 día) |
| Tiempo total | 300 días |
| N cuerpos | 11 |

## Archivos
- `VerletV4.m` - Integrador usando G2N
- `VerletV5.m` - Integrador usando G3N (fórmula de timestep mejorada)
- `VerletV6.m` - Integrador con G4N embebida
- `G2N.m` - Fuerza vectorizada (componentes separadas)
- `G3N.m` - Fuerza vectorizada compacta (dot product)
- `main_sistema_solar.m` - **Wrapper** con ICs y comparación de las 3 versiones
- `DNI.m` - Generador de ICs aleatorias (extendido con 2 modos de layout tensorial)
- `EmyNoetherV2.m` - Energía y momento (vectorizado)
- `ErrorAnalisysV2.m` - Análisis de error con reconstrucción de velocidad

## Cómo ejecutar
```octave
cd N_Cuerpos/v1.3_vectorizacion
main_sistema_solar   % Compara las 3 versiones
```

## Notas
- V4 usa `permute(X,[1,3,2])` para alinear tensores, V5 usa `permute(X,[2,1,3])`.
- V5 corrige la fórmula del timestep: usa `(T(n)-T(n-1))*T(n)/2` en lugar de `T(n)²`.
- V6 es la más autocontenida: no necesita archivos externos de fuerza.
- Softening: +1 en `(vecnorm(U,2,3)+1)^3` para evitar singularidades.
