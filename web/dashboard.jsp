<%--
    Document   : dashboard
    Created on : 3/03/2026, 7:03:21 p. m.
    Author     : santi
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Controlador.SessionHelper" %>
<%
    /* Verificar sesión y manejar cierre */
    String usuarioSesion = SessionHelper.getUsuario(session);
    String rolUsuario    = SessionHelper.getRol(session);

    if (usuarioSesion == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    if ("cerrar".equals(request.getParameter("accion"))) {
        session.invalidate();
        response.sendRedirect("index.jsp?msg=logout");
        return;
    }

    String inicial = String.valueOf(usuarioSesion.charAt(0)).toUpperCase();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | CampusZen</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/Logo.png">
</head>
<body class="page-dashboard">

<!-- ===== HEADER FIJO ===== -->
<header class="dash-header">
    <!-- Botón menú móvil -->
    <button class="menu-toggle"
            onclick="toggleSidebar()"
            title="Abrir o cerrar el menú lateral"
            aria-label="Menú">☰</button>

    <!-- Logo / Título -->
    <div class="header-brand">
        <div class="brand-icon">
            <img src="img/Logo.png" alt="CampusZen Logo" width="90" height="70"/>
        </div>
        <div class="header-title-text">
            CampusZen
            <small>Proyectos Académicos</small>
        </div>
    </div>

    <div class="header-right">
        <!-- Imagen en la cabecera -->
        <span class="header-logo-img" title="Sistema de Gestión Académica"></span>

        <!-- Usuario en sesión -->
        <div class="header-user" title="Usuario en sesión">
            <div class="user-avatar"><%= inicial %></div>
            <div class="user-info-text">
                <strong><%= usuarioSesion %></strong>
                <span><%= rolUsuario %></span>
            </div>
        </div>

        <!-- Cerrar sesión -->
        <a href="dashboard.jsp?accion=cerrar"
           class="btn-logout"
           title="Cerrar sesión y volver al inicio"
           onclick="return confirm('¿Deseas cerrar sesión?')">
            🚪 Cerrar Sesión
        </a>
    </div>
</header>

<!-- ===== SIDEBAR ===== -->
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

<!-- ===== CONTENIDO PRINCIPAL ===== -->
<main class="main">

    <!-- ===== PANEL 1: RESUMEN ===== -->
    <div class="panel active" id="panel-resumen">
        <div class="panel-header">
            <h2>Bienvenido, <%= usuarioSesion %> 👋</h2>
            <p>Aquí tienes un resumen de tus actividades académicas</p>
        </div>

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
                        <td><span class="badge badge-low">Baja</span></td>
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
    function showPanel(panelId, btn) {
        document.querySelectorAll('.panel').forEach(p => p.classList.remove('active'));
        document.querySelectorAll('.nav-btn').forEach(b => b.classList.remove('active'));
        document.getElementById('panel-' + panelId).classList.add('active');
        if (btn) btn.classList.add('active');
        if (window.innerWidth <= 768) {
            document.getElementById('sidebar').classList.remove('open');
        }
    }

    function toggleSidebar() {
        document.getElementById('sidebar').classList.toggle('open');
    }
</script>

</body>
</html>
