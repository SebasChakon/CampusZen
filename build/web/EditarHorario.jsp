<%@page import="modelo.Horario, modelo.HorarioDAO"%>
<%@page import="config.Conexion, java.sql.*"%>
<%@page import="java.util.List, java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    HorarioDAO dao = new HorarioDAO();
    Horario h = dao.buscarPorId(id);
    if (h == null) { out.println("Horario no encontrado."); return; }

    List<String[]> docentes    = new ArrayList<>();
    List<String[]> asignaturas = new ArrayList<>();

    try {
        Conexion cn = new Conexion();
        Connection con = cn.crearConexion();

        PreparedStatement psD = con.prepareStatement(
            "SELECT identificacion, nombre, apellido FROM Usuario " +
            "WHERE id_perfil = 2 AND id_estado = 1 ORDER BY nombre");
        ResultSet rsD = psD.executeQuery();
        while (rsD.next())
            docentes.add(new String[]{rsD.getString("identificacion"),
                rsD.getString("nombre") + " " + rsD.getString("apellido")});
        rsD.close(); psD.close();

        PreparedStatement psA = con.prepareStatement(
            "SELECT id_asignatura, nombre FROM Asignatura WHERE id_estado = 1 ORDER BY nombre");
        ResultSet rsA = psA.executeQuery();
        while (rsA.next())
            asignaturas.add(new String[]{rsA.getString("id_asignatura"), rsA.getString("nombre")});
        rsA.close(); psA.close();

        con.close();
    } catch (Exception e) { e.printStackTrace(); }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Horario</title>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //Borrar directivas de memoria cache y anular algoritmos predeterminados para almacenar cache
        response.setHeader("Pragma", "no-cache");//Directivas compatibles con memorias cache
        response.setDateHeader("Expires", 0);//Proporciona fecha y hora para decir el tiempo de respuesta caduco
    %>
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
</head>
<body>
    <h2>Editar Horario</h2>
    <form method="post" action="CtrolHorario">
        <input type="hidden" name="accion" value="editar"/>
        <input type="hidden" name="cid_horario" value="<%=h.getId_horario()%>"/>
        <table border="1">
            <tr>
                <td><label for="cid_asignatura">Asignatura:</label></td>
                <td>
                    <select id="cid_asignatura" name="cid_asignatura" required>
                        <% for (String[] a : asignaturas) { %>
                        <option value="<%=a[0]%>"
                            <%=a[0].equals(String.valueOf(h.getId_asignatura()))?"selected":""%>>
                            <%=a[1]%>
                        </option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="cid_docente">Docente:</label></td>
                <td>
                    <select id="cid_docente" name="cid_docente" required>
                        <% for (String[] d : docentes) { %>
                        <option value="<%=d[0]%>"
                            <%=d[0].equals(String.valueOf(h.getId_profesor()))?"selected":""%>>
                            <%=d[1]%>
                        </option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="cdia_semana">Día:</label></td>
                <td>
                    <select id="cdia_semana" name="cdia_semana">
                        <% String[] dias = {"Lunes","Martes","Miércoles","Jueves","Viernes","Sábado"};
                           for (String dia : dias) { %>
                        <option value="<%=dia%>" <%=dia.equals(h.getDia_semana())?"selected":""%>><%=dia%></option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="chora_inicio">Hora Inicio:</label></td>
                <td><input type="time" id="chora_inicio" name="chora_inicio" value="<%=h.getHora_inicio()%>" required/></td>
            </tr>
            <tr>
                <td><label for="chora_fin">Hora Fin:</label></td>
                <td><input type="time" id="chora_fin" name="chora_fin" value="<%=h.getHora_fin()%>" required/></td>
            </tr>
            <tr>
                <td><label for="csalon">Salón:</label></td>
                <td><input type="text" id="csalon" name="csalon" value="<%=h.getSalon()%>" required/></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Actualizar"/></td>
            </tr>
        </table>
    </form>
</body>
</html>
