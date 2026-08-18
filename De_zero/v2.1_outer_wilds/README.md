# v2.1 - Outer Wilds (Universos Artificiales)

Fase creativa: simulaciones de universos artificiales con filtrado estadístico de vecinos y métodos de integración avanzados.

## Método numérico
- **Position Verlet + filtrado estadístico**: solo considera fuerzas de vecinos "cercanos" (dentro de 2σ de la distancia media). Esto crea estructuras gravitacionales emergentes.
- **Richardson Extrapolation** (EyeOfTheUniverse): mejora el orden del integrador combinando resultados en múltiples escalas temporales.

## Simulaciones incluidas
| Archivo | Cuerpos | Descripción |
|---------|---------|-------------|
| `OuterWildsVentures.m` | 20 | 2D, filtrado 2σ |
| `OuterVentures.m` | 20 | 2D, variante del filtrado |
| `OuterWildsVentures3D.m` | 600 | 3D, filtrado 2σ |
| `EyeOfTheUniverse.m` | N configurable | Richardson extrapolation |
| `NomaiAdvanced.m` | 100 | I/O binario + ring buffer |
| `PruebaMejoraEscrituraYLlamadoAR.m` | 80 | Ring buffer mod(i,3) + escritura progresiva |

## Condiciones iniciales (OuterWildsVentures3D)
- 600 partículas: posiciones Gaussianas (σ=30, μ=150)
- Velocidades: N(0,0.2) + 1
- Paso: 0.04, Integración: 30

## Condiciones iniciales (NomaiAdvanced)
- 100 partículas: órbitas circulares radio 800
- Velocidades perpendiculares al radio (momento angular)
- Paso: 0.00002, Integración: 0.01

## Archivos
- `OuterWildsVentures.m` - Simulación 2D (20 partículas)
- `OuterVentures.m` - Variante 2D
- `OuterWildsVentures3D.m` - Simulación 3D (600 partículas)
- `EyeOfTheUniverse.m` - Richardson extrapolation (integrador más avanzado del proyecto)
- `NomaiAdvanced.m` - I/O binario optimizado con ring buffer
- `PruebaMejoraEscrituraYLlamadoAR.m` - Test de escritura optimizada
- `PruebaMejoraEscrituraYLlamadoAR.txt` - Duplicado del anterior (extensión .txt)
- `VelocityTest.m` - Benchmark: `bsxfun` vs `+` vs `vecnorm` vs `tril` (3000×3000)
- `ErrorMomentum.m` - Ajuste polinómico de grado 6 del error de momento
- `PloterNomai.m` - Plotter de densidad con filtrado de distancias
- `PloterEyeEchoes.m` - Plotter alternativo (conteo de vecinos en radio R)
- `daptive_kernel_density.m` - Estimación de densidad kernel adaptativa (Gauss/triangular)

## Cómo ejecutar
```octave
cd De_zero/v2.1_outer_wilds
OuterWildsVentures3D   % Simulación 3D (requiere mucha RAM)
EyeOfTheUniverse       % Richardson extrapolation
NomaiAdvanced          % I/O optimizado
```

## Notas
- Los nombres están inspirados en el videojuego "Outer Wilds".
- El filtrado estadístico crea agrupaciones emergentes: solo las partículas cercanas interactúan gravitacionalmente.
- EyeOfTheUniverse es el integrador más preciso del proyecto (Richardson extrapolation de orden superior).
- NomaiAdvanced escribe resultados a disco binario para manejar grandes volúmenes de datos.
- `daptive_kernel_density.m` es una función de utilidad para estimación de densidad adaptativa.
