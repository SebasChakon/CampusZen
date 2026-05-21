<%@page import="modelo.Tarea, modelo.TareaDAO"%>
<%@page import="config.Conexion, java.sql.*"%>
<%@page import="java.util.List, java.util.Map, java.util.HashMap, java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nUsuario = (String) session.getAttribute("nUsuario");
    if (nUsuario == null) { response.sendRedirect("login.jsp"); return; }

    int    idPerfil       = (Integer) session.getAttribute("idPerfil");
    String identificacion = (String)  session.getAttribute("identificacion");

    boolean puedeGestionar = (idPerfil == 1 || idPerfil == 2);
    boolean esEstudiante   = (idPerfil == 3);

    TareaDAO dao = new TareaDAO();
    List<Tarea> lista;
    if (puedeGestionar) {
        lista = dao.listar();
    } else {
        lista = dao.listarPorUsuario(Integer.parseInt(identificacion));
    }

    List<String[]> actividades = new ArrayList<>();
    List<String[]> estudiantes = new ArrayList<>();
    Map<String,String> mapaActividades = new HashMap<>();
    Map<String,String> mapaUsuarios    = new HashMap<>();

    try {
        Conexion cn = new Conexion();
        Connection con = cn.crearConexion();

        PreparedStatement psA = con.prepareStatement(
            "SELECT id_actividad, nombre FROM Actividad WHERE id_estado = 1 ORDER BY nombre");
        ResultSet rsA = psA.executeQuery();
        while (rsA.next()) {
            String[] row = {rsA.getString("id_actividad"), rsA.getString("nombre")};
            actividades.add(row);
            mapaActividades.put(row[0], row[1]);
        }
        rsA.close(); psA.close();

        PreparedStatement psE = con.prepareStatement(
            "SELECT identificacion, nombre, apellido FROM Usuario " +
            "WHERE id_estado = 1 AND id_perfil = 3 ORDER BY nombre");
        ResultSet rsE = psE.executeQuery();
        while (rsE.next())
            estudiantes.add(new String[]{rsE.getString("identificacion"),
                rsE.getString("nombre") + " " + rsE.getString("apellido")});
        rsE.close(); psE.close();

        PreparedStatement psU = con.prepareStatement(
            "SELECT identificacion, nombre, apellido FROM Usuario WHERE id_estado = 1");
        ResultSet rsU = psU.executeQuery();
        while (rsU.next())
            mapaUsuarios.put(rsU.getString("identificacion"),
                rsU.getString("nombre") + " " + rsU.getString("apellido"));
        rsU.close(); psU.close();

        con.close();
    } catch (Exception e) { e.printStackTrace(); }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Tareas</title>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //Borrar directivas de memoria cache y anular algoritmos predeterminados para almacenar cache
        response.setHeader("Pragma", "no-cache");//Directivas compatibles con memorias cache
        response.setDateHeader("Expires", 0);//Proporciona fecha y hora para decir el tiempo de respuesta caduco
    %>
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
</head>
<body>
    <h2>Gestión de Tareas</h2>

    <% if (puedeGestionar) { %>
    <fieldset>
        <legend><b>Nueva Tarea</b></legend>
        <form method="post" action="CtrolTareas">
            <input type="hidden" name="accion" value="agregar"/>
            <table border="1">
                <tr>
                    <td><label for="cnombre">Nombre:</label></td>
                    <td><input type="text" id="cnombre" name="cnombre" required/></td>
                </tr>
                <tr>
                    <td><label for="cdescripcion">Descripción:</label></td>
                    <td><input type="text" id="cdescripcion" name="cdescripcion"/></td>
                </tr>
                <tr>
                    <td><label for="cfecha_limite">Fecha Límite:</label></td>
                    <td><input type="datetime-local" id="cfecha_limite" name="cfecha_limite" required/></td>
                </tr>
                <tr>
                    <td><label for="cprioridad">Prioridad:</label></td>
                    <td>
                        <select id="cprioridad" name="cprioridad" required>
                            <option value="alta">Alta</option>
                            <option value="media" selected>Media</option>
                            <option value="baja">Baja</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="cestado">Estado:</label></td>
                    <td>
                        <select id="cestado" name="cestado" required>
                            <option value="pendiente" selected>Pendiente</option>
                            <option value="en progreso">En Progreso</option>
                            <option value="entregada">Entregada</option>
                            <option value="revisada">Revisada</option>
                            <option value="cerrada">Cerrada</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="cid_actividad">Actividad:</label></td>
                    <td>
                        <select id="cid_actividad" name="cid_actividad" required>
                            <option value="">-- Seleccione una actividad --</option>
                            <% for (String[] a : actividades) { %>
                            <option value="<%=a[0]%>"><%=a[1]%></option>
                            <% } %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="cid_usuario_asignado">Estudiante Asignado:</label></td>
                    <td>
                        <select id="cid_usuario_asignado" name="cid_usuario_asignado" required>
                            <option value="">-- Seleccione un estudiante --</option>
                            <% for (String[] e : estudiantes) { %>
                            <option value="<%=e[0]%>"><%=e[1]%></option>
                            <% } %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="cobservaciones">Observaciones:</label></td>
                    <td><input type="text" id="cobservaciones" name="cobservaciones"/></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Agregar"/></td>
                </tr>
            </table>
        </form>
    </fieldset>
    <br/>
    <% } %>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Actividad</th>
            <%-- Punto 1: columna usuario solo para admin y docente --%>
            <% if (puedeGestionar) { %><th>Usuario Asignado</th><% } %>
            <th>Prioridad</th>
            <th>Estado</th>
            <th>Fecha Límite</th>
            <th>Observaciones</th>
            <% if (puedeGestionar) { %><th>Acciones</th><% } %>
        </tr>
        <% for (Tarea t : lista) {
               String nomActividad = mapaActividades.getOrDefault(String.valueOf(t.getId_actividad()), "—");
               String nomUsuario   = mapaUsuarios.getOrDefault(String.valueOf(t.getId_usuario_asignado()), "—");
        %>
        <tr>
            <td><%=t.getId_tarea()%></td>
            <td><%=t.getNombre()%></td>
            <td><%=t.getDescripcion() != null ? t.getDescripcion() : ""%></td>
            <td><%=nomActividad%></td>
            <% if (puedeGestionar) { %>
            <td><%=nomUsuario%></td>
            <% } %>
            <td><%=t.getPrioridad()%></td>
            <td><%=t.getEstado()%></td>
            <td><%=t.getFecha_limite()%></td>
            <td><%=t.getObservaciones() != null ? t.getObservaciones() : ""%></td>
            <% if (puedeGestionar) { %>
            <td>
                <a href="EditarTarea.jsp?id=<%=t.getId_tarea()%>" target="marco">Editar</a>
                <a href="CtrolTareas?accion=eliminar&id=<%=t.getId_tarea()%>"
                   onclick="return confirm('¿Deshabilitar tarea?')">Eliminar</a>
            </td>
            <% } %>
        </tr>
        <% } %>
    </table>
</body>
</html>
