<%@page import="modelo.Tarea, modelo.TareaDAO, java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nUsuario = (String) session.getAttribute("nUsuario");
    if (nUsuario == null) { response.sendRedirect("login.jsp"); return; }
    TareaDAO dao = new TareaDAO();
    List<Tarea> lista = dao.listar();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styles.css">
    <title>Gestión de Tareas</title>
</head>
<body>
    <h2>Gestión de Tareas</h2>

    <!-- Formulario agregar -->
    <fieldset>
        <legend><b>Nueva Tarea</b></legend>
        <form method="post" action="CtrolTareas">
            <input type="hidden" name="accion" value="agregar"/>
            <table border="1">
                <tr><td>Nombre:</td><td><input type="text" name="cnombre" required/></td></tr>
                <tr><td>Descripción:</td><td><input type="text" name="cdescripcion"/></td></tr>
                <tr><td>Fecha Límite:</td><td><input type="datetime-local" name="cfecha_limite" required/></td></tr>
                <tr>
                    <td>Prioridad:</td>
                    <td>
                        <select name="cprioridad" required>
                            <option value="alta">Alta</option>
                            <option value="media" selected>Media</option>
                            <option value="baja">Baja</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Estado:</td>
                    <td>
                        <select name="cestado" required>
                            <option value="pendiente" selected>Pendiente</option>
                            <option value="en progreso">En Progreso</option>
                            <option value="entregada">Entregada</option>
                            <option value="revisada">Revisada</option>
                            <option value="cerrada">Cerrada</option>
                        </select>
                    </td>
                </tr>
                <tr><td>ID Actividad:</td><td><input type="number" name="cid_actividad"/></td></tr>
                <tr><td>ID Usuario Asignado:</td><td><input type="number" name="cid_usuario_asignado"/></td></tr>
                <tr><td>Observaciones:</td><td><input type="text" name="cobservaciones"/></td></tr>
                <tr><td colspan="2"><input type="submit" value="Agregar"/></td></tr>
            </table>
        </form>
    </fieldset>
    <br/>

    <!-- Listado -->
    <table border="1">
        <tr>
            <th>ID</th><th>Nombre</th><th>Prioridad</th><th>Estado</th>
            <th>Fecha Límite</th><th>Observaciones</th><th>Acciones</th>
        </tr>
        <% for (Tarea t : lista) { %>
        <tr>
            <td><%=t.getId_tarea()%></td>
            <td><%=t.getNombre()%></td>
            <td><%=t.getPrioridad()%></td>
            <td><%=t.getEstado()%></td>
            <td><%=t.getFecha_limite()%></td>
            <td><%=t.getObservaciones() != null ? t.getObservaciones() : ""%></td>
            <td>
                <a href="EditarTarea.jsp?id=<%=t.getId_tarea()%>" target="marco">Editar</a>
                <a href="CtrolTareas?accion=eliminar&id=<%=t.getId_tarea()%>"
                   onclick="return confirm('¿Deshabilitar tarea?')">Eliminar</a>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
