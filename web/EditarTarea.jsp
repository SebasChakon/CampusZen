<%@page import="modelo.Tarea, modelo.TareaDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    TareaDAO dao = new TareaDAO();
    Tarea t = dao.buscarPorId(id);
    if (t == null) { out.println("Tarea no encontrada."); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="styles.css">
    <meta charset="UTF-8"><title>Editar Tarea</title>
</head>
<body>
    <h2>Editar Tarea</h2>
    <form method="post" action="CtrolTareas">
        <input type="hidden" name="accion" value="editar"/>
        <input type="hidden" name="cid_tarea" value="<%=t.getId_tarea()%>"/>
        <table border="1">
            <tr><td>Nombre:</td><td><input type="text" name="cnombre" value="<%=t.getNombre()%>" required/></td></tr>
            <tr><td>Descripción:</td><td><input type="text" name="cdescripcion" value="<%=t.getDescripcion()%>"/></td></tr>
            <tr><td>Fecha Límite:</td><td><input type="datetime-local" name="cfecha_limite" value="<%=t.getFecha_limite() != null ? t.getFecha_limite().toString().replace(" ","T").substring(0,16) : ""%>" required/></td></tr>
            <tr>
                <td>Prioridad:</td>
                <td>
                    <select name="cprioridad">
                        <option value="alta"   <%="alta".equals(t.getPrioridad())   ? "selected":""%>>Alta</option>
                        <option value="media"  <%="media".equals(t.getPrioridad())  ? "selected":""%>>Media</option>
                        <option value="baja"   <%="baja".equals(t.getPrioridad())   ? "selected":""%>>Baja</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Estado:</td>
                <td>
                    <select name="cestado">
                        <option value="pendiente"   <%="pendiente".equals(t.getEstado())    ? "selected":""%>>Pendiente</option>
                        <option value="en progreso" <%="en progreso".equals(t.getEstado())  ? "selected":""%>>En Progreso</option>
                        <option value="entregada"   <%="entregada".equals(t.getEstado())    ? "selected":""%>>Entregada</option>
                        <option value="revisada"    <%="revisada".equals(t.getEstado())     ? "selected":""%>>Revisada</option>
                        <option value="cerrada"     <%="cerrada".equals(t.getEstado())      ? "selected":""%>>Cerrada</option>
                    </select>
                </td>
            </tr>
            <tr><td>ID Actividad:</td><td><input type="number" name="cid_actividad" value="<%=t.getId_actividad()%>"/></td></tr>
            <tr><td>ID Usuario Asignado:</td><td><input type="number" name="cid_usuario_asignado" value="<%=t.getId_usuario_asignado()%>"/></td></tr>
            <tr><td>Observaciones:</td><td><input type="text" name="cobservaciones" value="<%=t.getObservaciones() != null ? t.getObservaciones() : ""%>"/></td></tr>
            <tr><td colspan="2"><input type="submit" value="Actualizar"/></td></tr>
        </table>
    </form>
</body>
</html>
