# v2.2 - Optimizaciones con IA

Optimizaciones generadas por IA (ChatGPT y Perplexity) del código base, incluyendo una implementación de Barnes-Hut + FFT.

## Método numérico
- **Velocity Verlet** (loop-based, ChatGPT optimizado)
- **Position Verlet** (con almacenamiento en cell array)
- **Position Verlet** (hibridro vectorizado con `bsxfun`)
- **Position Verlet** (I/O a disco binario cada 3 frames)
- **Barnes-Hut + FFT Particle Mesh** (solver de Poisson para potencial gravitatorio)

## Optimizaciones incluidas
| Archivo | IA | Descripción |
|---------|-----|-------------|
| `ChatGPTmejora.m` | ChatGPT | Verlet con loops explícitos (no vectorizado) |
| `ChatGPTmejora2.m` | ChatGPT | Almacena historial completo en cell array |
| `ChatGPTmejora3.m` | ChatGPT | Híbrido vectorizado con `permute`+`bsxfun` |
| `ChatGPTmejora4nomaiadvanced.m` | ChatGPT | I/O binario cada 3 frames (basado en NomaiAdvanced) |
| `Perplexitymejora.m` | Perplexity | Verlet con `bsxfun` para aceleración vectorizada |
| `BarnesHut.m` | ChatGPT | Barnes-Hut + FFT Particle Mesh (experimental) |

## Condiciones iniciales
Todas las variantes usan ICs aleatorias generadas inline:
- **500 cuerpos**: posiciones N(0,1)×3000, velocidades N(0,1)/10, masas N(0,1)×5e10
- **BarnesHut**: 100 cuerpos, masas U(0,1)×1e10, posiciones U(0,1)×1e6, velocidades U(0,1)×1e3

## Archivos
- `ChatGPTmejora.m` - Verlet loop-based optimizado
- `ChatGPTmejora2.m` - Con cell array para historial completo
- `ChatGPTmejora3.m` - Híbrido vectorizado
- `ChatGPTmejora4nomaiadvanced.m` - I/O binario optimizado
- `Perplexitymejora.m` - Verlet vectorizado (bsxfun)
- `BarnesHut.m` - Barnes-Hut + FFT Poisson solver

## Cómo ejecutar
```octave
cd De_zero/v2.2_ia_optimizaciones
ChatGPTmejora3            % Versión más equilibrada
BarnesHut                 % Experimental (puede no converger)
```

## Notas
- Estos archivos fueron generados/optimizados por IA como parte de un experimento de mejora de código.
- BarnesHut usa FFT para resolver la ecuación de Poisson en una grilla, luego calcula fuerzas por expansión multipolar. Es el algoritmo más sofisticado del proyecto pero probablemente no funcional como implementación completa.
- ChatGPTmejora2 almacena TODO el historial en memoria (cell array) → alto uso de RAM para 500 cuerpos.
- ChatGPTmejora4 escribe a disco binario cada 3 frames para reducir uso de memoria.
- Perplexitymejora es la versión más limpia de las optimizaciones IA.
