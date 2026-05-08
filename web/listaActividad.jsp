<%@page import="modelo.Actividad, modelo.ActividadDAO"%>
<%@page import="config.Conexion, java.sql.*"%>
<%@page import="java.util.List, java.util.Map, java.util.HashMap, java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nUsuario = (String) session.getAttribute("nUsuario");
    if (nUsuario == null) { response.sendRedirect("login.jsp"); return; }

    int    idPerfil       = (Integer) session.getAttribute("idPerfil");
    String identificacion = (String)  session.getAttribute("identificacion");

    boolean puedeGestionar = (idPerfil == 1 || idPerfil == 2);

    ActividadDAO dao = new ActividadDAO();
    List<Actividad> lista = dao.listar();

    List<String[]> asignaturas = new ArrayList<>();
    Map<String,String> mapaAsignaturas = new HashMap<>();

    try {
        Conexion cn = new Conexion();
        Connection con = cn.crearConexion();

        PreparedStatement psA = con.prepareStatement(
            "SELECT id_asignatura, nombre FROM Asignatura WHERE id_estado = 1 ORDER BY nombre");
        ResultSet rsA = psA.executeQuery();
        while (rsA.next()) {
            String[] row = {rsA.getString("id_asignatura"), rsA.getString("nombre")};
            asignaturas.add(row);
            mapaAsignaturas.put(row[0], row[1]);
        }
        rsA.close(); psA.close();

        con.close();
    } catch (Exception e) { e.printStackTrace(); }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
    <title>Gestión de Actividades Académicas</title>
</head>
<body>
    <h2>Gestión de Actividades Académicas</h2>

    <% if (puedeGestionar) { %>
    <fieldset>
        <legend><b>Nueva Actividad</b></legend>
        <form method="post" action="CtrolActividad">
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
                    <td><label for="cid_asignatura">Asignatura:</label></td>
                    <td>
                        <select id="cid_asignatura" name="cid_asignatura" required>
                            <option value="">-- Seleccione una asignatura --</option>
                            <% for (String[] as : asignaturas) { %>
                            <option value="<%=as[0]%>"><%=as[1]%></option>
                            <% } %>
                        </select>
                    </td>
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
            <th>Asignatura</th>
            <th>Fecha Límite</th>
            <% if (puedeGestionar) { %><th>Acciones</th><% } %>
        </tr>
        <% for (Actividad act : lista) {
               String nomAsignatura = mapaAsignaturas.getOrDefault(String.valueOf(act.getId_asignatura()), "—");
        %>
        <tr>
            <td><%=act.getId_actividad()%></td>
            <td><%=act.getNombre()%></td>
            <td><%=act.getDescripcion() != null ? act.getDescripcion() : ""%></td>
            <td><%=nomAsignatura%></td>
            <td><%=act.getFecha_limite()%></td>
            <% if (puedeGestionar) { %>
            <td>
                <a href="EditarActividad_Academica.jsp?id=<%=act.getId_actividad()%>" target="marco">Editar</a>
                <a href="CtrolActividad?accion=eliminar&id=<%=act.getId_actividad()%>"
                   onclick="return confirm('¿Deshabilitar actividad?')">Eliminar</a>
            </td>
            <% } %>
        </tr>
        <% } %>
    </table>
</body>
</html>