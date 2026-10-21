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
| [v2.2](../../releases/tag/v2.2-ia-optimizaciones) | Optimizaciones IA | Verlet + Barnes-Hut/FFT | 500-900 |

## Estructura del proyecto

```
Gravity/
├── 2_Cuerpos/
│   ├── v0.1_euler/            → octave euler_forward
│   ├── v0.2_euler_mejorado/   → octave euler_mejorado / octave euler_mejorado_choques
│   └── v0.3_verlet/           → octave verlet_posicion / octave verlet_velocidad
├── N_Cuerpos/
│   ├── v1.0_sistema_solar/    → octave verlet_sistema_solar
│   ├── v1.1_n_aleatorio/      → octave verlet_n_aleatorio
│   ├── v1.2_timestep_variable/→ octave main_sistema_solar
│   ├── v1.3_vectorizacion/    → octave main_sistema_solar
│   └── v1.4_verlet_final/     → octave main_sistema_solar
├── De_zero/
│   ├── v2.0_verlet_nd_array/  → octave verlet_unidades_adimensionales / octave verlet_500_cuerpos
│   ├── v2.1_outer_wilds/      → octave outer_wilds_3d / octave richardson_extrapolation
│   └── v2.2_ia_optimizaciones/→ octave verlet_chatgpt_hibrido / octave barnes_hut_fft
└── densityScatter.m           # Utilidad de terceros
```

## Requisitos

- **GNU Octave** >= 5.0 (probado con 9.4.0) o MATLAB
- No se requieren paquetes adicionales

## Cómo ejecutar

Cada release tiene su propio `README.md` con instrucciones. Formato general:

```bash
cd 2_Cuerpos/v0.3_verlet
octave verlet_velocidad
```

Para los releases v1.2-v1.4, los archivos principales son funciones que necesitan un wrapper:

```bash
cd N_Cuerpos/v1.4_verlet_final
octave main_sistema_solar
```

## Convención de nombres

Todos los archivos `.m` usan snake_case con nombres descriptivos:

| Prefijo | Tipo | Ejemplo |
|---------|------|---------|
| `verlet_*` | Integradores Verlet | `verlet_final.m`, `verlet_vectorizado_g2n.m` |
| `euler_*` | Integradores Euler | `euler_forward.m`, `euler_mejorado.m` |
| `fuerza_*` | Funciones de fuerza | `fuerza_g2n.m`, `fuerza_g3n.m` |
| `aceleracion_*` | Aceleración gravitatoria | `aceleracion_gravitatoria.m`, `aceleracion_antisimetrica.m` |
| `condiciones_iniciales*` | Condiciones iniciales | `condiciones_iniciales_solar.m` |
| `datos_iniciales_*` | Generador de ICs aleatorias | `datos_iniciales_aleatorios.m` |
| `energia_momento*` | Cantidades conservadas | `energia_momento.m`, `energia_momento_filtrada.m` |
| `analisis_error*` | Análisis de error | `analisis_error.m` |
| `grafico_*` / `graficador_*` | Gráficos | `grafico_trayectorias.m`, `graficador_orbitas.m` |
| `ploter_*` | Ploters de densidad | `ploter_densidad.m` |
| `benchmark_*` | Tests de rendimiento | `benchmark_broadcasting.m` |
| `outer_wilds_*` | Simulaciones artificiales | `outer_wilds_3d.m` |
| `richardson_*` | Richardson extrapolation | `richardson_extrapolation.m` |
| `barnes_hut_*` | Barnes-Hut + FFT | `barnes_hut_fft.m` |

Cada función incluye un docstring con descripción, parámetros y ejemplo de uso.

## Archivos de terceros

- **`densityScatter.m`**: Matthias Chung, Virginia Tech, 2016. Licencia BSD. Función para crear gráficos de densidad con scatter plots.

## Constantes físicas utilizadas

| Constante | Valor | Descripción |
|-----------|-------|-------------|
| G | 6.67430e-11 m³/kg/s² | Constante de gravitación universal |
| Softening | +1 en r³ | Previene singularidades cuando r → 0 |

