<%-- 
    Document   : dashboard
    Created on : 3/03/2026, 7:03:21 p. m.
    Author     : santi
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    /* ============================================================
       PANTALLA 3 — DASHBOARD
       Navegación en la MISMA PANTALLA (sin abrir nuevas ventanas).
       Muestra/oculta secciones con JavaScript.
       ============================================================ */

    // Verificar sesión
    String usuarioSesion = (String) session.getAttribute("usuarioSesion");
    String rolUsuario    = (String) session.getAttribute("rolUsuario");

    if (usuarioSesion == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Cerrar sesión (simulado)
    if ("cerrar".equals(request.getParameter("accion"))) {
        session.invalidate();
        response.sendRedirect("index.jsp?msg=logout");
        return;
    }

    if (rolUsuario == null) rolUsuario = "Estudiante";
    // Inicial del avatar
    String inicial = String.valueOf(usuarioSesion.charAt(0)).toUpperCase();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | SGA Web</title>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --primary:    #1a3a5c;
            --sidebar-bg: #152e4d;
            --accent:     #0097a7;
            --accent2:    #00796b;
            --light:      #f4f7fb;
            --white:      #ffffff;
            --text:       #2d3748;
            --gray:       #718096;
            --border:     #e2e8f0;
            --sw:         240px;   /* ancho del sidebar */
            --hw:         64px;    /* alto del header */
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: var(--light);
            color: var(--text);
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* ===========================
           HEADER FIJO
           =========================== */
        .dash-header {
            position: fixed;
            top: 0; left: 0; right: 0;
            height: var(--hw);
            background: var(--primary);
            display: flex;
            align-items: center;
            z-index: 200;
            box-shadow: 0 2px 12px rgba(0,0,0,.25);
        }

        /* Botón hamburguesa (móvil) */
        .menu-toggle {
            display: none;
            background: none;
            border: none;
            color: white;
            font-size: 1.4rem;
            cursor: pointer;
            padding: .5rem 1rem;
        }

        .header-brand {
            width: var(--sw);
            display: flex;
            align-items: center;
            gap: .6rem;
            padding: 0 1.2rem;
            flex-shrink: 0;
        }

        .header-brand .brand-icon {
            width: 36px; height: 36px;
            background: var(--accent);
            border-radius: 9px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.1rem;
        }

        /* TÍTULO DE LA APP en la cabecera */
        .header-title-text {
            color: white;
            font-size: .9rem;
            font-weight: 700;
            line-height: 1.2;
        }

        .header-title-text small {
            display: block;
            font-size: .65rem;
            font-weight: 400;
            color: rgba(255,255,255,.55);
        }

        .header-right {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: flex-end;
            padding: 0 1.5rem;
            gap: 1rem;
        }

        /* Nombre del usuario en sesión */
        .header-user {
            display: flex;
            align-items: center;
            gap: .6rem;
            color: rgba(255,255,255,.85);
            font-size: .875rem;
        }

        .user-avatar {
            width: 36px; height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--accent), var(--accent2));
            display: flex; align-items: center; justify-content: center;
            font-weight: 700;
            font-size: .9rem;
            color: white;
        }

        .user-info-text strong { display: block; color: white; font-size: .85rem; }
        .user-info-text span   { font-size: .72rem; color: rgba(255,255,255,.5); }

        /* Imagen en la cabecera */
        .header-logo-img {
            font-size: 1.6rem;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,.3));
        }

        /* Botón cerrar sesión */
        .btn-logout {
            display: flex;
            align-items: center;
            gap: .4rem;
            padding: .45rem 1rem;
            background: rgba(255,255,255,.1);
            border: 1px solid rgba(255,255,255,.2);
            border-radius: 8px;
            color: rgba(255,255,255,.8);
            font-size: .8rem;
            font-family: inherit;
            cursor: pointer;
            text-decoration: none;
            transition: background .18s, color .18s;
        }

        .btn-logout:hover {
            background: rgba(239,68,68,.2);
            border-color: rgba(239,68,68,.4);
            color: #fca5a5;
        }

        /* ===========================
           SIDEBAR — lista de acciones
           =========================== */
        .sidebar {
            position: fixed;
            top: var(--hw);
            left: 0;
            width: var(--sw);
            height: calc(100vh - var(--hw));
            background: var(--sidebar-bg);
            display: flex;
            flex-direction: column;
            z-index: 100;
            overflow-y: auto;
            transition: transform .3s;
        }

        .nav-section-label {
            padding: 1.2rem 1.2rem .4rem;
            font-size: .65rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .1em;
            color: rgba(255,255,255,.3);
        }

        /* Opciones del menú del Dashboard (mínimo 4) */
        .nav-btn {
            display: flex;
            align-items: center;
            gap: .7rem;
            padding: .75rem 1.2rem;
            background: none;
            border: none;
            border-left: 3px solid transparent;
            color: rgba(255,255,255,.6);
            font-family: inherit;
            font-size: .875rem;
            cursor: pointer;
            width: 100%;
            text-align: left;
            transition: all .18s;
        }

        .nav-btn:hover {
            background: rgba(255,255,255,.07);
            color: white;
        }

        .nav-btn.active {
            background: rgba(0,151,167,.15);
            border-left-color: var(--accent);
            color: #4dd0e1;
            font-weight: 600;
        }

        .nav-btn .nav-icon { font-size: 1.05rem; width: 22px; text-align: center; }

        /* ===========================
           CONTENIDO PRINCIPAL
           =========================== */
        .main {
            margin-left: var(--sw);
            margin-top: var(--hw);
            padding: 1.75rem;
            flex: 1;
            min-height: calc(100vh - var(--hw));
        }

        /* Paneles de contenido — mostrados/ocultados con JS */
        .panel { display: none; }
        .panel.active { display: block; }

        /* Encabezado de sección */
        .panel-header {
            margin-bottom: 1.5rem;
        }

        .panel-header h2 {
            font-size: 1.6rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: .25rem;
        }

        .panel-header p { color: var(--gray); font-size: .875rem; }

        /* Tarjetas de estadísticas */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(170px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 1.25rem;
            display: flex;
            align-items: center;
            gap: .9rem;
            box-shadow: 0 1px 3px rgba(0,0,0,.06);
            border-left: 4px solid var(--accent);
        }

        .stat-icon {
            width: 44px; height: 44px;
            border-radius: 10px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.3rem;
        }

        .stat-num   { font-size: 1.75rem; font-weight: 700; color: var(--primary); }
        .stat-label { font-size: .78rem; color: var(--gray); }

        /* Tabla de datos */
        .card {
            background: white;
            border-radius: 12px;
            padding: 1.4rem;
            box-shadow: 0 1px 3px rgba(0,0,0,.06);
            margin-bottom: 1.25rem;
        }

        .card-title {
            font-size: .95rem;
            font-weight: 700;
            color: var(--primary);
            margin-bottom: 1rem;
            padding-bottom: .75rem;
            border-bottom: 1px solid var(--border);
        }

        table { width: 100%; border-collapse: collapse; font-size: .875rem; }
        thead th {
            text-align: left;
            padding: .7rem .9rem;
            background: var(--light);
            color: #4a5568;
            font-size: .72rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .07em;
        }
        tbody td { padding: .8rem .9rem; border-bottom: 1px solid #f7fafc; }
        tbody tr:last-child td { border-bottom: none; }
        tbody tr:hover { background: #f7fafc; }

        /* Badges */
        .badge {
            display: inline-block;
            padding: .2rem .65rem;
            border-radius: 999px;
            font-size: .7rem;
            font-weight: 700;
            text-transform: uppercase;
        }
        .badge-green  { background: #c6f6d5; color: #276749; }
        .badge-blue   { background: #bee3f8; color: #2a4365; }
        .badge-yellow { background: #fefcbf; color: #744210; }
        .badge-red    { background: #fed7d7; color: #822727; }

        /* Formulario de perfil */
        .form-profile { max-width: 500px; }
        .form-row { margin-bottom: 1rem; }
        .form-row label { display: block; font-size: .78rem; font-weight: 700; color: #4a5568; margin-bottom: .4rem; text-transform: uppercase; letter-spacing: .06em; }
        .form-row input, .form-row select {
            width: 100%; padding: .65rem .9rem; border: 2px solid var(--border);
            border-radius: 9px; font-family: inherit; font-size: .875rem;
            color: var(--primary); outline: none; transition: border-color .2s;
        }
        .form-row input:focus, .form-row select:focus { border-color: var(--accent); }
        .btn-save {
            padding: .65rem 1.4rem; background: var(--primary); color: white;
            border: none; border-radius: 9px; font-family: inherit; font-size: .875rem;
            font-weight: 600; cursor: pointer; transition: transform .18s;
        }
        .btn-save:hover { transform: translateY(-2px); }

        /* Notificaciones */
        .notif-item {
            display: flex; align-items: flex-start; gap: .9rem;
            padding: .9rem; border-radius: 10px; margin-bottom: .7rem;
            background: var(--light); border-left: 3px solid var(--accent);
        }
        .notif-icon { font-size: 1.2rem; }
        .notif-text strong { display: block; font-size: .88rem; color: var(--primary); }
        .notif-text span   { font-size: .78rem; color: var(--gray); }

        /* ===== RESPONSIVO ===== */
        @media (max-width: 768px) {
            .menu-toggle { display: block; }
            .sidebar { transform: translateX(-100%); }
            .sidebar.open { transform: translateX(0); }
            .main { margin-left: 0; }
            .header-brand { display: none; }
        }

        @media (max-width: 480px) {
            .main { padding: 1rem; }
            .stats-grid { grid-template-columns: 1fr 1fr; }
        }
    </style>
</head>
<body>

<!-- ===========================
     HEADER FIJO — PANTALLA 3
     =========================== -->
<header class="dash-header">
    <!-- Botón menú móvil -->
    <button class="menu-toggle"
            onclick="toggleSidebar()"
            title="Abrir o cerrar el menú lateral"
            aria-label="Menú">☰</button>

    <!-- Logo / Título en cabecera -->
    <div class="header-brand">
        <div class="brand-icon">🎓</div>
        <div class="header-title-text">
            SGA Web
            <small>Proyectos Académicos</small>
        </div>
    </div>

    <div class="header-right">
        <!-- IMAGEN en la cabecera -->
        <span class="header-logo-img" title="Sistema de Gestión Académica">📚</span>

        <!-- NOMBRE DEL USUARIO EN SESIÓN -->
        <div class="header-user" title="Usuario en sesión">
            <div class="user-avatar"><%= inicial %></div>
            <div class="user-info-text">
                <strong><%= usuarioSesion %></strong>
                <span><%= rolUsuario %></span>
            </div>
        </div>

        <!-- CERRAR SESIÓN (simulado) -->
        <a href="dashboard.jsp?accion=cerrar"
           class="btn-logout"
           title="Cerrar sesión y volver al inicio"
           onclick="return confirm('¿Deseas cerrar sesión?')">
            🚪 Cerrar Sesión
        </a>
    </div>
</header>

<!-- ===========================
     SIDEBAR — MENÚ DEL DASHBOARD
     (mínimo 4 opciones)
     La navegación ocurre en la misma pantalla
     =========================== -->
<aside class="sidebar" id="sidebar">
    <div class="nav-section-label">Dashboard</div>

    <!-- OPCIÓN 1 -->
    <button class="nav-btn active"
            onclick="showPanel('resumen', this)"
            title="Resumen — Vista general del sistema"
            alt="Resumen general">
        <span class="nav-icon">📊</span> Resumen
    </button>

    <div class="nav-section-label">Gestión</div>

    <!-- OPCIÓN 2 -->
    <button class="nav-btn"
            onclick="showPanel('proyectos', this)"
            title="Proyectos — Gestión de proyectos académicos"
            alt="Mis Proyectos">
        <span class="nav-icon">📁</span> Mis Proyectos
    </button>

    <!-- OPCIÓN 3 -->
    <button class="nav-btn"
            onclick="showPanel('tareas', this)"
            title="Tareas — Ver y gestionar tareas asignadas"
            alt="Mis Tareas">
        <span class="nav-icon">✅</span> Mis Tareas
    </button>

    <!-- OPCIÓN 4 -->
    <button class="nav-btn"
            onclick="showPanel('notificaciones', this)"
            title="Notificaciones — Alertas y avisos del sistema"
            alt="Notificaciones">
        <span class="nav-icon">🔔</span> Notificaciones
    </button>

    <!-- OPCIÓN 5 -->
    <button class="nav-btn"
            onclick="showPanel('perfil', this)"
            title="Mi Perfil — Ver y editar datos del usuario"
            alt="Mi Perfil">
        <span class="nav-icon">👤</span> Mi Perfil
    </button>
</aside>

<!-- ===========================
     CONTENIDO PRINCIPAL
     Los paneles se muestran/ocultan con JS
     sin abrir nuevas ventanas
     =========================== -->
<main class="main">

    <!-- ===== PANEL 1: RESUMEN ===== -->
    <div class="panel active" id="panel-resumen">
        <div class="panel-header">
            <h2>Bienvenido, <%= usuarioSesion %> 👋</h2>
            <p>Aquí tienes un resumen de tus actividades académicas</p>
        </div>

        <!-- Tarjetas de estadísticas -->
        <div class="stats-grid">
            <div class="stat-card" style="border-left-color:#3182ce;">
                <div class="stat-icon" style="background:#ebf8ff;">📁</div>
                <div>
                    <div class="stat-num">3</div>
                    <div class="stat-label">Proyectos activos</div>
                </div>
            </div>
            <div class="stat-card" style="border-left-color:#d69e2e;">
                <div class="stat-icon" style="background:#fffff0;">⏳</div>
                <div>
                    <div class="stat-num">7</div>
                    <div class="stat-label">Tareas pendientes</div>
                </div>
            </div>
            <div class="stat-card" style="border-left-color:#38a169;">
                <div class="stat-icon" style="background:#f0fff4;">✅</div>
                <div>
                    <div class="stat-num">12</div>
                    <div class="stat-label">Tareas completadas</div>
                </div>
            </div>
            <div class="stat-card" style="border-left-color:#e53e3e;">
                <div class="stat-icon" style="background:#fff5f5;">🚨</div>
                <div>
                    <div class="stat-num">2</div>
                    <div class="stat-label">Vencidas</div>
                </div>
            </div>
        </div>

        <!-- Actividad reciente -->
        <div class="card">
            <div class="card-title">📋 Actividad Reciente</div>
            <table>
                <thead>
                    <tr>
                        <th>Actividad</th>
                        <th>Proyecto</th>
                        <th>Fecha</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Diseño de mockups</td>
                        <td>App Móvil de Salud</td>
                        <td>28/02/2026</td>
                        <td><span class="badge badge-green">Completado</span></td>
                    </tr>
                    <tr>
                        <td>Backend API REST</td>
                        <td>App Móvil de Salud</td>
                        <td>15/03/2026</td>
                        <td><span class="badge badge-blue">En progreso</span></td>
                    </tr>
                    <tr>
                        <td>Modelo de BD</td>
                        <td>Sistema de Inventario</td>
                        <td>10/03/2026</td>
                        <td><span class="badge badge-yellow">Pendiente</span></td>
                    </tr>
                    <tr>
                        <td>Reportes PDF</td>
                        <td>Sistema de Inventario</td>
                        <td>01/03/2026</td>
                        <td><span class="badge badge-red">Vencida</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- ===== PANEL 2: PROYECTOS ===== -->
    <div class="panel" id="panel-proyectos">
        <div class="panel-header">
            <h2>📁 Mis Proyectos</h2>
            <p>Proyectos académicos asignados a tu cuenta</p>
        </div>

        <div class="card">
            <div class="card-title">Lista de Proyectos</div>
            <table>
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Docente</th>
                        <th>Inicio</th>
                        <th>Fin</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>App Móvil de Salud</strong></td>
                        <td>Dr. Martínez</td>
                        <td>15/01/2026</td>
                        <td>30/06/2026</td>
                        <td><span class="badge badge-blue">En progreso</span></td>
                    </tr>
                    <tr>
                        <td><strong>Sistema de Inventario</strong></td>
                        <td>Dr. Martínez</td>
                        <td>01/02/2026</td>
                        <td>15/07/2026</td>
                        <td><span class="badge badge-yellow">Activo</span></td>
                    </tr>
                    <tr>
                        <td><strong>Plataforma E-Learning</strong></td>
                        <td>Dra. López</td>
                        <td>01/03/2026</td>
                        <td>30/11/2026</td>
                        <td><span class="badge badge-green">Activo</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- ===== PANEL 3: TAREAS ===== -->
    <div class="panel" id="panel-tareas">
        <div class="panel-header">
            <h2>✅ Mis Tareas</h2>
            <p>Tareas asignadas con su estado actual</p>
        </div>

        <div class="card">
            <div class="card-title">Tareas Asignadas</div>
            <table>
                <thead>
                    <tr>
                        <th>Tarea</th>
                        <th>Proyecto</th>
                        <th>Prioridad</th>
                        <th>Fecha límite</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Diseño de mockups</td>
                        <td>App Móvil de Salud</td>
                        <td><span class="badge badge-red">Alta</span></td>
                        <td>01/03/2026</td>
                        <td><span class="badge badge-green">Completada</span></td>
                    </tr>
                    <tr>
                        <td>Módulo de login</td>
                        <td>App Móvil de Salud</td>
                        <td><span class="badge badge-yellow">Media</span></td>
                        <td>30/03/2026</td>
                        <td><span class="badge badge-yellow">Pendiente</span></td>
                    </tr>
                    <tr>
                        <td>Modelo de BD</td>
                        <td>Sistema de Inventario</td>
                        <td><span class="badge badge-red">Alta</span></td>
                        <td>10/03/2026</td>
                        <td><span class="badge badge-green">Completada</span></td>
                    </tr>
                    <tr>
                        <td>Integración API</td>
                        <td>Sistema de Inventario</td>
                        <td><span class="badge badge-yellow">Media</span></td>
                        <td>01/02/2026</td>
                        <td><span class="badge badge-red">Vencida</span></td>
                    </tr>
                    <tr>
                        <td>Manual de usuario</td>
                        <td>Plataforma E-Learning</td>
                        <td><span class="badge" style="background:#f0fff4;color:#276749;">Baja</span></td>
                        <td>15/04/2026</td>
                        <td><span class="badge badge-blue">En progreso</span></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

    <!-- ===== PANEL 4: NOTIFICACIONES ===== -->
    <div class="panel" id="panel-notificaciones">
        <div class="panel-header">
            <h2>🔔 Notificaciones</h2>
            <p>Alertas y avisos importantes del sistema</p>
        </div>

        <div class="card">
            <div class="card-title">Alertas Recientes</div>
            <div class="notif-item" style="border-left-color:#e53e3e;">
                <span class="notif-icon">🚨</span>
                <div class="notif-text">
                    <strong>Tarea vencida: Integración API</strong>
                    <span>La tarea venció el 01/02/2026 y no fue completada · Proyecto: Sistema de Inventario</span>
                </div>
            </div>
            <div class="notif-item" style="border-left-color:#d69e2e;">
                <span class="notif-icon">⏰</span>
                <div class="notif-text">
                    <strong>Tarea próxima a vencer: Módulo de login</strong>
                    <span>Vence el 30/03/2026 · Faltan 27 días · Prioridad: Media</span>
                </div>
            </div>
            <div class="notif-item" style="border-left-color:#38a169;">
                <span class="notif-icon">✅</span>
                <div class="notif-text">
                    <strong>Tarea completada exitosamente</strong>
                    <span>Diseño de mockups fue marcada como completada el 28/02/2026</span>
                </div>
            </div>
            <div class="notif-item">
                <span class="notif-icon">📁</span>
                <div class="notif-text">
                    <strong>Nuevo proyecto asignado: Plataforma E-Learning</strong>
                    <span>Fuiste inscrito en el proyecto por Dra. López el 01/03/2026</span>
                </div>
            </div>
            <div class="notif-item">
                <span class="notif-icon">📧</span>
                <div class="notif-text">
                    <strong>Correo enviado al docente</strong>
                    <span>Reporte de avance del proyecto App Móvil de Salud enviado el 25/02/2026</span>
                </div>
            </div>
        </div>
    </div>

    <!-- ===== PANEL 5: PERFIL ===== -->
    <div class="panel" id="panel-perfil">
        <div class="panel-header">
            <h2>👤 Mi Perfil</h2>
            <p>Información y configuración de tu cuenta</p>
        </div>

        <div class="card">
            <div class="card-title">Datos del Usuario</div>
            <div class="form-profile">
                <div class="form-row">
                    <label>Nombre completo</label>
                    <input type="text" value="<%= usuarioSesion %>" title="Nombre del usuario">
                </div>
                <div class="form-row">
                    <label>Correo electrónico</label>
                    <input type="email" value="<%= usuarioSesion.toLowerCase().replaceAll(" ","") %>@universidad.edu" title="Correo del usuario">
                </div>
                <div class="form-row">
                    <label>Rol en el sistema</label>
                    <input type="text" value="<%= rolUsuario %>" readonly title="Rol asignado al usuario">
                </div>
                <div class="form-row">
                    <label>Institución</label>
                    <input type="text" value="Universidad de San Buenaventura" readonly title="Institución educativa">
                </div>
                <div class="form-row">
                    <label>Nueva contraseña</label>
                    <input type="password" placeholder="••••••••" title="Escribe tu nueva contraseña">
                </div>
                <button class="btn-save" title="Guardar cambios del perfil">
                    💾 Guardar cambios
                </button>
            </div>
        </div>
    </div>

</main>

<script>
    /* =====================================================
       NAVEGACIÓN EN LA MISMA PANTALLA — SIN NUEVAS VENTANAS
       ===================================================== */
    function showPanel(panelId, btn) {
        // Ocultar todos los paneles
        document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));
        // Quitar clase active de todos los botones
        document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));

        // Mostrar el panel seleccionado
        document.getElementById('panel-' + panelId).classList.add('active');
        // Marcar botón activo
        if (btn) btn.classList.add('active');

        // En móvil: cerrar sidebar al navegar
        if (window.innerWidth <= 768) {
            document.getElementById('sidebar').classList.remove('open');
        }
    }

    // Sidebar móvil
    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('open');
    }
</script>

</body>
</html>
