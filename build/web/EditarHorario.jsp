<%@page import="modelo.Horario, modelo.HorarioDAO, modelo.Asignatura, modelo.AsignaturaDAO, java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    HorarioDAO dao = new HorarioDAO();
    Horario h = dao.buscarPorId(id);
    if (h == null) { out.println("Horario no encontrado."); return; }
    AsignaturaDAO adao = new AsignaturaDAO();
    List<Asignatura> asignaturas = adao.listar();
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Editar Horario</title></head>
<link rel="stylesheet" href="styles.css">
<body>
    <h2>Editar Horario</h2>
    <form method="post" action="CtrolHorario">
        <input type="hidden" name="accion" value="editar"/>
        <input type="hidden" name="cid_horario" value="<%=h.getId_horario()%>"/>
        <table border="1">
            <tr>
                <td>Asignatura:</td>
                <td>
                    <select name="cid_asignatura" required>
                        <% for (Asignatura a : asignaturas) { %>
                        <option value="<%=a.getId_asignatura()%>"
                            <%=a.getId_asignatura()==h.getId_asignatura()?"selected":""%>>
                            <%=a.getNombre()%>
                        </option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr><td>ID Profesor:</td><td><input type="number" name="cid_profesor" value="<%=h.getId_profesor()%>" required/></td></tr>
            <tr>
                <td>Día:</td>
                <td>
                    <select name="cdia_semana">
                        <% String[] dias = {"Lunes","Martes","Miércoles","Jueves","Viernes","Sábado"};
                           for (String d : dias) { %>
                        <option value="<%=d%>" <%=d.equals(h.getDia_semana())?"selected":""%>><%=d%></option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr><td>Hora Inicio:</td><td><input type="time" name="chora_inicio" value="<%=h.getHora_inicio()%>" required/></td></tr>
            <tr><td>Hora Fin:</td><td><input type="time" name="chora_fin" value="<%=h.getHora_fin()%>" required/></td></tr>
            <tr><td>Salón:</td><td><input type="text" name="csalon" value="<%=h.getSalon()%>" required/></td></tr>
            <tr><td colspan="2"><input type="submit" value="Actualizar"/></td></tr>
        </table>
    </form>
</body>
</html>
