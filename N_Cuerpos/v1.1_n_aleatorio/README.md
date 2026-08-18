# v1.1 - N Cuerpos Aleatorios

Extensión del sistema solar a N cuerpos con condiciones iniciales aleatorias y nueva formulación de fuerza gravitatoria.

## Método numérico
- **Velocity Verlet con matrix anti-simétrica**: la aceleración se calcula usando una matriz O(i,j) anti-simétrica que aprovecha la simetría de la fuerza gravitatoria (acción-reacción).

## Condiciones iniciales
- **50 cuerpos** con masas y posiciones aleatorias (distribución Gaussiana)
- Velocidades iniciales: cero
- Generadas por la función `DNI(e,n)`:
  - `e=1`: masas aleatorias (μ = |N(0,1)| × 7.89e24 × G)
  - `e=2`: posiciones aleatorias (σ = 1.2e11 m)
  - `e=3`: posiciones en grilla esferica

| Parámetro | Valor |
|-----------|-------|
| G | 6.67430e-11 m³/kg/s² |
| Paso dt | 86400 s (1 día) |
| Tiempo total | 300 × dt (~10 meses) |
| N cuerpos | 50 |

## Archivos
- `VerletV2.m` - Script principal
- `DNI.m` - Generador de condiciones iniciales aleatorias
- `G2.m` - Función de fuerza con matrix anti-simétrica
- `EmyNoether.m` - Energía cinética, potencial y momento (normalizados por G)
- `InitialRot.m` - Condiciones iniciales del sistema solar (disponible para comparación)
- `Noether.m` - Verificación de conservación
- `Graficador.m` - Gráficas de energía y trayectorias
- `Ploter.m` - Gráfico 3D de puntos

## Cómo ejecutar
```octave
cd N_Cuerpos/v1.1_n_aleatorio
VerletV2
```

## Notas
- La matrix anti-simétrica O(i,j) solo calcula pares i<j, luego usa O - O' para obtener ambas direcciones.
- Incluye InitialRot.m del sistema solar por si se quiere comparar.
- El comment "fffffiiiiuumba" en el código es una nota del autor celebrando que la actualización de velocidad funciona.
