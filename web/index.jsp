<%-- 
    Document   : index
    Created on : 3/03/2026, 7:02:43 p. m.
    Author     : santi
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SGA Web — Sistema de Gestión Académica</title>
    <style>
        /* ===== RESET & VARIABLES ===== */
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --primary:   #1a3a5c;
            --accent:    #0097a7;
            --accent2:   #00796b;
            --light:     #f4f7fb;
            --white:     #ffffff;
            --text:      #2d3748;
            --gray:      #718096;
            --border:    #e2e8f0;
            --nav-h:     70px;
        }

        html { scroll-behavior: smooth; }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--text);
            background: var(--white);
        }

        /* ===== HEADER / NAV ===== */
        header {
            position: sticky;
            top: 0;
            z-index: 1000;
            background: var(--primary);
            box-shadow: 0 2px 12px rgba(0,0,0,.25);
            height: var(--nav-h);
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 0 2rem;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: .6rem;
            text-decoration: none;
        }

        .logo-icon {
            width: 42px; height: 42px;
            background: var(--accent);
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.4rem;
        }

        .logo-text {
            color: #fff;
            font-size: 1.15rem;
            font-weight: 700;
            letter-spacing: .02em;
            line-height: 1.2;
        }

        .logo-text small {
            display: block;
            font-size: .65rem;
            font-weight: 400;
            color: rgba(255,255,255,.6);
            text-transform: uppercase;
            letter-spacing: .08em;
        }

        /* ===== MENÚ DE NAVEGACIÓN (5 opciones) ===== */
        nav ul {
            list-style: none;
            display: flex;
            gap: .25rem;
            align-items: center;
        }

        nav ul li a {
            display: block;
            padding: .55rem 1rem;
            border-radius: 8px;
            color: rgba(255,255,255,.8);
            text-decoration: none;
            font-size: .875rem;
            font-weight: 500;
            transition: background .18s, color .18s;
            /* Alternativa (Alt) requerida por el enunciado */
        }

        nav ul li a:hover {
            background: rgba(255,255,255,.12);
            color: #fff;
        }

        nav ul li a.active {
            background: rgba(0,151,167,.35);
            color: #fff;
        }

        .btn-nav-login {
            background: var(--accent) !important;
            color: #fff !important;
            padding: .55rem 1.2rem !important;
            font-weight: 600 !important;
        }

        .btn-nav-login:hover {
            background: var(--accent2) !important;
        }

        /* Menú hamburguesa para móvil */
        .hamburger {
            display: none;
            flex-direction: column;
            gap: 5px;
            cursor: pointer;
            padding: .5rem;
        }

        .hamburger span {
            width: 24px; height: 2px;
            background: #fff;
            border-radius: 2px;
            transition: all .3s;
        }

        /* ===== HERO ===== */
        .hero {
            min-height: calc(100vh - var(--nav-h));
            background: linear-gradient(135deg, var(--primary) 0%, #2a5298 50%, #1a3a5c 100%);
            display: flex;
            align-items: center;
            padding: 4rem 2rem;
        }

        .hero-inner {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            align-items: center;
        }

        .hero-text h1 {
            font-size: 3rem;
            font-weight: 800;
            color: #fff;
            line-height: 1.15;
            margin-bottom: 1.25rem;
        }

        .hero-text h1 span { color: #4dd0e1; }

        .hero-text p {
            color: rgba(255,255,255,.8);
            font-size: 1.05rem;
            line-height: 1.75;
            margin-bottom: 2rem;
        }

        .hero-btns {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-block;
            padding: .85rem 1.8rem;
            border-radius: 10px;
            font-size: .95rem;
            font-weight: 600;
            text-decoration: none;
            transition: transform .18s, box-shadow .18s;
        }

        .btn:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(0,0,0,.25); }

        .btn-primary { background: var(--accent); color: #fff; }
        .btn-ghost   { background: rgba(255,255,255,.12); color: #fff; border: 2px solid rgba(255,255,255,.35); }

        /* Imagen hero (SVG ilustrativo) */
        .hero-image {
            display: flex;
            justify-content: center;
        }

        .hero-img-box {
            width: 100%;
            max-width: 440px;
            background: rgba(255,255,255,.07);
            border-radius: 20px;
            padding: 2rem;
            border: 1px solid rgba(255,255,255,.12);
        }

        /* ===== SECCIONES ===== */
        section { padding: 5rem 2rem; }
        section:nth-child(even) { background: var(--light); }

        .section-inner { max-width: 1200px; margin: 0 auto; }

        .section-title {
            text-align: center;
            margin-bottom: 3rem;
        }

        .section-title h2 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: .6rem;
        }

        .section-title p { color: var(--gray); font-size: 1rem; }

        /* Cards de características */
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
        }

        .feature-card {
            background: var(--white);
            border-radius: 14px;
            padding: 1.75rem;
            border: 1px solid var(--border);
            transition: box-shadow .2s, transform .2s;
        }

        .feature-card:hover { box-shadow: 0 8px 28px rgba(0,0,0,.1); transform: translateY(-3px); }

        .feature-icon {
            width: 50px; height: 50px;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--accent), var(--accent2));
            display: flex; align-items: center; justify-content: center;
            font-size: 1.4rem;
            margin-bottom: 1rem;
        }

        .feature-card h3 { font-size: 1rem; font-weight: 700; color: var(--primary); margin-bottom: .5rem; }
        .feature-card p  { font-size: .875rem; color: var(--gray); line-height: 1.6; }

        /* Sección acerca */
        .about-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            align-items: center;
        }

        .about-img {
            background: linear-gradient(135deg, #e3f2fd, #b2ebf2);
            border-radius: 18px;
            height: 340px;
            display: flex; align-items: center; justify-content: center;
            font-size: 5rem;
        }

        .about-text h2 { font-size: 1.75rem; color: var(--primary); margin-bottom: 1rem; }
        .about-text p  { color: var(--gray); line-height: 1.75; margin-bottom: 1rem; font-size: .95rem; }

        /* Equipo */
        .team-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .team-card {
            text-align: center;
            padding: 2rem 1rem;
            background: var(--white);
            border-radius: 14px;
            border: 1px solid var(--border);
        }

        .avatar {
            width: 80px; height: 80px;
            border-radius: 50%;
            margin: 0 auto 1rem;
            display: flex; align-items: center; justify-content: center;
            font-size: 2rem;
            font-weight: 700;
            color: white;
        }

        .team-card h3 { font-size: .95rem; font-weight: 700; color: var(--primary); }
        .team-card p  { font-size: .8rem; color: var(--gray); }

        /* Contacto */
        .contact-box {
            max-width: 600px;
            margin: 0 auto;
            text-align: center;
        }

        .contact-box p { color: var(--gray); margin-bottom: 1.5rem; line-height: 1.7; }

        /* ===== FOOTER ===== */
        footer {
            background: var(--primary);
            color: rgba(255,255,255,.7);
            padding: 2.5rem 2rem;
            text-align: center;
        }

        footer .footer-inner {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        footer .footer-logo { color: #fff; font-weight: 700; font-size: 1rem; }
        footer p { font-size: .82rem; }
        footer .footer-links { display: flex; gap: 1.25rem; }
        footer .footer-links a { color: rgba(255,255,255,.6); text-decoration: none; font-size: .82rem; }
        footer .footer-links a:hover { color: #fff; }

        /* ===== RESPONSIVO ===== */
        @media (max-width: 768px) {
            .hamburger { display: flex; }

            nav ul {
                display: none;
                flex-direction: column;
                position: absolute;
                top: var(--nav-h);
                left: 0; right: 0;
                background: var(--primary);
                padding: 1rem 2rem 1.5rem;
                gap: .25rem;
                box-shadow: 0 8px 24px rgba(0,0,0,.3);
            }

            nav ul.open { display: flex; }
            nav ul li a { padding: .75rem 1rem; }

            .hero-inner     { grid-template-columns: 1fr; gap: 2.5rem; }
            .hero-text h1   { font-size: 2.2rem; }
            .hero-image     { display: none; }
            .about-grid     { grid-template-columns: 1fr; }
        }

        @media (max-width: 480px) {
            .hero-text h1 { font-size: 1.8rem; }
            .hero-btns    { flex-direction: column; }
        }
    </style>
</head>
<body>

<!-- ===== ENCABEZADO / HEADER ===== -->
<header>
    <div class="nav-container">
        <a href="index.jsp" class="logo" title="Sistema de Gestión Académica — Inicio">
            <div class="logo-icon">🎓</div>
            <div class="logo-text">
                SGA Web
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
                <!-- SVG representativo del sistema -->
                <svg viewBox="0 0 400 300" xmlns="http://www.w3.org/2000/svg" style="width:100%;border-radius:10px;">
                    <rect width="400" height="300" fill="#1e3a5c" rx="10"/>
                    <!-- Sidebar simulado -->
                    <rect x="0" y="0" width="90" height="300" fill="#152e4d" rx="10"/>
                    <circle cx="45" cy="40" r="18" fill="#0097a7"/>
                    <text x="45" y="46" text-anchor="middle" fill="white" font-size="14">🎓</text>
                    <rect x="10" y="75"  width="70" height="8" rx="4" fill="rgba(255,255,255,.5)"/>
                    <rect x="10" y="95"  width="70" height="8" rx="4" fill="rgba(255,255,255,.2)"/>
                    <rect x="10" y="115" width="70" height="8" rx="4" fill="rgba(255,255,255,.2)"/>
                    <rect x="10" y="135" width="70" height="8" rx="4" fill="rgba(255,255,255,.2)"/>
                    <rect x="10" y="155" width="70" height="8" rx="4" fill="rgba(255,255,255,.2)"/>
                    <!-- Contenido principal -->
                    <rect x="105" y="20"  width="140" height="60" rx="8" fill="#0097a7" opacity=".8"/>
                    <rect x="255" y="20"  width="130" height="60" rx="8" fill="#00796b" opacity=".8"/>
                    <rect x="105" y="95"  width="280" height="80" rx="8" fill="rgba(255,255,255,.08)"/>
                    <rect x="105" y="185" width="135" height="95" rx="8" fill="rgba(255,255,255,.08)"/>
                    <rect x="250" y="185" width="135" height="95" rx="8" fill="rgba(255,255,255,.08)"/>
                    <!-- Texto simulado -->
                    <rect x="115" y="33" width="80" height="6" rx="3" fill="rgba(255,255,255,.9)"/>
                    <rect x="115" y="46" width="55" height="6" rx="3" fill="rgba(255,255,255,.5)"/>
                    <rect x="115" y="105" width="120" height="5" rx="3" fill="rgba(255,255,255,.4)"/>
                    <rect x="115" y="118" width="90"  height="5" rx="3" fill="rgba(255,255,255,.25)"/>
                    <rect x="115" y="131" width="110" height="5" rx="3" fill="rgba(255,255,255,.25)"/>
                </svg>
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
            <div class="about-img">📚</div>
            <div class="about-text">
                <h2>¿Qué es SGA Web?</h2>
                <p>
                    SGA Web es una plataforma web académica desarrollada con tecnología JSP (JavaServer Pages)
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
                   title="Acceder al sistema SGA Web">Acceder al sistema</a>
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
                <div class="avatar" style="background:linear-gradient(135deg,#0097a7,#00796b);">AS</div>
                <h3>Ana Sofía García</h3>
                <p>Desarrollo Frontend · JSP &amp; CSS</p>
            </div>
            <div class="team-card">
                <div class="avatar" style="background:linear-gradient(135deg,#1a3a5c,#2a5298);">CL</div>
                <h3>Carlos López</h3>
                <p>Backend · Servlets &amp; MySQL</p>
            </div>
            <div class="team-card">
                <div class="avatar" style="background:linear-gradient(135deg,#6a1b9a,#4527a0);">MR</div>
                <h3>María Rodríguez</h3>
                <p>Análisis &amp; Diseño de BD</p>
            </div>
            <div class="team-card">
                <div class="avatar" style="background:linear-gradient(135deg,#e65100,#bf360c);">JP</div>
                <h3>Juan Pérez</h3>
                <p>Arquitectura &amp; Pruebas</p>
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
                📧 <strong>ybuenano@usbbog.edu.co</strong><br>
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
        <span class="footer-logo">🎓 SGA Web — Proyectos Académicos</span>
        <p>© 2026 — Universidad de San Buenaventura, Bogotá. Todos los derechos reservados.</p>
        <div class="footer-links">
            <a href="#inicio"         title="Inicio">Inicio</a>
            <a href="#funcionalidades" title="Funcionalidades">Funcionalidades</a>
            <a href="#equipo"         title="Equipo">Equipo</a>
            <a href="login.jsp"       title="Acceder al sistema">Acceder</a>
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
