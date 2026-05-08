<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CampusZen | Dashboard</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
</head>
<body>
    <div class="page-shell">
        <header class="hero">
            <div class="hero-copy">
                <span class="eyebrow">Zen Educativo</span>
                <h1>Bienvenido a CampusZen</h1>
                <p>Tu espacio para organizar tareas, actividades, horarios y notificaciones con una experiencia clara, serena y con base en verde.</p>
                <div class="hero-actions">
                    <a class="btn btn-primary" href="login.jsp">Iniciar sesión</a>
                    <a class="btn btn-secondary" href="Register.jsp">Registrarse</a>
                </div>
            </div>
            <div class="hero-illustration"></div>
        </header>

        <section class="dashboard-grid">
            <div class="feature-card">
                <h3>Organiza tus horarios</h3>
                <p>Consulta tu calendario, revisa tus clases y planifica cada semana con claridad.</p>
            </div>
            <div class="feature-card">
                <h3>Administra tus tareas</h3>
                <p>Analisa tus tareas, controla fechas límite y mantén tus entregas bajo control.</p>
            </div>
            <div class="feature-card">
                <h3>Gestiona actividades</h3>
                <p>Revisa actividades académicas, consulta plazos y mantente al día con los compromisos del curso.</p>
            </div>
            <div class="feature-card">
                <h3>Recibe notificaciones</h3>
                <p>Visualiza avisos importantes, marca notificaciones como leídas y no pierdas información clave.</p>
            </div>
        </section>

        <section class="info-section">
            <h2 class="section-title">Cómo funciona CampusZen</h2>
            <ol>
                <li>Entra con tu usuario y contraseña desde el botón de login.</li>
                <li>Una vez dentro, accede al menú para ver tus horarios, tareas y actividades.</li>
                <li>Mantén tus notificaciones en orden y marca como leídas los avisos importantes.</li>
                <li>Usa el flujo natural del proyecto para gestionar todo en un solo lugar.</li>
            </ol>
        </section>

        <footer class="footer">
            <p>CampusZen — un dashboard tranquilo para tu vida académica.</p>
        </footer>
    </div>
</body>
</html>