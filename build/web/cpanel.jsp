<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="config.Conexion" %>
<%
    HttpSession sesion_cli = request.getSession(true);
    String nUsuario = (String) sesion_cli.getAttribute("nUsuario");
    Connection con = null;
    Statement  sentencia = null;
    ResultSet  resultado = null;
    String nombre   = null;
    String apellido = null;
    String usu      = null;
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>CampusZen</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
    <style>
        .topbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 20px 28px;
        }

        .topbar > div:first-child {
            display: flex;
            align-items: center;
            gap: 18px;
        }

        .topbar .hero-illustration {
            width: 90px;
            height: 90px;
            min-height: 90px;

            margin: 0;

            border-radius: 20px;

            flex-shrink: 0;
        }

        .topbar .hero-illustration::before {
            background-size: 55px;
            opacity: 0.15;
        }

        .topbar .hero-illustration::after {
            font-size: 2rem;
            letter-spacing: 0.12em;
        }

        .topbar h1 {
            margin: 0;
            font-size: 2rem;
            line-height: 1.1;
        }

        .topbar .eyebrow {
            margin-bottom: 8px;
        }

        .topbar .header-text {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .topbar .hero-illustration::after {
            content: none;
        }
    </style>
</head>
<body>
<%
    try {
        Conexion cn = new Conexion();
        con = cn.crearConexion();
        sentencia = con.createStatement();
        resultado = sentencia.executeQuery(
            "SELECT * FROM Usuario WHERE usuario = '" + nUsuario + "' AND id_estado = 1"
        );
        while (resultado.next()) {
            nombre   = resultado.getString("nombre");
            apellido = resultado.getString("apellido");
            usu      = resultado.getString("usuario");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    con.close();
%>

    <div class="page-shell cpanel-shell">
        <header class="topbar">

            <div>
                <div class="hero-illustration"></div>

                <div class="header-text">
                    <span class="eyebrow">CampusZen</span>
                    <h1>Hola, <%=nombre%> <%=apellido%></h1>
                </div>
            </div>

            <div class="topbar-actions">
                <a class="btn btn-secondary" href="CerrarSesion">
                    Cerrar sesión
                </a>
            </div>

        </header>

        <div class="dashboard-layout cpanel-layout">
            <aside class="sidebar">
                <div class="container">
                    <h3>Menú</h3>
                    <ul class="menu-list">
<%
    if (usu != null && usu.equals(nUsuario)) {
        Conexion cn1 = new Conexion();
        con = cn1.crearConexion();
        sentencia = con.createStatement();

        resultado = sentencia.executeQuery(
            "SELECT a.nom_actividad AS actividad, " +
            "       a.enlace        AS enlace " +
            "FROM actividades a " +
            "JOIN GesActividad g ON a.id_actividad = g.id_actividad " +
            "JOIN Usuario u      ON g.id_perfil    = u.id_perfil " +
            "WHERE u.usuario     = '" + nUsuario + "' " +
            "  AND a.id_estado   = 1 " +
            "  AND g.id_estado   = 1"
        );
        while (resultado.next()) {
%>
                        <li>
                            <a href="<%=resultado.getString("enlace")%>" target="marco">
                                <%=resultado.getString("actividad")%>
                            </a>
                        </li>
<%
        }
        con.close();
    }
%>
                    </ul>
                </div>
            </aside>

            <main class="content-panel">
                <div class="container">
                    <iframe name="marco" src="front.jsp" frameborder="0"></iframe>
                </div>
            </main>
        </div>
    </div>
</body>
</html>
