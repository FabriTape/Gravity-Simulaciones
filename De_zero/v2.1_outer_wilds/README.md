# v2.1 - Outer Wilds (Universos Artificiales)

Fase creativa: simulaciones de universos artificiales con filtrado estadístico de vecinos y métodos de integración avanzados.

## Método numérico
- **Position Verlet + filtrado estadístico**: solo considera fuerzas de vecinos "cercanos" (dentro de 2σ de la distancia media). Esto crea estructuras gravitacionales emergentes.
- **Richardson Extrapolation** (richardson_extrapolation): mejora el orden del integrador combinando resultados en múltiples escalas temporales.

## Simulaciones incluidas
| Archivo | Cuerpos | Descripción |
|---------|---------|-------------|
| `outer_wilds_2d.m` | 20 | 2D, filtrado 2σ |
| `outer_wilds_2d_variante.m` | 20 | 2D, variante del filtrado |
| `outer_wilds_3d.m` | 600 | 3D, filtrado 2σ |
| `richardson_extrapolation.m` | N configurable | Richardson extrapolation |
| `verlet_io_binario.m` | 100 | I/O binario + ring buffer |
| `verlet_ring_buffer.m` | 80 | Ring buffer mod(i,3) + escritura progresiva |

## Condiciones iniciales (outer_wilds_3d)
- 600 partículas: posiciones Gaussianas (σ=30, μ=150)
- Velocidades: N(0,0.2) + 1
- Paso: 0.04, Integración: 30

## Condiciones iniciales (verlet_io_binario)
- 100 partículas: órbitas circulares radio 800
- Velocidades perpendiculares al radio (momento angular)
- Paso: 0.00002, Integración: 0.01

## Archivos
- `outer_wilds_2d.m` - Simulación 2D (20 partículas)
- `outer_wilds_2d_variante.m` - Variante 2D
- `outer_wilds_3d.m` - Simulación 3D (600 partículas)
- `richardson_extrapolation.m` - Richardson extrapolation (integrador más avanzado del proyecto)
- `verlet_io_binario.m` - I/O binario optimizado con ring buffer
- `verlet_ring_buffer.m` - Test de escritura optimizada
- `verlet_ring_buffer_copia.txt` - Duplicado del anterior (extensión .txt)
- `benchmark_operaciones.m` - Benchmark: `bsxfun` vs `+` vs `vecnorm` vs `tril` (3000×3000)
- `error_momento.m` - Ajuste polinómico de grado 6 del error de momento
- `ploter_densidad.m` - Plotter de densidad con filtrado de distancias
- `ploter_densidad_vecinos.m` - Plotter alternativo (conteo de vecinos en radio R)
- `densidad_kernel_adaptativa.m` - Estimación de densidad kernel adaptativa (Gauss/triangular)

## Cómo ejecutar
```octave
cd De_zero/v2.1_outer_wilds
outer_wilds_3d                 % Simulación 3D (requiere mucha RAM)
richardson_extrapolation       % Richardson extrapolation
verlet_io_binario              % I/O optimizado
```

## Notas
- Los nombres están inspirados en el videojuego "Outer Wilds".
- El filtrado estadístico crea agrupaciones emergentes: solo las partículas cercanas interactúan gravitacionalmente.
- richardson_extrapolation es el integrador más preciso del proyecto (Richardson extrapolation de orden superior).
- verlet_io_binario escribe resultados a disco binario para manejar grandes volúmenes de datos.
- `densidad_kernel_adaptativa.m` es una función de utilidad para estimación de densidad adaptativa.
