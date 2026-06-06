# Diagrama de Arquitectura - VirtualID

## Descripcion General
VirtualID sigue una arquitectura cliente-servidor de tres capas:
Frontend, Backend y Base de datos.

## Capas del Sistema

### Capa de Presentacion (Frontend)
- Tecnologia: Angular 17 + PWA
- Despliegue: Vercel
- Responsabilidades:
  - Interfaz de usuario
  - Captura y procesamiento facial con face-api.js
  - Generacion y visualizacion del codigo QR
  - Comunicacion con el backend mediante HTTP

### Capa de Logica de Negocio (Backend)
- Tecnologia: Node.js + Express
- Despliegue: Railway
- Responsabilidades:
  - API REST para registro y autenticacion
  - Validacion de descriptores faciales
  - Generacion de tokens JWT
  - Gestion de sesiones de usuario

### Capa de Datos (Base de datos)
- Tecnologia: PostgreSQL
- Despliegue: Railway
- Responsabilidades:
  - Almacenamiento de datos personales
  - Almacenamiento de descriptores faciales (JSONB)
  - Registro de credenciales QR

## Flujo de Autenticacion
1. Usuario abre la app en el navegador
2. face-api.js captura y procesa el rostro localmente
3. El descriptor facial se envia al backend via HTTPS
4. El backend compara con los descriptores almacenados en PostgreSQL
5. Si coincide, genera un token JWT y habilita el QR
6. El frontend muestra la credencial digital al usuario

## Servicios Externos
- SEPOMEX API: autocompletado de direccion por codigo postal

## Version del Sistema
- Version: 1.0.0
- Fecha: Junio 2026

