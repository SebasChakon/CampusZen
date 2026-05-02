<%@page import="modelo.Horario, modelo.HorarioDAO, modelo.Asignatura, modelo.AsignaturaDAO, java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HorarioDAO dao = new HorarioDAO();
    AsignaturaDAO adao = new AsignaturaDAO();
    List<Horario> lista = dao.listar();
    List<Asignatura> asignaturas = adao.listar();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"><title>Gestión de Horarios</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h2>Gestión de Horarios</h2>

    <fieldset>
        <legend><b>Nuevo Horario</b></legend>
        <form method="post" action="CtrolHorario">
            <input type="hidden" name="accion" value="agregar"/>
            <table border="1">
                <tr>
                    <td>Asignatura:</td>
                    <td>
                        <select name="cid_asignatura" required>
                            <option value="">-- Seleccione --</option>
                            <% for (Asignatura a : asignaturas) { %>
                            <option value="<%=a.getId_asignatura()%>"><%=a.getNombre()%></option>
                            <% } %>
                        </select>
                    </td>
                </tr>
                <tr><td>ID Profesor:</td><td><input type="number" name="cid_profesor" required/></td></tr>
                <tr>
                    <td>Día:</td>
                    <td>
                        <select name="cdia_semana" required>
                            <option value="Lunes">Lunes</option>
                            <option value="Martes">Martes</option>
                            <option value="Miércoles">Miércoles</option>
                            <option value="Jueves">Jueves</option>
                            <option value="Viernes">Viernes</option>
                            <option value="Sábado">Sábado</option>
                        </select>
                    </td>
                </tr>
                <tr><td>Hora Inicio:</td><td><input type="time" name="chora_inicio" required/></td></tr>
                <tr><td>Hora Fin:</td><td><input type="time" name="chora_fin" required/></td></tr>
                <tr><td>Salón:</td><td><input type="text" name="csalon" required/></td></tr>
                <tr><td colspan="2"><input type="submit" value="Agregar"/></td></tr>
            </table>
        </form>
    </fieldset>
    <br/>

    <table border="1">
        <tr>
            <th>ID</th><th>Asignatura ID</th><th>Profesor ID</th>
            <th>Día</th><th>Inicio</th><th>Fin</th><th>Salón</th><th>Acciones</th>
        </tr>
        <% for (Horario h : lista) { %>
        <tr>
            <td><%=h.getId_horario()%></td>
            <td><%=h.getId_asignatura()%></td>
            <td><%=h.getId_profesor()%></td>
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
