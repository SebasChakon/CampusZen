<%@page import="modelo.Asignatura, modelo.AsignaturaDAO, java.util.List"%>
<%@page import="config.Conexion, java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    AsignaturaDAO dao = new AsignaturaDAO();
    List<Asignatura> lista = dao.listar();

    // Cargar profesores para el combo de asignar
    List<int[]> profesores = new java.util.ArrayList<>();
    List<String[]> nombresProfesores = new java.util.ArrayList<>();
    try {
        Conexion cn = new Conexion();
        Connection con = cn.crearConexion();
        PreparedStatement ps = con.prepareStatement(
            "SELECT p.id_profesor, u.nombre, u.apellido FROM Profesor p " +
            "JOIN Usuario u ON p.identificacion = u.identificacion " +
            "WHERE p.id_estado = 1 ORDER BY u.nombre");
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            nombresProfesores.add(new String[]{
                String.valueOf(rs.getInt("id_profesor")),
                rs.getString("nombre") + " " + rs.getString("apellido")
            });
        }
        con.close();
    } catch (Exception e) { e.printStackTrace(); }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"><title>Gestión de Asignaturas</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>Gestión de Asignaturas</h2>

    <!-- Agregar asignatura -->
    <fieldset>
        <legend><b>Nueva Asignatura</b></legend>
        <form method="post" action="CtrolAsignatura">
            <input type="hidden" name="accion" value="agregar"/>
            <table border="1">
                <tr><td>Nombre:</td><td><input type="text" name="cnombre" required/></td></tr>
                <tr><td>Descripción:</td><td><input type="text" name="cdescripcion"/></td></tr>
                <tr><td>Créditos:</td><td><input type="number" name="ccreditos" value="3" min="1" max="10"/></td></tr>
                <tr><td colspan="2"><input type="submit" value="Agregar"/></td></tr>
            </table>
        </form>
    </fieldset>
    <br/>

    <!-- Listado -->
    <table border="1">
        <tr>
            <th>ID</th><th>Nombre</th><th>Descripción</th><th>Créditos</th><th>ID Profesor</th><th>Acciones</th>
        </tr>
        <% for (Asignatura a : lista) { %>
        <tr>
            <td><%=a.getId_asignatura()%></td>
            <td><%=a.getNombre()%></td>
            <td><%=a.getDescripcion()%></td>
            <td><%=a.getCreditos()%></td>
            <td><%=a.getId_profesor() > 0 ? a.getId_profesor() : "Sin asignar"%></td>
            <td>
                <a href="EditarAsignatura.jsp?id=<%=a.getId_asignatura()%>" target="marco">Editar</a>
                &nbsp;|&nbsp;
                <!-- Asignar / Reasignar Profesor inline -->
                <form method="post" action="CtrolAsignatura" style="display:inline">
                    <input type="hidden" name="accion" value="asignarProfesor"/>
                    <input type="hidden" name="cid_asignatura" value="<%=a.getId_asignatura()%>"/>
                    <select name="cid_profesor">
                        <option value="0">-- Sin profesor --</option>
                        <% for (String[] p : nombresProfesores) { %>
                        <option value="<%=p[0]%>"
                            <%=p[0].equals(String.valueOf(a.getId_profesor()))?"selected":""%>>
                            <%=p[1]%>
                        </option>
                        <% } %>
                    </select>
                    <input type="submit" value="Asignar"/>
                </form>
                &nbsp;|&nbsp;
                <a href="CtrolAsignatura?accion=eliminar&id=<%=a.getId_asignatura()%>"
                   onclick="return confirm('¿Deshabilitar asignatura?')">Eliminar</a>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
