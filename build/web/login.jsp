<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampusZen | Iniciar sesión</title>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //Borrar directivas de memoria cache y anular algoritmos predeterminados para almacenar cache
        response.setHeader("Pragma", "no-cache");//Directivas compatibles con memorias cache
        response.setDateHeader("Expires", 0);//Proporciona fecha y hora para decir el tiempo de respuesta caduco
    %>
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
</head>
<body>
    <div class="page-shell">
        <div class="page-header center">
            <span class="eyebrow">Acceso seguro</span>
            <h1>Iniciar sesión en CampusZen</h1>
            <p class="subtitle">Ingresa tus credenciales para continuar con tu calendario, tareas y notificaciones.</p>
        </div>

        <div class="container login-card">
            <form method="post" action="CtrolValidar">
                <div class="form-row">
                    <label for="cusuario">Usuario</label>
                    <input type="text" name="cusuario" id="cusuario" required autofocus>
                </div>
                <div class="form-row">
                    <label for="cclave">Contraseña</label>
                    <input type="password" name="cclave" id="cclave" required>
                </div>
                <div class="form-actions">
                    <input type="submit" name="accion" value="Ingresar" class="btn btn-primary">
                    <a class="btn btn-secondary" href="index.jsp">Volver al dashboard</a>
                </div>
            </form>
            <p style="margin-top: 18px; color: #4b6f52;">¿Aún no tienes cuenta? <a href="Register.jsp">Regístrate aquí</a>.</p>
        </div>
    </div>
</body>
</html>