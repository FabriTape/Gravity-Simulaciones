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
- **verlet_posicion.m**: Forma clásica position-only: x_{n+1} = 2x_n - x_{n-1} + a·dt². Reconstruye la posición inicial t=-dt a partir de la velocidad.
- **verlet_velocidad.m**: Almacena velocidades explícitamente con la fórmula: v_{n+1} = v_n + (a_n + a_{n+1})·dt/2. Incluye seguimiento de energía y momento.

## Archivos
- `verlet_posicion.m` - Verlet position-only (script autocontenido)
- `verlet_velocidad.m` - Verlet con velocidad explícita
- `condiciones_iniciales.m` - Condiciones iniciales
- `funciones_fisica.m` - Funciones de fuerza y cantidades conservadas
- `grafico_trayectorias.m` - Gráfico de trayectorias 3D
- `graficos_energia.m` - Gráficas de energía y momento

## Cómo ejecutar
```bash
octave verlet_posicion    # Position-only Verlet
octave verlet_velocidad   # Velocity Verlet con seguimiento de energía
```

## Notas
- La diferencia principal entre verlet_posicion y verlet_velocidad es cómo se manejan las velocidades.
- verlet_velocidad incluye cálculo de energía cinética, potencial y momento para verificar conservación.
