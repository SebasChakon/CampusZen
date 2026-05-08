<%@page import="modelo.Asignatura, modelo.AsignaturaDAO"%>
<%@page import="config.Conexion, java.sql.*"%>
<%@page import="java.util.List, java.util.ArrayList, java.util.Map, java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    AsignaturaDAO dao = new AsignaturaDAO();
    List<Asignatura> lista = dao.listar();

    List<String[]> docentes    = new ArrayList<>();
    Map<String,String> mapaDoc = new HashMap<>();

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
            mapaDoc.put(row[0], row[1]);
        }
        rsD.close(); psD.close();
        con.close();
    } catch (Exception e) { e.printStackTrace(); }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Asignaturas</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
    <style>
        /* Neutralizar estilos del CSS global para formularios dentro de celdas */
        .form-inline {
            display: inline-flex !important;
            align-items: center;
            gap: 6px;
            flex-wrap: nowrap;
            margin: 0 !important;
            padding: 0 !important;
            border: none !important;
            box-shadow: none !important;
            background: transparent !important;
            border-radius: 0 !important;
            width: auto !important;
        }
        .form-inline table { display: none; }
        .form-inline select {
            width: auto !important;
            padding: 5px 8px !important;
            font-size: 0.82rem !important;
            border-radius: 8px !important;
            margin: 0 !important;
        }
        .form-inline input[type="submit"] {
            padding: 5px 12px !important;
            font-size: 0.82rem !important;
            border-radius: 999px !important;
            margin: 0 !important;
            white-space: nowrap;
        }
        .acciones-cell {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
            white-space: nowrap;
        }
        .sep { color: #aaa; }
    </style>
</head>
<body>
    <h2>Gestión de Asignaturas</h2>

    <fieldset>
        <legend><b>Nueva Asignatura</b></legend>
        <form method="post" action="CtrolAsignatura">
            <input type="hidden" name="accion" value="agregar"/>
            <table>
                <tr>
                    <td>Nombre:</td>
                    <td><input type="text" name="cnombre" required/></td>
                </tr>
                <tr>
                    <td>Descripción:</td>
                    <td><input type="text" name="cdescripcion"/></td>
                </tr>
                <tr>
                    <td>Créditos:</td>
                    <td><input type="number" name="ccreditos" value="3" min="1" max="10"/></td>
                </tr>
                <tr>
                    <td colspan="2"><input type="submit" value="Agregar"/></td>
                </tr>
            </table>
        </form>
    </fieldset>
    <br/>

    <table>
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Créditos</th>
            <th>Docente</th>
            <th>Acciones</th>
        </tr>
        <% for (Asignatura a : lista) {
               String nomDoc = mapaDoc.getOrDefault(String.valueOf(a.getId_profesor()), "Sin asignar");
        %>
        <tr>
            <td><%=a.getId_asignatura()%></td>
            <td><%=a.getNombre()%></td>
            <td><%=a.getDescripcion()%></td>
            <td><%=a.getCreditos()%></td>
            <td><%=nomDoc%></td>
            <td>
                <div class="acciones-cell">
                    <a href="EditarAsignatura.jsp?id=<%=a.getId_asignatura()%>" target="marco">Editar</a>
                    <span class="sep">|</span>
                    <%-- Asignar docente inline --%>
                    <form method="post" action="CtrolAsignatura" class="form-inline">
                        <input type="hidden" name="accion" value="asignarProfesor"/>
                        <input type="hidden" name="cid_asignatura" value="<%=a.getId_asignatura()%>"/>
                        <select name="cid_profesor">
                            <option value="0">-- Sin docente --</option>
                            <% for (String[] d : docentes) { %>
                            <option value="<%=d[0]%>"
                                <%=d[0].equals(String.valueOf(a.getId_profesor()))?"selected":""%>>
                                <%=d[1]%>
                            </option>
                            <% } %>
                        </select>
                        <input type="submit" value="Asignar"/>
                    </form>
                    <span class="sep">|</span>
                    <a href="CtrolAsignatura?accion=eliminar&id=<%=a.getId_asignatura()%>"
                       onclick="return confirm('¿Deshabilitar asignatura?')">Eliminar</a>
                </div>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
