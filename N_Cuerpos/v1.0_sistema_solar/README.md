# v1.0 - Sistema Solar (N Cuerpos)

Primera extensión a N cuerpos: simulación del sistema solar con 11 cuerpos (Sol + 9 planetas + Luna + Plutón).

## Método numérico
- **Velocity Verlet con loops**: integrador de segundo orden con almacenamiento explícito de velocidades. Cálculo de fuerza gravitatoria por loops anidados.

## Condiciones iniciales (Sistema Solar)
| Cuerpo | Masa (kg) | Distancia orbital (m) | Velocidad orbital (m/s) |
|--------|-----------|----------------------|-------------------------|
| Sol | 1.9885e30 | 0 | [3.99, 0.21, 0] |
| Mercurio | 3.3010e23 | 6.9818e10 | [0, 38860, 0] |
| Venus | 4.8673e24 | 1.0894e11 | [0, 34790, 0] |
| Tierra | 5.9722e24 | 1.521e11 | [0, 29240, 0] |
| Luna | 7.346e22 | 1.5251e11 | [0, 30210, 0] |
| Marte | 6.4169e23 | 2.4926e11 | [0, 21970, 0] |
| Júpiter | 1.89813e27 | 8.1636e11 | [0, 12440, 0] |
| Saturno | 5.6832e26 | 1.5065e12 | [0, 9090, 0] |
| Urano | 8.6811e25 | 3.0014e12 | [0, 6490, 0] |
| Neptuno | 1.02409e26 | 4.5589e12 | [0, 5370, 0] |
| Plutón | 1.303e22 | 7.3043e12 | [0, 3710, 0] |

Las posiciones y velocidades se transforman según ángulos de perihelio (θ) y declinación orbital (α) reales.

| Parámetro | Valor |
|-----------|-------|
| G | 6.67430e-11 m³/kg/s² |
| Paso dt | 78894 s (~22 horas) |
| Tiempo total | 5 × 365 × dt (~5 años) |
| Softening | +1 en denominador (previene singularidades) |

## Archivos
- `verlet_sistema_solar.m` - Script principal de integración
- `condiciones_iniciales_solar.m` - Condiciones iniciales con transformación de coordenadas polares a Cartesianas
- `aceleracion_gravitatoria.m` - Función de aceleración gravitatoria N-cuerpos (con softening)
- `conservacion.m` - Verificación de conservación de energía y momento
- `graficador_orbitas.m` - Gráficas de energía, momento y trayectorias orbitales 3D

## Cómo ejecutar
```octave
cd N_Cuerpos/v1.0_sistema_solar
verlet_sistema_solar
```

## Notas
- Incluye el parámetro `b` para invertir la dirección del tiempo (b=0: adelante, b=1: atrás).
- El gráfico muestra las órbitas en 3D con colores por planeta.
- Las posiciones incluyen rotación por perihelio y declinación orbital.
- **Archivo de terceros**: `densityScatter.m` ( Matthias Chung, Virginia Tech, 2016, licencia BSD) se usa en otras partes del proyecto para gráficos de densidad.
