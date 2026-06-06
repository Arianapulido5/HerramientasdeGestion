# Manual de Usuario - VirtualID

## Introduccion
VirtualID es una aplicacion web progresiva (PWA) que permite autenticarse
mediante reconocimiento facial y obtener una credencial digital con codigo QR.

## Requisitos
- Dispositivo con camara (computadora o celular)
- Navegador actualizado (Chrome, Edge, Safari)
- Conexion a internet

## Como registrarse
1. Ingresa a la aplicacion desde tu navegador
2. Haz clic en "Registrarse"
3. Completa el formulario con tus datos personales
4. Ingresa tu codigo postal para autocompletar tu direccion
5. Permite el acceso a la camara cuando el navegador lo solicite
6. Coloca tu rostro frente a la camara para registrar tu biometria
7. Haz clic en "Guardar" para finalizar el registro

## Como iniciar sesion
1. Ingresa a la aplicacion
2. Haz clic en "Iniciar sesion con reconocimiento facial"
3. Coloca tu rostro frente a la camara
4. El sistema verificara tu identidad automaticamente
5. Si la verificacion es exitosa, se generara tu credencial QR

## Como usar tu credencial QR
1. Una vez autenticado, ve a la seccion "Mi Credencial"
2. Se mostrara tu codigo QR personal
3. Presenta el codigo QR cuando se te solicite identificacion
4. El lector verificara la autenticidad de tu credencial

## Solucion de Problemas Frecuentes

### La camara no enciende
- Verifica que el navegador tenga permiso de acceso a la camara
- En Chrome: Configuracion > Privacidad > Camara > Permitir
- En Safari: Preferencias > Sitios web > Camara > Permitir
- Cierra otras aplicaciones que puedan estar usando la camara

### El rostro no es reconocido
- Asegurate de tener buena iluminacion frente a tu cara
- Evita usar lentes oscuros o cubrir parte del rostro
- Mantente a una distancia de 30 a 50 cm de la camara
- Si el problema persiste, vuelve a registrar tu biometria

### El codigo QR no carga
- Verifica tu conexion a internet
- Cierra sesion y vuelve a autenticarte
- Limpia el cache del navegador e intenta de nuevo

### La app no se instala como PWA
- Verifica que estes usando Chrome o Safari actualizado
- La opcion de instalacion aparece en la barra de direcciones
- En iOS debe hacerse desde Safari, no desde otros navegadores

---

## Preguntas Frecuentes (FAQ)

**¿Mis datos biometricos estan seguros?**
Si. Los descriptores faciales se almacenan cifrados en la base de datos
y nunca se comparten con terceros.

**¿Puedo usar VirtualID sin internet?**
La aplicacion funciona en modo offline gracias a PWA, pero la
autenticacion facial requiere conexion para verificar contra el servidor.

**¿Que hago si pierdo acceso a mi cuenta?**
Contacta al administrador del sistema para restablecer tu registro
biometrico con una nueva captura facial.

**¿En que dispositivos funciona?**
VirtualID funciona en cualquier dispositivo con camara y navegador
actualizado: computadoras, celulares y tabletas.

---

## Glosario

- **PWA**: Aplicacion web progresiva, instalable como app nativa
- **Biometria**: Identificacion mediante caracteristicas fisicas (rostro)
- **QR**: Codigo de respuesta rapida, utilizado como credencial digital
- **JWT**: Token de autenticacion con tiempo de expiracion
- **Descriptor facial**: Representacion numerica del rostro para comparacion

## Instalacion como app (PWA)
1. Abre la aplicacion en Chrome o Safari
2. Haz clic en "Agregar a pantalla de inicio"
3. La app quedara instalada como una aplicacion nativa
