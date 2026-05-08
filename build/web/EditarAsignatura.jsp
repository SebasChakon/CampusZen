<%@page import="modelo.Asignatura, modelo.AsignaturaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    AsignaturaDAO dao = new AsignaturaDAO();
    Asignatura a = dao.buscarPorId(id);
    if (a == null) { out.println("Asignatura no encontrada."); return; }
%>
<!DOCTYPE html>
<html>
<head><meta charset="UTF-8"><title>Editar Asignatura</title></head>
<link rel="stylesheet" href="styles.css">
<body>
    <h2>Editar Asignatura</h2>
    <form method="post" action="CtrolAsignatura">
        <input type="hidden" name="accion" value="editar"/>
        <input type="hidden" name="cid_asignatura" value="<%=a.getId_asignatura()%>"/>
        <table border="1">
            <tr><td><label for="cnombre">Nombre:</label></td><td><input type="text" id="cnombre" name="cnombre" value="<%=a.getNombre()%>" required/></td></tr>
            <tr><td><label for="cdescripcion">Descripción:</label></td><td><input type="text" id="cdescripcion" name="cdescripcion" value="<%=a.getDescripcion()%>"/></td></tr>
            <tr><td><label for="ccreditos">Créditos:</label></td><td><input type="number" id="ccreditos" name="ccreditos" value="<%=a.getCreditos()%>" min="1" max="10"/></td></tr>
            <tr><td colspan="2"><input type="submit" value="Actualizar"/></td></tr>
        </table>
    </form>
</body>
</html>
