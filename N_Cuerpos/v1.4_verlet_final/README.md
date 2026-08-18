# v1.4 - Verlet Final (Versión Compacta)

La versión más madura y compacta del integrador Verlet. Fuerza gravitatoria embebida dentro de la función.

## Método numérico
- **Position-only Verlet**: x_{n+1} = 2x_n - x_{n-1} + a·dt². La función de fuerza G4N está integrada como función local dentro de VerletV7.

## Condiciones iniciales
El wrapper `main_sistema_solar.m` incluye ICs del sistema solar (11 cuerpos).

| Parámetro | Valor |
|-----------|-------|
| G | 6.67430e-11 m³/kg/s² |
| Paso dt | 86400 s (1 día) |
| Tiempo total | 300 días |
| N cuerpos | 11 |

## Archivos
- `VerletV7.m` - Integrador final (16 líneas, autocontenido con G4N embebida)
- `main_sistema_solar.m` - **Wrapper** con ICs del sistema solar
- `InitialRot.m` - Condiciones iniciales del sistema solar (con transformación angular)
- `DNI.m` - Generador de ICs aleatorias
- `EmyNoetherV2.m` - Energía y momento (vectorizado)
- `ErrorAnalisysV2.m` - Análisis de error con reconstrucción de velocidad
- `Cuidadito.m` - Fragmento de código de prueba (no es un script completo)

## Cómo ejecutar
```octave
cd N_Cuerpos/v1.4_verlet_final
main_sistema_solar
```

## Notas
- VerletV7 es la versión más compacta: solo 16 líneas incluyendo la función de fuerza.
- La función G4N embebida usa `dot(U./P,M,1)` con G incluido en la constante.
- ErrorAnalisysV2 reconstruye velocidades a partir de las posiciones para calcular errores.
- `Cuidadito.m` ("cuidadito" = "cuidado") es un fragmento de prueba con un warning implícito.
