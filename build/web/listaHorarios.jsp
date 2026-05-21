<%@page import="modelo.Horario, modelo.HorarioDAO"%>
<%@page import="config.Conexion, java.sql.*"%>
<%@page import="java.util.List, java.util.ArrayList, java.util.Map, java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HorarioDAO dao = new HorarioDAO();
    List<Horario> lista = dao.listar();

    List<String[]> docentes    = new ArrayList<>();
    
    List<String[]> asignaturas = new ArrayList<>();
    
    Map<String,String> mapaDocentes    = new HashMap<>();
    Map<String,String> mapaAsignaturas = new HashMap<>();

    try {
        Conexion cn = new Conexion();
        Connection con = cn.crearConexion();

        PreparedStatement psD = con.prepareStatement(
            "SELECT identificacion, nombre, apellido FROM Usuario " +
            "WHERE id_perfil = 2 AND id_estado = 1 ORDER BY nombre");
        ResultSet rsD = psD.executeQuery();
        while (rsD.next()) {
            String[] row = {rsD.getString("identificacion"),
                rsD.getString("nombre") + " " + rsD.getString("apellido")};
            docentes.add(row);
            mapaDocentes.put(row[0], row[1]);
        }
        rsD.close(); psD.close();

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
    <title>Gestión de Horarios</title>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //Borrar directivas de memoria cache y anular algoritmos predeterminados para almacenar cache
        response.setHeader("Pragma", "no-cache");//Directivas compatibles con memorias cache
        response.setDateHeader("Expires", 0);//Proporciona fecha y hora para decir el tiempo de respuesta caduco
    %>
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
</head>
<body>
    <h2>Gestión de Horarios</h2>

    <fieldset>
        <legend><b>Nuevo Horario</b></legend>
        <form method="post" action="CtrolHorario">
            <input type="hidden" name="accion" value="agregar"/>
            <table border="1">
                <tr>
                    <td><label for="cid_asignatura">Asignatura:</label></td>
                    <td>
                        <select id="cid_asignatura" name="cid_asignatura" required>
                            <option value="">-- Seleccione --</option>
                            <% for (String[] a : asignaturas) { %>
                            <option value="<%=a[0]%>"><%=a[1]%></option>
                            <% } %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="cid_docente">Docente:</label></td>
                    <td>
                        <select id="cid_docente" name="cid_docente" required>
                            <option value="">-- Seleccione --</option>
                            <% for (String[] d : docentes) { %>
                            <option value="<%=d[0]%>"><%=d[1]%></option>
                            <% } %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="cdia_semana">Día:</label></td>
                    <td>
                        <select id="cdia_semana" name="cdia_semana" required>
                            <option value="Lunes">Lunes</option>
                            <option value="Martes">Martes</option>
                            <option value="Miércoles">Miércoles</option>
                            <option value="Jueves">Jueves</option>
                            <option value="Viernes">Viernes</option>
                            <option value="Sábado">Sábado</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="chora_inicio">Hora Inicio:</label></td>
                    <td><input type="time" id="chora_inicio" name="chora_inicio" required/></td>
                </tr>
                <tr>
                    <td><label for="chora_fin">Hora Fin:</label></td>
                    <td><input type="time" id="chora_fin" name="chora_fin" required/></td>
                </tr>
                <tr>
                    <td><label for="csalon">Salón:</label></td>
                    <td><input type="text" id="csalon" name="csalon" required/></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Agregar"/></td>
                </tr>
            </table>
        </form>
    </fieldset>
    <br/>

    <table border="1">
        <tr>
            <th>ID</th><th>Asignatura</th><th>Docente</th>
            <th>Día</th><th>Inicio</th><th>Fin</th><th>Salón</th><th>Acciones</th>
        </tr>
        <% for (Horario h : lista) {
               String nomAsig = mapaAsignaturas.getOrDefault(String.valueOf(h.getId_asignatura()), "—");
               String nomDoc  = mapaDocentes.getOrDefault(String.valueOf(h.getId_profesor()), "—");
        %>
        <tr>
            <td><%=h.getId_horario()%></td>
            <td><%=nomAsig%></td>
            <td><%=nomDoc%></td>
            <td><%=h.getDia_semana()%></td>
            <td><%=h.getHora_inicio()%></td>
            <td><%=h.getHora_fin()%></td>
            <td><%=h.getSalon()%></td>
            <td>
                <a href="EditarHorario.jsp?id=<%=h.getId_horario()%>" target="marco">Editar</a>
                <a href="CtrolHorario?accion=eliminar&id=<%=h.getId_horario()%>"
                   onclick="return confirm('¿Eliminar horario?')">Eliminar</a>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
