<%@page import="modelo.Actividad, modelo.ActividadDAO"%>
<%@page import="config.Conexion, java.sql.*"%>
<%@page import="java.util.List, java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ActividadDAO dao = new ActividadDAO();
    Actividad act = dao.buscarPorId(id);

    List<String[]> asignaturas = new ArrayList<>();

    try {
        Conexion cn = new Conexion();
        Connection con = cn.crearConexion();

        PreparedStatement psA = con.prepareStatement(
            "SELECT id_asignatura, nombre FROM Asignatura WHERE id_estado = 1 ORDER BY nombre");
        ResultSet rsA = psA.executeQuery();
        while (rsA.next()) {
            String[] row = {rsA.getString("id_asignatura"), rsA.getString("nombre")};
            asignaturas.add(row);
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
    <title>Editar Actividad</title>
</head>
<body>
    <h2>Editar Actividad</h2>
    <form method="post" action="CtrolActividad">
        <input type="hidden" name="accion" value="editar"/>
        <input type="hidden" name="cid_actividad" value="<%=act.getId_actividad()%>"/>
        <table border="1">
            <tr>
                <td>Nombre:</td>
                <td><input type="text" name="cnombre" value="<%=act.getNombre()%>" required/></td>
            </tr>
            <tr>
                <td>DescripciÃ³n:</td>
                <td><input type="text" name="cdescripcion" value="<%=act.getDescripcion() != null ? act.getDescripcion() : ""%>"/></td>
            </tr>
            <tr>
                <td>Fecha LÃ­mite:</td>
                <td><input type="datetime-local" name="cfecha_limite" value="<%=act.getFecha_limite()%>" required/></td>
            </tr>
            <tr>
                <td>Asignatura:</td>
                <td>
                    <select name="cid_asignatura" required>
                        <% for (String[] as : asignaturas) { %>
                        <option value="<%=as[0]%>" <%= as[0].equals(String.valueOf(act.getId_asignatura())) ? "selected" : "" %>>
                            <%=as[1]%>
                        </option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Actualizar"/></td>
            </tr>
        </table>
    </form>
</body>
</html>