<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
    <title>Inicio</title>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //Borrar directivas de memoria cache y anular algoritmos predeterminados para almacenar cache
        response.setHeader("Pragma", "no-cache");//Directivas compatibles con memorias cache
        response.setDateHeader("Expires", 0);//Proporciona fecha y hora para decir el tiempo de respuesta caduco
    %>
</head>
<body>
    <div class="page-shell">
        <section class="hero">
            <div class="hero-copy">
                <span class="eyebrow">CampusZen</span>
                <h1>Bienvenido</h1>
                <p>Selecciona una opción del menú para navegar por tus horarios, tareas, actividades y notificaciones desde un panel claro y relajado.</p>
            </div>
            <div class="hero-illustration"></div>
        </section>
    </div>
</body>
</html>
