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
- **euler_mejorado.m**: Versión simple con gráfico 3D de trayectorias.
- **euler_mejorado_choques.m**: Versión mejorada con detección de choques (colisión elástica), seguimiento de energía (cinética, potencial, total) y momento lineal.

## Archivos
- `euler_mejorado.m` - Script principal V1
- `euler_mejorado_choques.m` - Script principal V2 (con choques)
- `condiciones_iniciales.m` - Función de condiciones iniciales
- `funciones_fisica.m` - Funciones de fuerza, energía y momento
- `funcion_choque.m` - Función de colisión elástica
- `grafico_trayectorias.m` - Gráfico de trayectorias 3D
- `graficos_energia.m` - Gráficas de energía y momento

## Cómo ejecutar
```bash
octave euler_mejorado          # Versión simple
octave euler_mejorado_choques  # Versión con choques
```

## Notas
- euler_mejorado_choques.m incluye condiciones de choque: si la distancia entre cuerpos < 0.7 m, se aplica colisión elástica con coeficiente de restitución e=1.
