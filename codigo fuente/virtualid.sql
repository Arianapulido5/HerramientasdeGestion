--- ============================
-- Para nosotros
-- ============================

CREATE TABLE admins_desarrollo (
    id_admin_desarrollo  BIGSERIAL PRIMARY KEY,
    email               VARCHAR(255) UNIQUE NOT NULL,
    nombre              VARCHAR(150) NOT NULL,
    password_hash       VARCHAR(255) NOT NULL,
    ultimo_acceso       TIMESTAMP,
    activo              BOOLEAN DEFAULT TRUE
);

-- ============================
-- INSTITUCIONES
-- ============================
CREATE TABLE instituciones (
    id_institucion BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    razon_social VARCHAR(300),
    rfc VARCHAR(13),
    tipo_institucion VARCHAR(50),
    region_cobertura TEXT,
    activo BOOLEAN DEFAULT TRUE,
	clave_segura VARCHAR(50)
);

-- ============================
-- ADMINISTRADORES DEL SISTEMA
-- ============================
CREATE TABLE admins (
    id_admin BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    cargo VARCHAR(100),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    id_institucion BIGINT,
    FOREIGN KEY (id_institucion) REFERENCES instituciones(id_institucion)
);

-- ============================
-- ROLES
-- ============================
CREATE TABLE roles (
    id_rol BIGSERIAL PRIMARY KEY,
    nombre_rol VARCHAR(80) NOT NULL,
    descripcion VARCHAR(255),
    id_institucion BIGINT,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_institucion) REFERENCES instituciones(id_institucion)
);

-- ============================
-- PERMISOS
-- ============================
CREATE TABLE permisos (
    id_permiso BIGSERIAL PRIMARY KEY,
    nombre_permiso VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255)
);

-- ============================
-- RELACION ROLES - PERMISOS
-- ============================
CREATE TABLE rol_permisos (
    id_rol BIGINT,
    id_permiso BIGINT,
    PRIMARY KEY (id_rol, id_permiso),
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
    FOREIGN KEY (id_permiso) REFERENCES permisos(id_permiso)
);

-- ============================
-- ROLES ASIGNADOS A ADMINS
-- ============================
CREATE TABLE admins_roles (
    id_admin BIGINT,
    id_rol BIGINT,
    id_institucion BIGINT,
    fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_admin, id_rol),
    FOREIGN KEY (id_admin) REFERENCES admins(id_admin),
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol),
    FOREIGN KEY (id_institucion) REFERENCES instituciones(id_institucion)
);

-- ============================
-- USUARIOS / ESTUDIANTES
-- ============================
CREATE TABLE usuarios (
    id_usuario BIGSERIAL PRIMARY KEY,
    codigo_interno VARCHAR(50),
    nombre VARCHAR(150),
    apellidos VARCHAR(150),
    email VARCHAR(255) UNIQUE,
    telefono VARCHAR(30),
    foto_url TEXT,
    secreto_totp VARCHAR(255),
    id_institucion BIGINT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_institucion) REFERENCES instituciones(id_institucion)
);

-- ============================
-- SEDES / CAMPUS INSTITUCIONALES
-- ============================
CREATE TABLE sedes_institucionales (
    id_sede BIGSERIAL PRIMARY KEY,
    nombre VARCHAR(150),
    direccion VARCHAR(255),
    ciudad VARCHAR(100),
    pais VARCHAR(100),
    id_institucion BIGINT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_institucion) REFERENCES instituciones(id_institucion)
);

-- ============================
-- REGISTRO DE ASISTENCIAS
-- (Usando PostGIS para ubicación)
-- ============================

CREATE EXTENSION postgis; 

CREATE TABLE registro_asistencia (
    id_asistencia BIGSERIAL PRIMARY KEY,
    id_usuario BIGINT NOT NULL,
    id_institucion BIGINT,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    tipo_evento VARCHAR(30),
    metodo VARCHAR(30),
    
    -- Ubicación geoespacial con PostGIS
    ubicacion GEOMETRY(Point, 4326),

    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_institucion) REFERENCES instituciones(id_institucion)
);


-- ============================
-- CONFIGURACION VISUAL INSTITUCION
-- ============================

CREATE TABLE tarjetas_institucion (
    id_tarjetas BIGSERIAL PRIMARY KEY,
    id_institucion BIGINT NOT NULL,
    color_primario VARCHAR(20),
    logo_url TEXT,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_institucion) REFERENCES instituciones(id_institucion)
);



-- =====================================================
-- TABLAS PARA CONFIGURACIÓN DE GEOLOCALIZACIÓN
-- =====================================================

-- Tabla de configuración de geolocalización por institución
CREATE TABLE IF NOT EXISTS configuracion_geolocalizacion (
    id_configuracion SERIAL PRIMARY KEY,
    id_institucion INTEGER NOT NULL,
    bloqueo_intentos BOOLEAN DEFAULT TRUE,
    bloqueo_tiempo BOOLEAN DEFAULT TRUE,
    geo_activa BOOLEAN DEFAULT TRUE,
    latitud DECIMAL(10, 8) NOT NULL DEFAULT 19.4326078,
    longitud DECIMAL(11, 8) NOT NULL DEFAULT -99.133208,
    radio_metros INTEGER DEFAULT 500,
    direccion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_configuracion_institucion 
        FOREIGN KEY (id_institucion) 
        REFERENCES instituciones(id_institucion) 
        ON DELETE CASCADE,
    CONSTRAINT unique_institucion_config 
        UNIQUE (id_institucion)
);

-- Comentarios de la tabla y columnas
COMMENT ON TABLE configuracion_geolocalizacion IS 'Configuración de geolocalización para check-in por institución';
COMMENT ON COLUMN configuracion_geolocalizacion.id_configuracion IS 'Identificador único de la configuración';
COMMENT ON COLUMN configuracion_geolocalizacion.id_institucion IS 'ID de la institución (foreign key)';
COMMENT ON COLUMN configuracion_geolocalizacion.bloqueo_intentos IS 'Bloquear después de 3 intentos fallidos';
COMMENT ON COLUMN configuracion_geolocalizacion.bloqueo_tiempo IS 'Bloquear después del tiempo establecido';
COMMENT ON COLUMN configuracion_geolocalizacion.geo_activa IS 'Mantener geolocalización activada indefinidamente';
COMMENT ON COLUMN configuracion_geolocalizacion.latitud IS 'Latitud del centro de la institución';
COMMENT ON COLUMN configuracion_geolocalizacion.longitud IS 'Longitud del centro de la institución';
COMMENT ON COLUMN configuracion_geolocalizacion.radio_metros IS 'Radio en metros para el área permitida';
COMMENT ON COLUMN configuracion_geolocalizacion.direccion IS 'Dirección de la institución';

-- =====================================================
-- TABLA PARA HISTORIAL DE UBICACIONES DE USUARIOS
-- =====================================================

-- Tabla para historial de ubicaciones de usuarios (para la opción "Mantener la Geo-Localización activada")
CREATE TABLE IF NOT EXISTS historial_ubicaciones_usuario (
    id_historial SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    latitud DECIMAL(10, 8) NOT NULL,
    longitud DECIMAL(11, 8) NOT NULL,
    precision_metros DECIMAL(7, 2),
    dispositivo VARCHAR(255),
    ip_address INET,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hora_guardado TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_historial_usuario 
        FOREIGN KEY (id_usuario) 
        REFERENCES usuarios(id_usuario) 
        ON DELETE CASCADE
);

-- Comentarios de la tabla y columnas
COMMENT ON TABLE historial_ubicaciones_usuario IS 'Historial de ubicaciones de usuarios para tracking cada 3 horas';
COMMENT ON COLUMN historial_ubicaciones_usuario.id_historial IS 'Identificador único del registro de ubicación';
COMMENT ON COLUMN historial_ubicaciones_usuario.id_usuario IS 'ID del usuario (foreign key)';
COMMENT ON COLUMN historial_ubicaciones_usuario.latitud IS 'Latitud del usuario en el momento del registro';
COMMENT ON COLUMN historial_ubicaciones_usuario.longitud IS 'Longitud del usuario en el momento del registro';
COMMENT ON COLUMN historial_ubicaciones_usuario.precision_metros IS 'Precisión de la ubicación en metros';
COMMENT ON COLUMN historial_ubicaciones_usuario.dispositivo IS 'Información del dispositivo usado';
COMMENT ON COLUMN historial_ubicaciones_usuario.ip_address IS 'Dirección IP del usuario';
COMMENT ON COLUMN historial_ubicaciones_usuario.timestamp IS 'Momento en que se tomó la ubicación';
COMMENT ON COLUMN historial_ubicaciones_usuario.hora_guardado IS 'Momento en que se guardó en la base de datos';

-- =====================================================
-- TABLA PARA REGISTRO DE INTENTOS DE CHECK-IN
-- =====================================================

-- Tabla para controlar los intentos fallidos de check-in
CREATE TABLE IF NOT EXISTS intentos_checkin (
    id_intento SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    id_institucion INTEGER NOT NULL,
    latitud_intento DECIMAL(10, 8) NOT NULL,
    longitud_intento DECIMAL(11, 8) NOT NULL,
    distancia_metros DECIMAL(10, 2),
    exitoso BOOLEAN DEFAULT FALSE,
    fecha_intento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_intentos_usuario 
        FOREIGN KEY (id_usuario) 
        REFERENCES usuarios(id_usuario) 
        ON DELETE CASCADE,
    CONSTRAINT fk_intentos_institucion 
        FOREIGN KEY (id_institucion) 
        REFERENCES instituciones(id_institucion) 
        ON DELETE CASCADE
);

-- Comentarios de la tabla
COMMENT ON TABLE intentos_checkin IS 'Registro de intentos de check-in para control de bloqueos';
COMMENT ON COLUMN intentos_checkin.id_intento IS 'Identificador único del intento';
COMMENT ON COLUMN intentos_checkin.id_usuario IS 'ID del usuario que intenta el check-in';
COMMENT ON COLUMN intentos_checkin.id_institucion IS 'ID de la institución donde intenta el check-in';
COMMENT ON COLUMN intentos_checkin.latitud_intento IS 'Latitud desde donde intentó el check-in';
COMMENT ON COLUMN intentos_checkin.longitud_intento IS 'Longitud desde donde intentó el check-in';
COMMENT ON COLUMN intentos_checkin.distancia_metros IS 'Distancia a la que estaba del área permitida';
COMMENT ON COLUMN intentos_checkin.exitoso IS 'Si el intento fue exitoso o no';
COMMENT ON COLUMN intentos_checkin.fecha_intento IS 'Fecha y hora del intento';

-- =====================================================
-- TABLA PARA BLOQUEOS DE USUARIOS
-- =====================================================

-- Tabla para registrar bloqueos de usuarios
CREATE TABLE IF NOT EXISTS bloqueos_usuario (
    id_bloqueo SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    id_institucion INTEGER NOT NULL,
    motivo VARCHAR(50) NOT NULL CHECK (motivo IN ('intentos_fallidos', 'fuera_horario', 'admin')),
    fecha_bloqueo TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_desbloqueo TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE,
    desbloqueado_por INTEGER,
    CONSTRAINT fk_bloqueos_usuario 
        FOREIGN KEY (id_usuario) 
        REFERENCES usuarios(id_usuario) 
        ON DELETE CASCADE,
    CONSTRAINT fk_bloqueos_institucion 
        FOREIGN KEY (id_institucion) 
        REFERENCES instituciones(id_institucion) 
        ON DELETE CASCADE,
    CONSTRAINT fk_desbloqueado_por 
        FOREIGN KEY (desbloqueado_por) 
        REFERENCES usuarios(id_usuario)
);

COMMENT ON TABLE bloqueos_usuario IS 'Registro de bloqueos de usuarios por intentos fallidos o fuera de horario';
COMMENT ON COLUMN bloqueos_usuario.motivo IS 'Motivo del bloqueo: intentos_fallidos, fuera_horario, admin';

-- =====================================================
-- TABLA PARA HORARIOS DE CHECK-IN
-- =====================================================

-- Tabla para configurar horarios de check-in por institución
CREATE TABLE IF NOT EXISTS horarios_checkin (
    id_horario SERIAL PRIMARY KEY,
    id_institucion INTEGER NOT NULL,
    dia_semana INTEGER NOT NULL CHECK (dia_semana BETWEEN 0 AND 6), -- 0=Domingo, 1=Lunes, ..., 6=Sábado
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    activo BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_horarios_institucion 
        FOREIGN KEY (id_institucion) 
        REFERENCES instituciones(id_institucion) 
        ON DELETE CASCADE,
    CONSTRAINT unique_horario_institucion_dia 
        UNIQUE (id_institucion, dia_semana)
);

COMMENT ON TABLE horarios_checkin IS 'Horarios permitidos para check-in por institución y día de la semana';

-- =====================================================
-- ÍNDICES PARA MEJORAR EL RENDIMIENTO
-- =====================================================

-- Índices para configuracion_geolocalizacion
CREATE INDEX idx_configuracion_institucion ON configuracion_geolocalizacion(id_institucion);

-- Índices para historial_ubicaciones_usuario
CREATE INDEX idx_historial_usuario ON historial_ubicaciones_usuario(id_usuario);
CREATE INDEX idx_historial_timestamp ON historial_ubicaciones_usuario(timestamp DESC);
CREATE INDEX idx_historial_usuario_timestamp ON historial_ubicaciones_usuario(id_usuario, timestamp DESC);

-- Índices para intentos_checkin
CREATE INDEX idx_intentos_usuario_fecha ON intentos_checkin(id_usuario, fecha_intento DESC);
CREATE INDEX idx_intentos_institucion_fecha ON intentos_checkin(id_institucion, fecha_intento DESC);
CREATE INDEX idx_intentos_exitoso ON intentos_checkin(exitoso);
CREATE INDEX idx_intentos_usuario_institucion ON intentos_checkin(id_usuario, id_institucion, fecha_intento DESC);

-- Índices para bloqueos_usuario
CREATE INDEX idx_bloqueos_activo ON bloqueos_usuario(activo);
CREATE INDEX idx_bloqueos_usuario_activo ON bloqueos_usuario(id_usuario, activo);
CREATE INDEX idx_bloqueos_fecha ON bloqueos_usuario(fecha_bloqueo DESC);

-- Índices para horarios_checkin
CREATE INDEX idx_horarios_institucion_activo ON horarios_checkin(id_institucion, activo);

-- =====================================================
-- TRIGGERS Y FUNCIONES
-- =====================================================

-- Función para actualizar fecha_actualizacion automáticamente
CREATE OR REPLACE FUNCTION update_fecha_actualizacion_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.fecha_actualizacion = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

-- Trigger para configuracion_geolocalizacion
CREATE TRIGGER update_configuracion_fecha_actualizacion
    BEFORE UPDATE ON configuracion_geolocalizacion
    FOR EACH ROW
    EXECUTE FUNCTION update_fecha_actualizacion_column();

-- Función para contar intentos fallidos recientes
CREATE OR REPLACE FUNCTION contar_intentos_fallidos(
    p_id_usuario INTEGER,
    p_id_institucion INTEGER,
    p_minutos INTEGER DEFAULT 60
)
RETURNS INTEGER AS $$
DECLARE
    intentos_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO intentos_count
    FROM intentos_checkin
    WHERE id_usuario = p_id_usuario
      AND id_institucion = p_id_institucion
      AND exitoso = FALSE
      AND fecha_intento > (CURRENT_TIMESTAMP - (p_minutos || ' minutes')::INTERVAL);
    
    RETURN intentos_count;
END;
$$ LANGUAGE 'plpgsql';

COMMENT ON FUNCTION contar_intentos_fallidos IS 'Cuenta los intentos fallidos de un usuario en los últimos minutos';

-- Función para verificar si un usuario está bloqueado
CREATE OR REPLACE FUNCTION usuario_esta_bloqueado(
    p_id_usuario INTEGER,
    p_id_institucion INTEGER
)
RETURNS BOOLEAN AS $$
DECLARE
    bloqueado BOOLEAN;
BEGIN
    SELECT EXISTS(
        SELECT 1
        FROM bloqueos_usuario
        WHERE id_usuario = p_id_usuario
          AND id_institucion = p_id_institucion
          AND activo = TRUE
          AND (fecha_desbloqueo IS NULL OR fecha_desbloqueo > CURRENT_TIMESTAMP)
    ) INTO bloqueado;
    
    RETURN bloqueado;
END;
$$ LANGUAGE 'plpgsql';

-- =====================================================
-- DATOS DE EJEMPLO (OPCIONAL)
-- =====================================================

-- Insertar configuración de ejemplo para instituciones existentes
-- (Solo si quieres datos de prueba)

INSERT INTO configuracion_geolocalizacion 
    (id_institucion, latitud, longitud, radio_metros, direccion)
VALUES 
    (1, 19.4326078, -99.133208, 500, 'Ciudad de México - Centro'),
    (2, 25.6866142, -100.3161126, 400, 'Monterrey, Nuevo León'),
    (3, 20.6596988, -103.3496092, 450, 'Guadalajara, Jalisco')
ON CONFLICT (id_institucion) DO NOTHING;

-- Insertar horarios de ejemplo
INSERT INTO horarios_checkin 
    (id_institucion, dia_semana, hora_inicio, hora_fin)
VALUES 
    -- Lunes a Viernes: 8:00 - 20:00
    (1, 1, '08:00', '20:00'),
    (1, 2, '08:00', '20:00'),
    (1, 3, '08:00', '20:00'),
    (1, 4, '08:00', '20:00'),
    (1, 5, '08:00', '20:00'),
    -- Sábado: 9:00 - 14:00
    (1, 6, '09:00', '14:00')
ON CONFLICT (id_institucion, dia_semana) DO UPDATE 
SET hora_inicio = EXCLUDED.hora_inicio,
    hora_fin = EXCLUDED.hora_fin;

