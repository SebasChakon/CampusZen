<%@page import="modelo.Tarea, modelo.TareaDAO"%>
<%@page import="config.Conexion, java.sql.*"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nUsuario = (String) session.getAttribute("nUsuario");
    if (nUsuario == null) { response.sendRedirect("login.jsp"); return; }

    TareaDAO dao = new TareaDAO();
    List<Tarea> lista = dao.listar();

    // Cargar actividades (tabla Actividad académica)
    List<String[]> actividades = new java.util.ArrayList<>();
    // Cargar usuarios habilitados
    List<String[]> usuarios = new java.util.ArrayList<>();
    try {
        Conexion cn = new Conexion();
        Connection con = cn.crearConexion();

        PreparedStatement psA = con.prepareStatement(
            "SELECT id_actividad, nombre FROM Actividad WHERE id_estado = 1 ORDER BY nombre");
        ResultSet rsA = psA.executeQuery();
        while (rsA.next())
            actividades.add(new String[]{rsA.getString("id_actividad"), rsA.getString("nombre")});
        rsA.close(); psA.close();

        PreparedStatement psU = con.prepareStatement(
            "SELECT identificacion, nombre, apellido FROM Usuario WHERE id_estado = 1 ORDER BY nombre");
        ResultSet rsU = psU.executeQuery();
        while (rsU.next())
            usuarios.add(new String[]{rsU.getString("identificacion"),
                rsU.getString("nombre") + " " + rsU.getString("apellido")});
        rsU.close(); psU.close();

        con.close();
    } catch (Exception e) { e.printStackTrace(); }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Tareas</title>
</head>
<body>
    <h2>Gestión de Tareas</h2>

    <fieldset>
        <legend><b>Nueva Tarea</b></legend>
        <form method="post" action="CtrolTareas">
            <input type="hidden" name="accion" value="agregar"/>
            <table border="1">
                <tr>
                    <td>Nombre:</td>
                    <td><input type="text" name="cnombre" required/></td>
                </tr>
                <tr>
                    <td>Descripción:</td>
                    <td><input type="text" name="cdescripcion"/></td>
                </tr>
                <tr>
                    <td>Fecha Límite:</td>
                    <td><input type="datetime-local" name="cfecha_limite" required/></td>
                </tr>
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
                <tr>
                    <td>Actividad:</td>
                    <td>
                        <select name="cid_actividad" required>
                            <option value="">-- Seleccione una actividad --</option>
                            <% for (String[] a : actividades) { %>
                            <option value="<%=a[0]%>"><%=a[1]%></option>
                            <% } %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Usuario Asignado:</td>
                    <td>
                        <select name="cid_usuario_asignado" required>
                            <option value="">-- Seleccione un usuario --</option>
                            <% for (String[] u : usuarios) { %>
                            <option value="<%=u[0]%>"><%=u[1]%></option>
                            <% } %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Observaciones:</td>
                    <td><input type="text" name="cobservaciones"/></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Agregar"/></td>
                </tr>
            </table>
        </form>
    </fieldset>
    <br/>

    <%
        // Mapa id_actividad → nombre para mostrar en la tabla
        java.util.Map<String,String> mapaActividades = new java.util.HashMap<>();
        for (String[] a : actividades) mapaActividades.put(a[0], a[1]);
    %>
    <table border="1">
        <tr>
            <th>ID</th><th>Nombre</th><th>Descripción</th><th>Actividad</th>
            <th>Prioridad</th><th>Estado</th><th>Fecha Límite</th>
            <th>Observaciones</th><th>Acciones</th>
        </tr>
        <% for (Tarea t : lista) {
               String nomActividad = mapaActividades.getOrDefault(
                   String.valueOf(t.getId_actividad()), "—");
        %>
        <tr>
            <td><%=t.getId_tarea()%></td>
            <td><%=t.getNombre()%></td>
            <td><%=t.getDescripcion() != null ? t.getDescripcion() : ""%></td>
            <td><%=nomActividad%></td>
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
