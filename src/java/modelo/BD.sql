DROP DATABASE IF EXISTS CampusZen;
CREATE DATABASE CampusZen;
USE CampusZen;

CREATE TABLE Perfil (
    id_perfil INT PRIMARY KEY AUTO_INCREMENT,
    perfil VARCHAR(30),
    id_estado INT DEFAULT 1
);

CREATE TABLE Usuario (
    identificacion INT PRIMARY KEY,
    nombre VARCHAR(30),
    apellido VARCHAR(30),
    email VARCHAR(60),
    telefono VARCHAR(100),
    usuario VARCHAR(20),
    clave VARCHAR(255),
    id_perfil INT,
    id_estado INT DEFAULT 1,
    FOREIGN KEY (id_perfil) REFERENCES Perfil(id_perfil)
);

CREATE TABLE actividades (
    id_actividad INT PRIMARY KEY AUTO_INCREMENT,
    nom_actividad VARCHAR(45),
    enlace VARCHAR(100),
    id_estado INT DEFAULT 1
);

CREATE TABLE Profesor (
    id_profesor INT PRIMARY KEY AUTO_INCREMENT,
    identificacion INT,
    especialidad VARCHAR(150),
    departamento VARCHAR(150),
    id_estado INT DEFAULT 1,
    FOREIGN KEY (identificacion) REFERENCES Usuario(identificacion)
);

CREATE TABLE Asignatura (
    id_asignatura INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(150),
    descripcion VARCHAR(255),
    creditos INT DEFAULT 3,
    id_profesor INT,
    id_estado INT DEFAULT 1,
    FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor)
);

CREATE TABLE Horario (
    id_horario INT PRIMARY KEY AUTO_INCREMENT,
    id_asignatura INT,
    id_profesor INT,
    dia_semana VARCHAR(15),
    hora_inicio TIME,
    hora_fin TIME,
    salon VARCHAR(50),
    id_estado INT DEFAULT 1,
    FOREIGN KEY (id_asignatura) REFERENCES Asignatura(id_asignatura),
    FOREIGN KEY (id_profesor) REFERENCES Profesor(id_profesor)
);

CREATE TABLE Actividad (
    id_actividad INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(200),
    descripcion VARCHAR(255),
    fecha_limite DATETIME,
    id_asignatura INT,
    id_usuario_creador INT,
    id_estado INT DEFAULT 1,
    FOREIGN KEY (id_asignatura) REFERENCES Asignatura(id_asignatura),
    FOREIGN KEY (id_usuario_creador) REFERENCES Usuario(identificacion)
);

CREATE TABLE Tareas (
    id_tarea INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(200),
    descripcion VARCHAR(255),
    fecha_limite DATETIME,
    prioridad VARCHAR(10),  
    estado VARCHAR(20),     
    id_actividad INT,        
    id_usuario_asignado INT,
    observaciones VARCHAR(255),
    id_estado INT DEFAULT 1,
    FOREIGN KEY (id_actividad) REFERENCES Actividad(id_actividad),
    FOREIGN KEY (id_usuario_asignado) REFERENCES Usuario(identificacion)
);

CREATE TABLE GesActividad (
    idgesActividad INT PRIMARY KEY AUTO_INCREMENT,
    id_perfil INT,
    id_actividad INT,      
    id_estado INT DEFAULT 1,
    FOREIGN KEY (id_perfil)    REFERENCES Perfil(id_perfil),
    FOREIGN KEY (id_actividad) REFERENCES actividades(id_actividad)
);

CREATE TABLE Notificacion (
    id_notificacion INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    tipo VARCHAR(30),
    titulo VARCHAR(150),
    mensaje TEXT,
    leida INT DEFAULT 0,
    url_referencia VARCHAR(255),
    id_estado INT DEFAULT 1,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(identificacion)
);

INSERT INTO Perfil (perfil) VALUES
('Administrador'),  
('Usuario'),        
('Docente'),        
('Estudiante');     

INSERT INTO Usuario VALUES
(1001, 'Jean',   'Uribe',  'jean@mail.com',   '3001111111', 'jean',   '$2a$10$u2MoYJ0T0tl.9lZuKxwWEeiAOcZRplf/huJP1K7lHPCcam6R3yXDO', 1, 1),
(1002, 'Maria',  'Lopez',  'maria@mail.com',  '3002222222', 'maria',  '$2a$10$u2MoYJ0T0tl.9lZuKxwWEeiAOcZRplf/huJP1K7lHPCcam6R3yXDO', 4, 1),
(1003, 'Carlos', 'Perez',  'carlos@mail.com', '3003333333', 'carlos', '$2a$10$u2MoYJ0T0tl.9lZuKxwWEeiAOcZRplf/huJP1K7lHPCcam6R3yXDO', 3, 1),
(1004, 'Ana',    'Gomez',  'ana@mail.com',    '3004444444', 'ana',    '$2a$10$u2MoYJ0T0tl.9lZuKxwWEeiAOcZRplf/huJP1K7lHPCcam6R3yXDO', 4, 1),
(1005, 'Luis',   'Torres', 'luis@mail.com',   '3005555555', 'luis',   '$2a$10$u2MoYJ0T0tl.9lZuKxwWEeiAOcZRplf/huJP1K7lHPCcam6R3yXDO', 2, 1);

INSERT INTO actividades (nom_actividad, enlace) VALUES
('Usuarios',       'listaUsuarios.jsp'),    
('Perfiles',       'listaPerfiles.jsp'),     
('Actividades',    'listaActividades.jsp'),  
('GesActividad',   'listaGesActividad.jsp'), 
('Tareas',         'listaTareas.jsp'),       
('Horarios',       'listaHorarios.jsp'),     
('Calendario',     'calendario.jsp'),        
('Notificaciones', 'notificaciones.jsp');  

INSERT INTO Profesor (identificacion, especialidad, departamento) VALUES
(1003, 'Programación', 'Ingeniería'),
(1001, 'Bases de Datos', 'Ingeniería'); 

INSERT INTO Asignatura (nombre, descripcion, creditos, id_profesor) VALUES
('Programación Java', 'POO en Java',          3, 1),
('Bases de Datos',    'MySQL y modelado',     3, 2); 

INSERT INTO Horario (id_asignatura, id_profesor, dia_semana, hora_inicio, hora_fin, salon) VALUES
(1, 1, 'Lunes',      '08:00:00', '10:00:00', 'A101'),
(1, 1, 'Miércoles',  '08:00:00', '10:00:00', 'A101'),
(2, 2, 'Martes',     '10:00:00', '12:00:00', 'B202'),
(2, 2, 'Jueves',     '10:00:00', '12:00:00', 'B202');

INSERT INTO Actividad (nombre, descripcion, fecha_limite, id_asignatura, id_usuario_creador) VALUES
('Proyecto Java', 'Sistema de tareas',    '2026-05-10 23:59:00', 1, 1003), 
('Taller SQL',    'Consultas avanzadas',  '2026-05-05 23:59:00', 2, 1001); 

INSERT INTO Tareas (nombre, descripcion, fecha_limite, prioridad, estado, id_actividad, id_usuario_asignado, observaciones) VALUES
('CRUD Java',      'Crear CRUD completo',     '2026-05-01 23:59:00', 'alta',  'pendiente',   1, 1002, 'Usar MVC'),         
('DAO MySQL',      'Implementar DAO',          '2026-04-28 23:59:00', 'media', 'en progreso', 2, 1004, 'Revisar conexiones'), 
('Login Sistema',  'Autenticación usuarios',   '2026-04-25 23:59:00', 'alta',  'pendiente',   1, 1002, ''),                  
('Consultas JOIN', 'Practicar JOINs',          '2026-04-27 23:59:00', 'baja',  'pendiente',   2, 1004, '');                 

INSERT INTO GesActividad (id_perfil, id_actividad, id_estado) VALUES
(1, 1, 1),
(1, 2, 1),
(1, 3, 1),
(1, 4, 1),
(1, 5, 1),
(1, 6, 1),
(1, 7, 1),
(1, 8, 1);

INSERT INTO GesActividad (id_perfil, id_actividad, id_estado) VALUES
(3, 5, 1),
(3, 6, 1),
(3, 7, 1),
(3, 8, 1);

INSERT INTO GesActividad (id_perfil, id_actividad, id_estado) VALUES
(4, 5, 1),
(4, 7, 1),
(4, 8, 1),
(4, 5, 1),
(4, 7, 1),
(4, 8, 1);

INSERT INTO Notificacion (id_usuario, tipo, titulo, mensaje, url_referencia) VALUES
(1002, 'Tarea',       'Entrega próxima',       'Tienes una tarea próxima a vencer',  'listaTareas.jsp'),
(1004, 'Tarea',       'Nueva tarea asignada',  'Se te asignó una nueva tarea',       'listaTareas.jsp'),
(1002, 'Recordatorio','Revisa tu progreso',    'Actualiza el estado de tus tareas',  'listaTareas.jsp');