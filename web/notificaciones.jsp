<%@page import="modelo.Tarea, modelo.TareaDAO, modelo.Notificacion, modelo.NotificacionDAO"%>
<%@page import="config.Conexion, java.sql.*, java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nUsuario = (String) session.getAttribute("nUsuario");
    if (nUsuario == null) { response.sendRedirect("login.jsp"); return; }

    int idUsuario = 0;
    try {
        Conexion cn = new Conexion();
        Connection con = cn.crearConexion();
        PreparedStatement ps = con.prepareStatement(
            "SELECT identificacion FROM Usuario WHERE usuario = ?");
        ps.setString(1, nUsuario);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) idUsuario = rs.getInt("identificacion");
        con.close();
    } catch (Exception e) { e.printStackTrace(); }

    TareaDAO tareaDAO           = new TareaDAO();
    NotificacionDAO notiDAO     = new NotificacionDAO();

    List<Tarea>        pendientes    = tareaDAO.listarPendientesPorUsuario(idUsuario);
    List<Notificacion> notificaciones = notiDAO.listarPorUsuario(idUsuario);
    int noLeidas = notiDAO.contarNoLeidas(idUsuario);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
    <title>Notificaciones y Tareas Pendientes</title>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //Borrar directivas de memoria cache y anular algoritmos predeterminados para almacenar cache
        response.setHeader("Pragma", "no-cache");//Directivas compatibles con memorias cache
        response.setDateHeader("Expires", 0);//Proporciona fecha y hora para decir el tiempo de respuesta caduco
    %>
    <style>
        body { font-family: Arial, sans-serif; padding: 16px; }
        h2, h3 { color: #2c3e50; }
        .badge { background: #e74c3c; color: #fff; border-radius: 50%;
                 padding: 2px 7px; font-size: 12px; margin-left: 6px; }
        .noti-card { border: 1px solid #ddd; border-radius: 6px; padding: 10px 14px;
                     margin: 8px 0; position: relative; }
        .noti-card.no-leida { border-left: 4px solid #e74c3c; background: #fff5f5; }
        .noti-card.leida    { border-left: 4px solid #ccc;    background: #fafafa;  }
        .tipo-badge { font-size: 11px; background: #2980b9; color: #fff;
                      border-radius: 4px; padding: 2px 6px; }
        .tarea-row  { padding: 8px; border: 1px solid #ddd; border-radius: 4px;
                      margin: 6px 0; }
        .prioridad-alta   { border-left: 4px solid #e74c3c; }
        .prioridad-media  { border-left: 4px solid #f39c12; }
        .prioridad-baja   { border-left: 4px solid #27ae60; }
        .btn { padding: 5px 12px; background: #2980b9; color: #fff;
               border: none; border-radius: 4px; cursor: pointer; text-decoration: none; font-size: 12px; }
        .btn:hover { background: #1a6fa0; }
        .btn-sm { padding: 3px 8px; font-size: 11px; }
        .seccion { margin-bottom: 28px; }
        .marcar-todas { margin-bottom: 10px; }

        .seccion {
            margin-bottom: 32px;
        }

        .tarea-row,
        .noti-card {
            background: #f8fcf8;
            border-radius: 12px;
            padding: 14px 16px;
            margin-bottom: 12px;
            border: 1px solid #d8e8d8;
        }

        .tarea-row form {
            display: inline-flex !important;
            align-items: center;
            gap: 8px;

            margin-top: 10px;
            padding: 0 !important;
            border: none !important;
            box-shadow: none !important;
            background: transparent !important;
            width: auto !important;
        }

        .tarea-row select {
            width: auto !important;
            min-width: 150px;

            padding: 6px 10px !important;
            font-size: 12px !important;

            border-radius: 8px;
            box-shadow: none !important;
        }

        .btn,
        .btn-sm,
        .tarea-row input[type="submit"] {

            display: inline-flex !important;
            align-items: center;
            justify-content: center;

            width: auto !important;
            min-width: unset !important;

            padding: 6px 12px !important;

            border-radius: 8px !important;

            font-size: 12px !important;
            font-weight: 600;

            text-decoration: none;
            border: none;

            background: #3f8f49 !important;
            color: white !important;

            cursor: pointer;

            box-shadow: none !important;
        }

        .btn:hover,
        .btn-sm:hover,
        .tarea-row input[type="submit"]:hover {
            background: #2f6f38 !important;
            transform: none !important;
        }

        .tarea-row a,
        .noti-card a {
            margin-top: 8px;
        }

        .tarea-row small {
            color: #557;
        }

        .badge {
            vertical-align: middle;
        }
    </style>
</head>
<body>

    <div class="seccion">
        <h2> Tareas Pendientes</h2>
        <% if (pendientes.isEmpty()) { %>
            <p>No tienes tareas pendientes.</p>
        <% } else { %>
            <p>Tienes <b><%=pendientes.size()%></b> tarea(s) pendiente(s):</p>
            <% for (Tarea t : pendientes) { %>
            <div class="tarea-row prioridad-<%=t.getPrioridad()%>">
                <b><%=t.getNombre()%></b>
                &nbsp;<span style="font-size:11px;color:#666;">Prioridad: <b><%=t.getPrioridad()%></b>
                | Estado: <b><%=t.getEstado()%></b>
                | Límite: <b><%=t.getFecha_limite()%></b></span>
                <% if (t.getDescripcion() != null && !t.getDescripcion().isEmpty()) { %>
                    <br/><small><%=t.getDescripcion()%></small>
                <% } %>
                <br/>
                <form method="post" action="CtrolTareas" style="display:inline; margin-top:4px;">
                    <input type="hidden" name="accion" value="cambiarEstado"/>
                    <input type="hidden" name="id" value="<%=t.getId_tarea()%>"/>
                    <label for="estado-<%=t.getId_tarea()%>">Nuevo Estado:</label>
                    <select id="estado-<%=t.getId_tarea()%>" name="estado" style="font-size:11px;">
                        <option value="pendiente"   <%="pendiente".equals(t.getEstado())?"selected":""%>>Pendiente</option>
                        <option value="en progreso" <%="en progreso".equals(t.getEstado())?"selected":""%>>En Progreso</option>
                        <option value="entregada"   <%="entregada".equals(t.getEstado())?"selected":""%>>Entregada</option>
                    </select>
                    <input type="submit" value="Actualizar" class="btn btn-sm"/>
                </form>
                <a href="listaTareas.jsp" target="marco" class="btn btn-sm">Ver detalle</a>
            </div>
            <% } %>
        <% } %>
    </div>

    <div class="seccion">
        <h2>Notificaciones
            <% if (noLeidas > 0) { %>
                <span class="badge"><%=noLeidas%></span>
            <% } %>
        </h2>

        <% if (noLeidas > 0) { %>
        <div class="marcar-todas">
            <a href="CtrolNotificacion?accion=marcarTodas" class="btn">
                Marcar todas como leídas
            </a>
        </div>
        <% } %>

        <% if (notificaciones.isEmpty()) { %>
            <p>No tienes notificaciones.</p>
        <% } else {
               for (Notificacion n : notificaciones) {
                   String cssClass = n.getLeida() == 0 ? "noti-card no-leida" : "noti-card leida";
        %>
        <div class="<%=cssClass%>">
            <span class="tipo-badge"><%=n.getTipo()%></span>
            <% if (n.getLeida() == 0) { %><b>NUEVA</b><% } %>
            <br/>
            <b><%=n.getTitulo()%></b>
            <br/>
            <span style="font-size:13px;"><%=n.getMensaje()%></span>
            <br/>
            <% if (n.getLeida() == 0) { %>
            <a href="CtrolNotificacion?accion=marcarLeida&id=<%=n.getId_notificacion()%>"
               class="btn btn-sm" style="margin-top:6px; display:inline-block;">
                Marcar como leída
            </a>
            <% } %>
            <% if (n.getUrl_referencia() != null && !n.getUrl_referencia().isEmpty()) { %>
            <a href="<%=n.getUrl_referencia()%>" class="btn btn-sm"
               style="margin-top:6px; display:inline-block;" target="marco">
                Ver detalle
            </a>
            <% } %>
        </div>
        <%  }
           } %>
    </div>

</body>
</html>
