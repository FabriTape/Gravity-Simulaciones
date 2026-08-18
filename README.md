# Gravity - Simulaciones de N Cuerpos

Simulaciones de dinámica gravitacional de N cuerpos desarrolladas en Octave/MATLAB como parte de un proyecto universitario de Física.

## Evolución del proyecto

El proyecto evolucionó desde simulaciones simples de 2 cuerpos hasta implementaciones avanzadas con integradores de alto orden, sistemas de muchas partículas, y optimizaciones con IA.

## Releases

| Release | Descripción | Método | Cuerpos |
|---------|-------------|--------|---------|
| [v0.1](../../releases/tag/v0.1-euler-2cuerpos) | Euler Forward | RK1 (orden 1) | 2 (unidades abstractas) |
| [v0.2](../../releases/tag/v0.2-euler-mejorado) | Euler Mejorado (Heun) | RK2 (orden 2) | 2 (Tierra-Luna) |
| [v0.3](../../releases/tag/v0.3-verlet-2cuerpos) | Velocity Verlet | Verlet (orden 2) | 2 (Tierra-Luna) |
| [v1.0](../../releases/tag/v1.0-sistema-solar) | Sistema Solar | Verlet + loops | 11 (Sol a Plutón) |
| [v1.1](../../releases/tag/v1.1-n-aleatorio) | N cuerpos aleatorios | Verlet + matrix anti-simétrica | 50 (random) |
| [v1.2](../../releases/tag/v1.2-timestep-variable) | Timestep variable | Verlet + coeficientes C(n) | N genérico |
| [v1.3](../../releases/tag/v1.3-vectorizacion) | Vectorización de fuerza | Verlet + `permute`/`vecnorm`/`dot` | N genérico |
| [v1.4](../../releases/tag/v1.4-verlet-final) | Verlet final (compacto) | Verlet position-only embebido | N genérico |
| [v2.0](../../releases/tag/v2.0-desde-cero) | Desde cero (tensorial) | Verlet + N-D arrays | 2-500 |
| [v2.1](../../releases/tag/v2.1-outer-wilds) | Outer Wilds | Verlet + filtrado estadístico | 20-600 |
| [v2.2](../../releases/tag/v2.2-ia-optimizaciones) | Optimizaciones IA | Verlet + Barnes-Hut/FFT | 100-500 |

## Estructura del proyecto

```
Gravity/
├── 2_Cuerpos/          # Simulaciones de 2 cuerpos
│   ├── v0.1_euler/
│   ├── v0.2_euler_mejorado/
│   └── v0.3_verlet/
├── N_Cuerpos/          # Simulaciones de N cuerpos
│   ├── v1.0_sistema_solar/
│   ├── v1.1_n_aleatorio/
│   ├── v1.2_timestep_variable/
│   ├── v1.3_vectorizacion/
│   └── v1.4_verlet_final/
├── De_zero/            # Reimplementaciones y experimentos
│   ├── v2.0_verlet_nd_array/
│   ├── v2.1_outer_wilds/
│   └── v2.2_ia_optimizaciones/
└── densityScatter.m    # Utilidad de terceros
```

## Requisitos

- **GNU Octave** >= 5.0 (probado con 9.4.0) o MATLAB
- No se requieren paquetes adicionales

## Cómo ejecutar

Cada release contiene su propio `README.md` con instrucciones específicas. En general:

```octave
cd 2_Cuerpos/v0.3_verlet
Verlet_ConVel   # Ejecuta la simulación Tierra-Luna
```

Para los releases de N-Cuerpos con funciones (v1.2-v1.4), usar los wrappers:

```octave
cd N_Cuerpos/v1.4_verlet_final
main_sistema_solar   # Ejecuta con sistema solar completo
```

## Archivos de terceros

- **`densityScatter.m`**: Matthias Chung, Virginia Tech, 2016. Licencia BSD. Función para crear gráficos de densidad con scatter plots. Usada en `De_zero/Ploter.m`.

## Constantes físicas utilizadas

| Constante | Valor | Descripción |
|-----------|-------|-------------|
| G | 6.67430e-11 m³/kg/s² | Constante de gravitación universal |
| Softening | +1 en r³ | Previene singularidades cuando r → 0 |

## Autor

Proyecto desarrollado como parte del curso de Física - Universidad Nacional de Cuyo (UNCuyo).
