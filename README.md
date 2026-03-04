📚 CampusZen
Organizador de Tareas Estudiantiles

CampusZen es una aplicación web desarrollada con JSP y MySQL que permite a los estudiantes gestionar sus tareas, exámenes y horarios académicos en un solo lugar.

El objetivo del proyecto es ofrecer una herramienta simple, organizada y eficiente para mejorar la planificación y productividad académica.

🚀 Características

✅ Registro e inicio de sesión de usuarios

📝 Gestión de tareas (crear, editar, eliminar, marcar como completadas)

📅 Gestión de exámenes con fechas límite

🗓 Organización de horarios académicos

🔔 Sistema básico de notificaciones por fechas próximas

📊 Visualización organizada por calendario o lista

🛠 Tecnologías Utilizadas

Frontend: JSP, HTML, CSS

Backend: Java (Servlets + JSP)

Base de Datos: MySQL

Servidor: Apache Tomcat

Conector JDBC: MySQL Connector/J

🗄 Base de Datos
1️⃣ Crear la base de datos
CREATE DATABASE CampusZen;
USE CampusZen;
2️⃣ Configuración de conexión

Ejemplo de conexión en Java:

private String url = "jdbc:mysql://localhost:3306/CampusZen?serverTimezone=UTC&useSSL=false";
private String user = "root";
private String password = "your_password";

Asegúrate de tener instalado el driver MySQL Connector/J.

▶️ Cómo Ejecutar el Proyecto
Requisitos

Java JDK 8 o superior

MySQL Server

Apache Tomcat

IDE (NetBeans, Eclipse o IntelliJ recomendado)

Pasos

Clonar el repositorio:

git clone https://github.com/your-username/CampusZen.git

Importar el proyecto en tu IDE como proyecto web dinámico.

Configurar la base de datos en MySQL.

Ajustar las credenciales de conexión en el archivo de configuración.

Ejecutar el proyecto en Apache Tomcat.

Abrir en el navegador:

http://localhost:8080/CampusZen
📖 Cómo Usar CampusZen
🔐 1. Registro e Inicio de Sesión

Crear una cuenta con correo y contraseña.

Iniciar sesión para acceder al panel principal.

📝 2. Crear una Tarea

Ir a la sección “Tareas”.

Hacer clic en “Nueva Tarea”.

Agregar:

Título

Descripción

Fecha límite

Guardar.

📅 3. Agregar un Examen

Ir a la sección “Exámenes”.

Registrar:

Materia

Fecha

Aula (opcional)

🗓 4. Gestionar Horarios

Añadir materias con:

Día de la semana

Hora de inicio y fin

🔔 5. Notificaciones

El sistema muestra alertas cuando:

Una tarea está próxima a vencer.

Un examen está cerca.

📂 Estructura del Proyecto
CampusZen/
│
├── src/
│   ├── servlets/
│   ├── models/
│   └── utils/
│
├── web/
│   ├── jsp/
│   ├── css/
│   └── js/
│
└── WEB-INF/
🎯 Objetivo Académico

Este proyecto fue desarrollado como parte de una práctica académica para aplicar:

Conexión a bases de datos con JDBC

Arquitectura MVC básica

Manejo de sesiones en JSP

CRUD completo con MySQL

🔮 Mejoras Futuras

Integración con Google Calendar

Recordatorios por correo electrónico

Diseño responsive mejorado

Panel de estadísticas de productividad

👨‍💻 Autores

Proyecto desarrollado por estudiantes como parte de su formación en desarrollo web con Java.
