# v2.0 - Verlet N-D Array (Desde Cero)

Reimplementación del integrador Verlet desde cero usando arreglos N-dimensionales y operaciones tensoriales completamente vectorizadas.

## Método numérico
- **Position Verlet vectorizado**: usa `repmat`, `permute`, `vecnorm` y `dot` para calcular fuerzas sin loops. Implementado en 4 variantes.

## Variantes incluidas
| Archivo | Cuerpos | Descripción |
|---------|---------|-------------|
| `verlet_3cuerpos.m` | 3 (Tierra + Luna + cuerpo masivo) | Tierra-Luna con 3er cuerpo en eje Z |
| `verlet_unidades_adimensionales.m` | 2 | Tierra-Luna en unidades adimensionales |
| `verlet_tierra_luna_extendido.m` | 2 | Tierra-Luna en SI, tiempo extendido (×10) |
| `verlet_500_cuerpos.m` | 500 | N cuerpos con ICs aleatorias |

## Condiciones iniciales

### verlet_3cuerpos (3 cuerpos)
| Cuerpo | Masa (kg) | Posición (m) | Velocidad (m/s) |
|--------|-----------|-------------|-----------------|
| Tierra | 5.9724e24 | [0, 0, 0] | [0, 0, 0] |
| Luna | 0.07346e24 | [0, 4.055e8, 3.6502e8] | [0, 970, 1045] |
| Cuerpo 3 | 0 | [0, 0, 0] | [0, 0, 0] |

### verlet_unidades_adimensionales (2 cuerpos, adimensionales)
| Cuerpo | Masa | Posición | Velocidad |
|--------|------|----------|-----------|
| Tierra | 5.9724 | [0, 0, 0] | [0, 0, 0] |
| Luna | 0.07346 | [4.055, 0, 0] | [0, 1.131408, 0] |

### verlet_500_cuerpos (500 cuerpos, aleatorios)
- Posiciones: N(0,1) × 3000
- Velocidades: N(0,1) / 10
- Masas: N(0,1) × 5e10

| Parámetro | Valor |
|-----------|-------|
| G | 6.674e-11 m³/kg/s² |
| Softening | eye(n) en denominador |

## Archivos
- `verlet_3cuerpos.m` - 3 cuerpos con tensor 3D
- `verlet_unidades_adimensionales.m` - 2 cuerpos en unidades adimensionales
- `verlet_tierra_luna_extendido.m` - 2 cuerpos en SI (tiempo extendido)
- `verlet_500_cuerpos.m` - 500 cuerpos aleatorios
- `benchmark_broadcasting.m` - Benchmark: `repmat`+`permute`+`vecnorm` vs `bsxfun`
- `energia_momento_filtrada.m` - Energía con filtrado estadístico (2σ outlier clipping)
- `ploter_densidad.m` - Plotter de densidad con scatter (genera frames PNG)

## Cómo ejecutar
```octave
cd De_zero/v2.0_verlet_nd_array
verlet_unidades_adimensionales   % Rápido, 2 cuerpos adimensionales
verlet_500_cuerpos               % Lento, 500 cuerpos
```

## Notas
- Las unidades adimensionales permiten testing rápido sin constantes físicas.
- El filtrado estadístico en energia_momento_filtrada usa 2σ para reducir outliers en cálculo de energía potencial.
- `benchmark_broadcasting.m` compara rendimiento de diferentes métodos de broadcasting.
