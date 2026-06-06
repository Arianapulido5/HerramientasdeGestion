# Requisitos del Sistema - VirtualID

## Requisitos Funcionales

### Modulo de Registro
- RF01: El sistema debe permitir el registro de nuevos usuarios
- RF02: El sistema debe capturar datos personales (nombre, correo, direccion)
- RF03: El sistema debe autocompletar la direccion mediante codigo postal
- RF04: El sistema debe registrar el rostro del usuario como biometria
- RF05: El sistema debe validar que el correo no este previamente registrado

### Modulo de Autenticacion
- RF06: El sistema debe autenticar usuarios mediante reconocimiento facial
- RF07: El sistema debe generar un token JWT al autenticar correctamente
- RF08: El sistema debe bloquear el acceso si el rostro no coincide
- RF09: El sistema debe permitir maximo 3 intentos fallidos consecutivos

### Modulo de Credencial
- RF10: El sistema debe generar un codigo QR unico por usuario
- RF11: El sistema debe mostrar la credencial digital tras autenticacion exitosa
- RF12: El codigo QR debe ser verificable por un lector externo
- RF13: El usuario debe poder descargar su credencial en formato imagen

## Requisitos No Funcionales

### Rendimiento
- RNF01: El reconocimiento facial debe completarse en menos de 3 segundos
- RNF02: La aplicacion debe cargar en menos de 4 segundos
- RNF03: El sistema debe soportar al menos 100 usuarios concurrentes

### Seguridad
- RNF04: Los descriptores faciales deben almacenarse cifrados
- RNF05: Toda comunicacion debe realizarse mediante HTTPS
- RNF06: Los tokens JWT deben expirar en un maximo de 24 horas
- RNF07: Las contrasenas deben almacenarse con hash bcrypt

### Disponibilidad
- RNF08: El sistema debe estar disponible el 99% del tiempo
- RNF09: La aplicacion debe funcionar en modo offline (PWA)

### Usabilidad
- RNF10: La interfaz debe ser responsive para movil y escritorio
- RNF11: El proceso de autenticacion no debe requerir mas de 3 pasos
- RNF12: Los mensajes de error deben ser claros y descriptivos

## Restricciones del Proyecto
- Frontend desarrollado en Angular 17
- Backend implementado en Node.js con Express
- Base de datos PostgreSQL
- Despliegue en servicios gratuitos: Vercel y Railway
- Reconocimiento facial procesado en el navegador con face-api.js

## Version
- Version actual: 1.0.0
- Fecha de inicio: Enero 2026
- Fecha estimada de entrega: Junio 2026
