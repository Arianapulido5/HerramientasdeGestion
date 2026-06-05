# VirtualID — Identificación Digital Personal
Aplicación web progresiva (PWA) para autenticación biométrica y generación de credenciales digitales verificables mediante código QR.

## Descripción del Proyecto

**VirtualID** es un sistema de identificación digital personal desarrollado como PWA (Progressive Web App). Permite a los usuarios registrarse, autenticarse mediante **reconocimiento facial** y obtener una credencial digital con un **código QR único y verificable**, funcionando como una identificación digital portátil desde cualquier dispositivo.
El sistema está diseñado para funcionar tanto en navegadores de escritorio como en dispositivos móviles, con soporte de instalación como aplicación nativa (PWA).

## Objetivo
Desarrollar una plataforma segura y accesible que permita a las personas gestionar su identidad digital de forma sencilla, reemplazando procesos de identificación tradicionales por un sistema moderno basado en biometría facial y credenciales QR.

## Tecnologías Utilizadas

### Frontend
- **Angular 17** — Framework principal de la aplicación
- **PWA** — Soporte offline e instalación nativa
- **face-api.js** — Reconocimiento facial en el navegador
- **TypeScript / SCSS**

### Backend
- **Node.js + Express** — API REST del sistema
- **PostgreSQL** — Base de datos relacional
- **JSONB** — Almacenamiento de descriptores faciales
- **JWT** — Autenticación por tokens

### Infraestructura
- **Vercel** — Despliegue del frontend
- **Railway** — Despliegue del backend y base de datos
- **SEPOMEX API** — Autocompletado de datos geográficos (CP)
