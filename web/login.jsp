<%--
    Document   : login
    Created on : 3/03/2026, 7:04:26 p. m.
    Author     : santi
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Controlador.LoginHandler" %>
<%
    /* Delegar la lógica de login/registro al helper LoginHandler */
    String errorMsg  = null;
    String activeTab = request.getParameter("tab");
    if (activeTab == null) activeTab = "login";

    if ("POST".equals(request.getMethod())) {
        String accion = request.getParameter("accion");
        String resultado = LoginHandler.procesar(request, session);

        if ("redirect".equals(resultado)) {
            response.sendRedirect("dashboard.jsp");
            return;
        } else {
            errorMsg  = resultado;
            activeTab = accion; // mantiene el tab activo en caso de error
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceder | CampusZen</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/Logo.png">
</head>
<body class="page-login">

<!-- ENCABEZADO -->
<header class="login-header-bar">
    <a href="index.jsp" class="header-logo" title="Volver al inicio — CampusZen">
        <div class="brand-icon">
            <img src="img/Logo.png" alt="CampusZen Logo" width="90" height="70"/>
        </div>
         CampusZen
    </a>
    <a href="index.jsp" class="header-back" title="Regresar a la página principal">
        ← Volver al inicio
    </a>
</header>

<!-- PANTALLA DE ACCESO -->
<div class="login-wrap">
    <div class="login-card">

        <!-- Tabs: Iniciar sesión / Crear cuenta -->
        <div class="tabs">
            <button class="tab-btn <%= "login".equals(activeTab) ? "active" : "" %>"
                    onclick="showTab('login')"
                    title="Iniciar sesión con credenciales existentes">
                Iniciar Sesión
            </button>
            <button class="tab-btn <%= "registro".equals(activeTab) ? "active" : "" %>"
                    onclick="showTab('registro')"
                    title="Crear una nueva cuenta de usuario">
                Crear Cuenta
            </button>
        </div>

        <!-- ===== TAB 1: LOGIN ===== -->
        <div class="tab-content" id="tab-login"
             style="display:<%= "login".equals(activeTab) ? "block" : "none" %>">

            <div class="login-title-block">
                <div class="login-icon">🔐</div>
                <h2>Bienvenido</h2>
                <p>Ingresa tus credenciales para acceder</p>
            </div>

            <% if (errorMsg != null && "login".equals(activeTab)) { %>
                <div class="alert-error">⚠️ <%= errorMsg %></div>
            <% } %>

            <form method="POST" action="login.jsp">
                <input type="hidden" name="accion" value="login">
                <input type="hidden" name="tab"    value="login">

                <!-- Campo: Usuario -->
                <div class="form-group">
                    <label for="usuario">Usuario</label>
                    <input type="text"
                           id="usuario"
                           name="usuario"
                           placeholder="Tu nombre de usuario"
                           required
                           title="Escribe tu nombre de usuario"
                           alt="Campo de usuario">
                </div>

                <!-- Campo: Contraseña -->
                <div class="form-group">
                    <label for="password">Contraseña</label>
                    <input type="password"
                           id="password"
                           name="password"
                           placeholder="••••••••"
                           required
                           title="Escribe tu contraseña"
                           alt="Campo de contraseña">
                </div>

                <button type="submit"
                        class="btn-submit"
                        title="Validar credenciales y acceder al dashboard">
                    Acceder al Sistema →
                </button>
            </form>

            <div class="credentials-hint">
                <strong>💡 Validación simulada</strong>
                Ingresa cualquier usuario y contraseña para acceder.
                El sistema simula la autenticación sin base de datos.
            </div>
        </div>

        <!-- ===== TAB 2: REGISTRO ===== -->
        <div class="tab-content" id="tab-registro"
             style="display:<%= "registro".equals(activeTab) ? "block" : "none" %>">

            <div class="login-title-block">
                <div class="login-icon">👤</div>
                <h2>Crear Cuenta</h2>
                <p>Completa el formulario para registrarte</p>
            </div>

            <% if (errorMsg != null && "registro".equals(activeTab)) { %>
                <div class="alert-error">⚠️ <%= errorMsg %></div>
            <% } %>

            <form method="POST" action="login.jsp">
                <input type="hidden" name="accion" value="registro">
                <input type="hidden" name="tab"    value="registro">

                <div class="form-group">
                    <label for="nombre">Nombre completo</label>
                    <input type="text"
                           id="nombre"
                           name="nombre"
                           placeholder="Ej: Ana García"
                           required
                           title="Ingresa tu nombre completo">
                </div>

                <div class="form-group">
                    <label for="email">Correo electrónico</label>
                    <input type="email"
                           id="email"
                           name="email"
                           placeholder="correo@universidad.edu"
                           required
                           title="Ingresa tu correo institucional">
                </div>

                <div class="form-group">
                    <label for="newPassword">Contraseña</label>
                    <input type="password"
                           id="newPassword"
                           name="newPassword"
                           placeholder="Mínimo 8 caracteres"
                           required
                           title="Crea una contraseña segura">
                </div>

                <div class="form-group">
                    <label for="rol">Tipo de usuario</label>
                    <select id="rol" name="rol" title="Selecciona tu rol en el sistema">
                        <option value="Estudiante">Estudiante</option>
                        <option value="Docente">Docente</option>
                    </select>
                </div>

                <button type="submit"
                        class="btn-submit btn-submit-green"
                        title="Registrar cuenta y acceder al sistema">
                    Crear mi cuenta →
                </button>
            </form>
        </div>

    </div>
</div>

<!-- PIE DE PÁGINA -->
<footer class="login-footer">
    © 2026 CampusZen — Universidad de San Buenaventura, Bogotá
</footer>

<script>
    function showTab(tab) {
        document.getElementById('tab-login').style.display    = (tab === 'login')    ? 'block' : 'none';
        document.getElementById('tab-registro').style.display = (tab === 'registro') ? 'block' : 'none';

        document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
        event.target.classList.add('active');
    }
</script>

</body>
</html>
