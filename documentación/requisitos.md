# Requisitos del Sistema - VirtualID

## Requisitos Funcionales

### Modulo de Registro
- RF01: El sistema debe permitir el registro de nuevos usuarios
- RF02: El sistema debe capturar datos personales (nombre, correo, direccion)
- RF03: El sistema debe autocompletar la direccion mediante codigo postal
- RF04: El sistema debe registrar el rostro del usuario como biometria

### Modulo de Autenticacion
- RF05: El sistema debe autenticar usuarios mediante reconocimiento facial
- RF06: El sistema debe generar un token JWT al autenticar correctamente
- RF07: El sistema debe bloquear el acceso si el rostro no coincide

### Modulo de Credencial
- RF08: El sistema debe generar un codigo QR unico por usuario
- RF09: El sistema debe mostrar la credencial digital tras autenticacion exitosa
- RF10: El codigo QR debe ser verificable por un lector externo

## Requisitos No Funcionales

### Rendimiento
- RNF01: El reconocimiento facial debe completarse en menos de 3 segundos
- RNF02: La aplicacion debe cargar en menos de 4 segundos

### Seguridad
- RNF03: Los descriptores faciales deben almacenarse cifrados
- RNF04: Toda comunicacion debe realizarse mediante HTTPS
- RNF05: Los tokens JWT deben expirar en un maximo de 24 horas

### Disponibilidad
- RNF06: El sistema debe estar disponible el 99% del tiempo
- RNF07: La aplicacion debe funcionar en modo offline (PWA)

### Usabilidad
- RNF08: La interfaz debe ser responsive para movil y escritorio
- RNF09: El proceso de autenticacion no debe requerir mas de 3 pasos
