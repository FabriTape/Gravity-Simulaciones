# v0.1 - Euler Forward (2 Cuerpos)

Primera versión de la simulación de 2 cuerpos gravitacionales.

## Método numérico
- **Euler Forward (RK1)**: método de primer orden, usa la posición actual para calcular la fuerza.

## Condiciones iniciales
| Parámetro | Valor |
|-----------|-------|
| Masa M1 | 10000 (unidades arbitrarias) |
| Masa M2 | 33295 (unidades arbitrarias) |
| Posición X1 | [0, 1, 0] |
| Posición X2 | [0, 0, 0] |
| Momento P1 | [1.9853e-7, 0, 0] |
| Momento P2 | [0, 0, 0] |
| G | 1.18095e-11 |
| Paso dt | 0.1 |
| Tiempo final | 700 |

## Archivos
- `RK1_V1.m` - Script principal (autocontenido)

## Cómo ejecutar
```octave
cd 2_Cuerpos/v0.1_euler
RK1_V1
```

## Notas
- Utiliza unidades abstractas (no SI).
- Trabaja con momento en lugar de velocidad.
