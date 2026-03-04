<%-- 
    Document   : login
    Created on : 3/03/2026, 7:04:26 p. m.
    Author     : santi
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    /* ============================================================
       PANTALLA 2 — LOGIN (validación simulada, sin base de datos)
       Si el usuario no tiene credenciales puede crear una cuenta.
       ============================================================ */

    // Procesar el formulario de LOGIN
    String errorMsg  = null;
    String activeTab = request.getParameter("tab");
    if (activeTab == null) activeTab = "login";

    if ("POST".equals(request.getMethod())) {
        String accion = request.getParameter("accion");

        if ("login".equals(accion)) {
            String usuario  = request.getParameter("usuario");
            String password = request.getParameter("password");

            // Validación simulada: campos no vacíos = acceso concedido
            if (usuario != null && !usuario.trim().isEmpty()
                && password != null && !password.isEmpty()) {
                // Guardar usuario en sesión
                session.setAttribute("usuarioSesion", usuario.trim());
                session.setAttribute("rolUsuario", "Estudiante"); // rol por defecto
                response.sendRedirect("dashboard.jsp");
                return;
            } else {
                errorMsg  = "Debes ingresar usuario y contraseña.";
                activeTab = "login";
            }
        }

        if ("registro".equals(accion)) {
            String nombre    = request.getParameter("nombre");
            String email     = request.getParameter("email");
            String newPass   = request.getParameter("newPassword");
            String rol       = request.getParameter("rol");

            if (nombre != null && !nombre.trim().isEmpty()
                && email != null && !email.trim().isEmpty()
                && newPass != null && !newPass.isEmpty()) {
                // Simulación: registrar y redirigir al dashboard
                session.setAttribute("usuarioSesion", nombre.trim());
                session.setAttribute("rolUsuario", rol != null ? rol : "Estudiante");
                response.sendRedirect("dashboard.jsp");
                return;
            } else {
                errorMsg  = "Completa todos los campos del registro.";
                activeTab = "registro";
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceder | SGA Web</title>
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --primary: #1a3a5c;
            --accent:  #0097a7;
            --light:   #f4f7fb;
            --white:   #ffffff;
            --gray:    #718096;
            --border:  #e2e8f0;
            --error:   #c53030;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--primary) 0%, #2a5298 60%, #1a3a5c 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* ENCABEZADO */
        header {
            background: rgba(255,255,255,.08);
            backdrop-filter: blur(10px);
            padding: 1rem 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid rgba(255,255,255,.1);
        }

        .header-logo {
            display: flex;
            align-items: center;
            gap: .6rem;
            text-decoration: none;
            color: white;
            font-size: 1rem;
            font-weight: 700;
        }

        .header-logo span { font-size: 1.5rem; }

        .header-back {
            color: rgba(255,255,255,.7);
            text-decoration: none;
            font-size: .875rem;
            transition: color .2s;
        }

        .header-back:hover { color: white; }

        /* CONTENEDOR PRINCIPAL */
        .login-wrap {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }

        .login-card {
            background: white;
            border-radius: 18px;
            box-shadow: 0 20px 60px rgba(0,0,0,.3);
            width: 100%;
            max-width: 420px;
            overflow: hidden;
        }

        /* Tabs */
        .tabs {
            display: flex;
            background: var(--light);
            border-bottom: 1px solid var(--border);
        }

        .tab-btn {
            flex: 1;
            padding: 1rem;
            border: none;
            background: transparent;
            font-family: inherit;
            font-size: .9rem;
            font-weight: 600;
            color: var(--gray);
            cursor: pointer;
            transition: all .2s;
            border-bottom: 3px solid transparent;
        }

        .tab-btn.active {
            color: var(--primary);
            background: white;
            border-bottom-color: var(--accent);
        }

        /* Formulario */
        .tab-content {
            padding: 2rem;
        }

        .login-header {
            text-align: center;
            margin-bottom: 1.75rem;
        }

        .login-icon {
            width: 64px; height: 64px;
            background: linear-gradient(135deg, var(--primary), #2a5298);
            border-radius: 16px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.8rem;
            margin: 0 auto 1rem;
        }

        .login-header h2 {
            font-size: 1.5rem;
            color: var(--primary);
            margin-bottom: .3rem;
        }

        .login-header p { color: var(--gray); font-size: .85rem; }

        .form-group { margin-bottom: 1.25rem; }

        label {
            display: block;
            font-size: .78rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: .07em;
            color: #4a5568;
            margin-bottom: .45rem;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            padding: .75rem 1rem;
            border: 2px solid var(--border);
            border-radius: 10px;
            font-family: inherit;
            font-size: .9rem;
            color: var(--primary);
            transition: border-color .2s, box-shadow .2s;
            outline: none;
            background: white;
        }

        input:focus, select:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 4px rgba(0,151,167,.12);
        }

        .btn-submit {
            width: 100%;
            padding: .85rem;
            background: linear-gradient(135deg, var(--primary), #2a5298);
            color: white;
            border: none;
            border-radius: 10px;
            font-family: inherit;
            font-size: .95rem;
            font-weight: 600;
            cursor: pointer;
            margin-top: .5rem;
            transition: transform .18s, box-shadow .2s;
            letter-spacing: .02em;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(26,58,92,.35);
        }

        .alert-error {
            background: #fff5f5;
            border: 1px solid #feb2b2;
            color: var(--error);
            padding: .75rem 1rem;
            border-radius: 10px;
            font-size: .85rem;
            margin-bottom: 1.25rem;
            display: flex; align-items: center; gap: .5rem;
        }

        .credentials-hint {
            margin-top: 1.5rem;
            padding: 1rem;
            background: var(--light);
            border-radius: 10px;
            border-left: 3px solid var(--accent);
            font-size: .8rem;
            color: var(--gray);
            line-height: 1.7;
        }

        .credentials-hint strong { color: var(--primary); display: block; margin-bottom: .25rem; }

        /* PIE DE PÁGINA */
        footer {
            text-align: center;
            padding: 1rem;
            color: rgba(255,255,255,.5);
            font-size: .78rem;
        }

        /* RESPONSIVO */
        @media (max-width: 480px) {
            .login-card { border-radius: 14px; }
            .tab-content { padding: 1.5rem; }
        }
    </style>
</head>
<body>

<!-- ENCABEZADO -->
<header>
    <a href="index.jsp" class="header-logo" title="Volver al inicio — SGA Web">
        <span>🎓</span> SGA Web
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

            <div class="login-header">
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

                <!-- Botón de acceso (validación simulada) -->
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

        <!-- ===== TAB 2: REGISTRO (creación de cuenta) ===== -->
        <div class="tab-content" id="tab-registro"
             style="display:<%= "registro".equals(activeTab) ? "block" : "none" %>">

            <div class="login-header">
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
                        class="btn-submit"
                        style="background:linear-gradient(135deg,#0097a7,#00796b);"
                        title="Registrar cuenta y acceder al sistema">
                    Crear mi cuenta →
                </button>
            </form>
        </div>

    </div>
</div>

<!-- PIE DE PÁGINA -->
<footer>
    © 2026 SGA Web — Universidad de San Buenaventura, Bogotá
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
