# v0.3 - Velocity Verlet (2 Cuerpos)

Primera implementación del integrador Verlet para el sistema Tierra-Luna.

## Método numérico
- **Velocity Verlet**: integrador de segundo orden que almacena posiciones y velocidades. Compatible con sistemas Hamiltonianos y conserva energía mejor que Euler.

## Condiciones iniciales (Sistema Tierra-Luna)
| Cuerpo | Masa (kg) | Posición inicial (m) | Velocidad inicial (m/s) |
|--------|-----------|----------------------|-------------------------|
| Tierra | 5.9724e24 | [0, 0, 0] | [0, 0, 0] |
| Luna | 0.07346e24 | [4.055e8, 0, 0] | [0, 970, 0] |

| Parámetro | Valor |
|-----------|-------|
| G | 6.67430e-11 m³/kg/s² |
| Paso dt | 11664 s |
| Tiempo total | 23328000 s (~270 días) |

## Versiones incluidas
- **Verlet Sin Vel**: Forma clásica position-only: x_{n+1} = 2x_n - x_{n-1} + a·dt². Reconstruye la posición inicial t=-dt a partir de la velocidad.
- **Verlet Con Vel**: Almacena velocidades explícitamente con la fórmula: v_{n+1} = v_n + (a_n + a_{n+1})·dt/2. Incluye seguimiento de energía y momento.

## Archivos
- `Verlet_SinVel.m` - Verlet position-only (script autocontenido)
- `Verlet_ConVel.m` - Verlet con velocidad explícita
- `CondIn.m` - Condiciones iniciales
- `FAnonimas.m` - Funciones de fuerza y cantidades conservadas
- `TrayParticulas.m` - Gráfico de trayectorias 3D
- `Graficas.m` - Gráficas de energía y momento

## Cómo ejecutar
```octave
cd 2_Cuerpos/v0.3_verlet
Verlet_SinVel   # Position-only Verlet
Verlet_ConVel   # Velocity Verlet con seguimiento de energía
```

## Notas
- La diferencia principal entre SinVel y ConVel es cómo se manejan las velocidades.
- ConVel incluye cálculo de energía cinética, potencial y momento para verificar conservación.
