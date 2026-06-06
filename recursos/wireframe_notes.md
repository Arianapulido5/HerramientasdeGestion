# Notas de Wireframes - VirtualID

## Pantallas Principales

### Pantalla 1 - Inicio / Login
- Encabezado con logo centrado
- Boton principal: "Iniciar sesion con reconocimiento facial"
- Enlace secundario: "Registrarse"
- Enlace terciario: "Iniciar sesion con contrasena"
- Footer con nombre de la app y version

### Pantalla 2 - Registro
- Formulario en una sola columna
- Campos: nombre, apellidos, correo, contrasena
- Seccion de direccion con campo de codigo postal
- Al ingresar CP se autocompletan: municipio, colonia, ciudad, estado
- Boton: "Siguiente" lleva a captura facial

### Pantalla 3 - Captura Facial
- Vista de camara centrada en pantalla
- Overlay con guia de posicion del rostro (ovalo)
- Indicador de estado: "Posiciona tu rostro", "Capturando...", "Listo"
- Boton: "Repetir captura" en caso de error
- Boton: "Confirmar y guardar"

### Pantalla 4 - Dashboard Principal
- Encabezado con nombre del usuario y foto
- Tarjeta central con credencial digital (nombre, foto, QR)
- Boton: "Ver mi QR"
- Boton: "Editar informacion"
- Boton: "Cerrar sesion"

### Pantalla 5 - Credencial QR
- Codigo QR grande centrado en pantalla
- Datos del usuario debajo del QR
- Boton: "Descargar QR"
- Boton: "Compartir"
- Boton: "Regresar"

## Notas de Diseno
- Diseno mobile-first: todas las pantallas optimizadas para movil
- Colores segun paleta oficial (ver color_palette.md)
- Navegacion inferior en movil con 3 opciones: Inicio, Credencial, Perfil
- Splash screen al abrir la PWA con logo y fondo azul primario
- Pull-to-refresh personalizado con spinner en color primario
