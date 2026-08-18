# v0.2 - Euler Mejorado (2 Cuerpos)

Implementación del método de Euler Mejorado (Heun) para el sistema Tierra-Luna.

## Método numérico
- **Euler Mejorado (RK2)**: predictor-corrector de segundo orden. Calcula la fuerza en el punto actual y en el punto predicho, luego promedia.

## Condiciones iniciales (Sistema Tierra-Luna)
| Cuerpo | Masa (kg) | Posición inicial (m) | Velocidad inicial (m/s) |
|--------|-----------|----------------------|-------------------------|
| Tierra | 5.9722e24 | [0, 0, 0] | [0, 0, 0] |
| Luna | 0.07346e24 | [4.055e8, 0, 0] | [0, 970, 0] |

| Parámetro | Valor |
|-----------|-------|
| G | 6.67e-11 m³/kg/s² |

## Versiones incluidas
- **RK2 V1**: Versión simple con gráfico 3D de trayectorias.
- **RK2 V2**: Versión mejorada con detección de choques (colisión elástica), seguimiento de energía (cinética, potencial, total) y momento lineal.

## Archivos
- `RK2_V1.m` - Script principal V1
- `RK2_V2.m` - Script principal V2 (con choques)
- `CondIn.m` - Función de condiciones iniciales
- `FAnonimas.m` - Funciones de fuerza, energía y momento
- `FuncionChoque.m` - Función de colisión elástica
- `TrayParticulas.m` - Gráfico de trayectorias 3D
- `Graficas.m` - Gráficas de energía y momento

## Cómo ejecutar
```octave
cd 2_Cuerpos/v0.2_euler_mejorado
RK2_V1   # Versión simple
RK2_V2   # Versión con choques
```

## Notas
- RK2 V2 incluye condiciones de choque: si la distancia entre cuerpos < 0.7 m, se aplica colisión elástica con coeficiente de restitución e=1.
