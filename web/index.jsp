<%--
    Document   : index
    Created on : 3/03/2026, 7:02:43 p. m.
    Author     : santi
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampusZen — Sistema de Gestión Académica</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/Logo.png">
</head>
<body>

<!-- ===== ENCABEZADO / HEADER ===== -->
<header>
    <div class="nav-container">
        <a href="index.jsp" class="logo" title="Sistema de Gestión Académica — Inicio">
            <div class="brand-icon">
                <img src="img/Logo.png" alt="CampusZen Logo" width="90" height="70"/>
            </div>
            <div class="logo-text">
                CampusZen
                <small>Proyectos Académicos</small>
            </div>
        </a>

        <!-- Menú hamburguesa (móvil) -->
        <div class="hamburger" onclick="toggleMenu()" title="Abrir menú de navegación" role="button" aria-label="Menú">
            <span></span><span></span><span></span>
        </div>

        <!-- MENÚ DE NAVEGACIÓN — 5 opciones con ALT (title) -->
        <nav aria-label="Menú principal">
            <ul id="main-menu">
                <!-- Opción 1 -->
                <li>
                    <a href="#inicio" class="active"
                       title="Inicio — Página principal del sistema"
                       alt="Inicio">Inicio</a>
                </li>
                <!-- Opción 2 -->
                <li>
                    <a href="#funcionalidades"
                       title="Funcionalidades — Características del sistema"
                       alt="Funcionalidades">Funcionalidades</a>
                </li>
                <!-- Opción 3 -->
                <li>
                    <a href="#acerca"
                       title="Acerca de — Información sobre el sistema"
                       alt="Acerca de">Acerca de</a>
                </li>
                <!-- Opción 4 -->
                <li>
                    <a href="#equipo"
                       title="Equipo — Integrantes del proyecto"
                       alt="Equipo">Equipo</a>
                </li>
                <!-- Opción 5 -->
                <li>
                    <a href="#contacto"
                       title="Contacto — Comunícate con nosotros"
                       alt="Contacto">Contacto</a>
                </li>
                <!-- Acceder al sistema -->
                <li>
                    <a href="login.jsp" class="btn-nav-login"
                       title="Acceder — Iniciar sesión en el sistema"
                       alt="Acceder al sistema">Acceder →</a>
                </li>
            </ul>
        </nav>
    </div>
</header>

<!-- ===== PANTALLA PRINCIPAL / HERO ===== -->
<section class="hero" id="inicio">
    <div class="hero-inner">
        <div class="hero-text">
            <h1>Sistema de Gestión de <span>Proyectos Académicos</span></h1>
            <p>
                Plataforma web que permite a estudiantes y docentes gestionar proyectos académicos,
                asignar tareas, hacer seguimiento de avances y evaluar resultados de forma colaborativa.
            </p>
            <div class="hero-btns">
                <a href="login.jsp" class="btn btn-primary"
                   title="Acceder al sistema">Iniciar sesión</a>
                <a href="#funcionalidades" class="btn btn-ghost"
                   title="Ver características del sistema">Ver funcionalidades</a>
            </div>
        </div>

        <!-- IMAGEN de la aplicación -->
        <div class="hero-image">
            <div class="hero-img-box">
                <img src="img/images (1).jpg" alt="Title" width="318" height="238"/>
            </div>
        </div>
    </div>
</section>

<!-- ===== FUNCIONALIDADES ===== -->
<section id="funcionalidades">
    <div class="section-inner">
        <div class="section-title">
            <h2>Funcionalidades del Sistema</h2>
            <p>Todo lo que necesitas para gestionar proyectos académicos de forma efectiva</p>
        </div>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">🔐</div>
                <h3>Autenticación y Roles</h3>
                <p>Control de acceso con roles diferenciados: Administrador, Docente y Estudiante, cada uno con permisos específicos.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📁</div>
                <h3>Gestión de Proyectos</h3>
                <p>Crea y administra proyectos académicos con descripción, fechas de inicio y fin, y seguimiento de estado.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">✅</div>
                <h3>Asignación de Tareas</h3>
                <p>Asigna tareas a estudiantes con fechas límite y niveles de prioridad: Alta, Media o Baja.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📊</div>
                <h3>Seguimiento de Avances</h3>
                <p>Visualiza el progreso de cada proyecto con barras de avance y estado actualizado en tiempo real.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📧</div>
                <h3>Notificaciones</h3>
                <p>Alertas automáticas sobre vencimientos, asignaciones nuevas y cambios de estado en proyectos.</p>
            </div>
            <div class="feature-card">
                <div class="feature-icon">📱</div>
                <h3>Diseño Responsivo</h3>
                <p>Accede desde cualquier dispositivo: computador, tablet o celular, con una interfaz adaptativa.</p>
            </div>
        </div>
    </div>
</section>

<!-- ===== ACERCA DE ===== -->
<section id="acerca">
    <div class="section-inner">
        <div class="about-grid">
            <div class="about-img">
                <img src="img/images.jpg" alt="About us" width="360" height="320"/>
            </div>
            <div class="about-text">
                <h2>¿Qué es CampusZen?</h2>
                <p>
                    CampusZen es una plataforma web académica desarrollada con tecnología JSP (JavaServer Pages)
                    que facilita la gestión integral de proyectos universitarios entre estudiantes y docentes.
                </p>
                <p>
                    El sistema centraliza la información de proyectos, tareas y usuarios, permitiendo
                    un seguimiento claro del progreso y una comunicación eficiente entre los
                    participantes del proceso académico.
                </p>
                <p>
                    Desarrollado como proyecto de la asignatura <strong>Desarrollo de App Web</strong> —
                    Universidad de San Buenaventura, Bogotá.
                </p>
                <a href="login.jsp" class="btn btn-primary" style="margin-top:.5rem;"
                   title="Acceder al sistema CampusZen">Acceder al sistema</a>
            </div>
        </div>
    </div>
</section>

<!-- ===== EQUIPO ===== -->
<section id="equipo">
    <div class="section-inner">
        <div class="section-title">
            <h2>Equipo de Desarrollo</h2>
            <p>Estudiantes responsables del desarrollo de la plataforma</p>
        </div>
        <div class="team-grid">
            <div class="team-card">
                <div class="avatar" style="background:linear-gradient(135deg,#0097a7,#00796b);">SR</div>
                <h3>Santiago Ramirez</h3>
                <p>Desarrollador Full Stack</p>
            </div>
            <div class="team-card">
                <div class="avatar" style="background:linear-gradient(135deg,#1a3a5c,#2a5298);">SC</div>
                <h3>Sebastian Chacón</h3>
                <p>Desarrollador Full Stack</p>
            </div>
        </div>
    </div>
</section>

<!-- ===== CONTACTO ===== -->
<section id="contacto">
    <div class="section-inner">
        <div class="contact-box">
            <div class="section-title">
                <h2>Contacto</h2>
                <p>¿Tienes preguntas sobre el sistema?</p>
            </div>
            <p>
                Para soporte o información adicional, comunícate con el equipo de desarrollo
                o con el docente encargado de la asignatura.
            </p>
            <p>
                📧 <strong>CampusZen@gmail.com</strong><br>
                🏫 Universidad de San Buenaventura — Bogotá<br>
                📍 Aula GO-303
            </p>
            <a href="login.jsp" class="btn btn-primary" style="margin-top:1.5rem;"
               title="Ir a la pantalla de inicio de sesión">Acceder al Sistema →</a>
        </div>
    </div>
</section>

<!-- ===== PIE DE PÁGINA / FOOTER ===== -->
<footer>
    <div class="footer-inner">
        <span class="footer-logo">🎓 CampusZen — Proyectos Académicos</span>
        <p>© 2026 — Universidad de San Buenaventura, Bogotá. Todos los derechos reservados.</p>
        <div class="footer-links">
            <a href="#inicio"          title="Inicio">Inicio</a>
            <a href="#funcionalidades" title="Funcionalidades">Funcionalidades</a>
            <a href="#equipo"          title="Equipo">Equipo</a>
            <a href="login.jsp"        title="Acceder al sistema">Acceder</a>
        </div>
    </div>
</footer>

<script>
    // Menú hamburguesa (responsivo)
    function toggleMenu() {
        document.getElementById('main-menu').classList.toggle('open');
    }

    // Cierra el menú al hacer clic en un enlace (móvil)
    document.querySelectorAll('#main-menu a').forEach(link => {
        link.addEventListener('click', () => {
            document.getElementById('main-menu').classList.remove('open');
        });
    });

    // Resalta la opción activa del menú al hacer scroll
    const sections = document.querySelectorAll('section[id]');
    const navLinks  = document.querySelectorAll('nav ul li a:not(.btn-nav-login)');

    window.addEventListener('scroll', () => {
        let current = '';
        sections.forEach(s => {
            if (window.scrollY >= s.offsetTop - 100) current = s.id;
        });
        navLinks.forEach(a => {
            a.classList.remove('active');
            if (a.getAttribute('href') === '#' + current) a.classList.add('active');
        });
    });
</script>

</body>
</html>
