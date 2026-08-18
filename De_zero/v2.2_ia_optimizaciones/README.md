# v2.2 - Optimizaciones con IA

Optimizaciones generadas por IA (ChatGPT y Perplexity) del código base, incluyendo una implementación de Barnes-Hut + FFT.

## Método numérico
- **Velocity Verlet** (loop-based, ChatGPT optimizado)
- **Position Verlet** (con almacenamiento en cell array)
- **Position Verlet** (híbrido vectorizado con `bsxfun`)
- **Position Verlet** (I/O a disco binario cada 3 frames)
- **Barnes-Hut + FFT Particle Mesh** (solver de Poisson para potencial gravitatorio)

## Optimizaciones incluidas
| Archivo | IA | Descripción |
|---------|-----|-------------|
| `verlet_chatgpt_loops.m` | ChatGPT | Verlet con loops explícitos (no vectorizado) |
| `verlet_chatgpt_cellarray.m` | ChatGPT | Almacena historial completo en cell array |
| `verlet_chatgpt_hibrido.m` | ChatGPT | Híbrido vectorizado con `permute`+`bsxfun` |
| `verlet_chatgpt_io_binario.m` | ChatGPT | I/O binario cada 3 frames (basado en NomaiAdvanced) |
| `verlet_perplexity_vectorizado.m` | Perplexity | Verlet con `bsxfun` para aceleración vectorizada |
| `barnes_hut_fft.m` | ChatGPT | Barnes-Hut + FFT Particle Mesh (experimental) |

## Condiciones iniciales
Todas las variantes usan ICs aleatorias generadas inline:
- **500 cuerpos**: posiciones N(0,1)×3000, velocidades N(0,1)/10, masas N(0,1)×5e10
- **barnes_hut_fft**: 100 cuerpos, masas U(0,1)×1e10, posiciones U(0,1)×1e6, velocidades U(0,1)×1e3

## Archivos
- `verlet_chatgpt_loops.m` - Verlet loop-based optimizado
- `verlet_chatgpt_cellarray.m` - Con cell array para historial completo
- `verlet_chatgpt_hibrido.m` - Híbrido vectorizado
- `verlet_chatgpt_io_binario.m` - I/O binario optimizado
- `verlet_perplexity_vectorizado.m` - Verlet vectorizado (bsxfun)
- `barnes_hut_fft.m` - Barnes-Hut + FFT Poisson solver

## Cómo ejecutar
```octave
cd De_zero/v2.2_ia_optimizaciones
verlet_chatgpt_hibrido        % Versión más equilibrada
barnes_hut_fft                % Experimental (puede no converger)
```

## Notas
- Estos archivos fueron generados/optimizados por IA como parte de un experimento de mejora de código.
- barnes_hut_fft usa FFT para resolver la ecuación de Poisson en una grilla, luego calcula fuerzas por expansión multipolar. Es el algoritmo más sofisticado del proyecto pero probablemente no funcional como implementación completa.
- verlet_chatgpt_cellarray almacena TODO el historial en memoria (cell array) → alto uso de RAM para 500 cuerpos.
- verlet_chatgpt_io_binario escribe a disco binario cada 3 frames para reducir uso de memoria.
- verlet_perplexity_vectorizado es la versión más limpia de las optimizaciones IA.
