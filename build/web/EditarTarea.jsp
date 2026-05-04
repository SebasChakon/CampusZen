<%@page import="modelo.Tarea, modelo.TareaDAO"%>
<%@page import="config.Conexion, java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    TareaDAO dao = new TareaDAO();
    Tarea t = dao.buscarPorId(id);
    if (t == null) { out.println("Tarea no encontrada."); return; }

    // Cargar actividades y usuarios para los combos
    List<String[]> actividades = new java.util.ArrayList<>();
    List<String[]> usuarios    = new java.util.ArrayList<>();
    try {
        Conexion cn = new Conexion();
        Connection con = cn.crearConexion();

        PreparedStatement psA = con.prepareStatement(
            "SELECT id_actividad, nombre FROM Actividad WHERE id_estado = 1 ORDER BY nombre");
        ResultSet rsA = psA.executeQuery();
        while (rsA.next())
            actividades.add(new String[]{rsA.getString("id_actividad"), rsA.getString("nombre")});
        rsA.close(); psA.close();

        PreparedStatement psU = con.prepareStatement(
            "SELECT identificacion, nombre, apellido FROM Usuario WHERE id_estado = 1 ORDER BY nombre");
        ResultSet rsU = psU.executeQuery();
        while (rsU.next())
            usuarios.add(new String[]{rsU.getString("identificacion"),
                rsU.getString("nombre") + " " + rsU.getString("apellido")});
        rsU.close(); psU.close();

        con.close();
    } catch (Exception e) { e.printStackTrace(); }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Tarea</title>
</head>
<body>
    <h2>Editar Tarea</h2>
    <form method="post" action="CtrolTareas">
        <input type="hidden" name="accion" value="editar"/>
        <input type="hidden" name="cid_tarea" value="<%=t.getId_tarea()%>"/>
        <table border="1">
            <tr>
                <td>Nombre:</td>
                <td><input type="text" name="cnombre" value="<%=t.getNombre()%>" required/></td>
            </tr>
            <tr>
                <td>Descripción:</td>
                <td><input type="text" name="cdescripcion" value="<%=t.getDescripcion() != null ? t.getDescripcion() : ""%>"/></td>
            </tr>
            <tr>
                <td>Fecha Límite:</td>
                <td>
                    <input type="datetime-local" name="cfecha_limite" required
                        value="<%=t.getFecha_limite() != null ? t.getFecha_limite().toString().replace(" ","T").substring(0,16) : ""%>"/>
                </td>
            </tr>
            <tr>
                <td>Prioridad:</td>
                <td>
                    <select name="cprioridad">
                        <option value="alta"  <%="alta".equals(t.getPrioridad())  ? "selected":""%>>Alta</option>
                        <option value="media" <%="media".equals(t.getPrioridad()) ? "selected":""%>>Media</option>
                        <option value="baja"  <%="baja".equals(t.getPrioridad())  ? "selected":""%>>Baja</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Estado:</td>
                <td>
                    <select name="cestado">
                        <option value="pendiente"   <%="pendiente".equals(t.getEstado())   ? "selected":""%>>Pendiente</option>
                        <option value="en progreso" <%="en progreso".equals(t.getEstado()) ? "selected":""%>>En Progreso</option>
                        <option value="entregada"   <%="entregada".equals(t.getEstado())   ? "selected":""%>>Entregada</option>
                        <option value="revisada"    <%="revisada".equals(t.getEstado())    ? "selected":""%>>Revisada</option>
                        <option value="cerrada"     <%="cerrada".equals(t.getEstado())     ? "selected":""%>>Cerrada</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Actividad:</td>
                <td>
                    <select name="cid_actividad" required>
                        <option value="">-- Seleccione una actividad --</option>
                        <% for (String[] a : actividades) { %>
                        <option value="<%=a[0]%>"
                            <%=a[0].equals(String.valueOf(t.getId_actividad())) ? "selected":""%>>
                            <%=a[1]%>
                        </option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Usuario Asignado:</td>
                <td>
                    <select name="cid_usuario_asignado" required>
                        <option value="">-- Seleccione un usuario --</option>
                        <% for (String[] u : usuarios) { %>
                        <option value="<%=u[0]%>"
                            <%=u[0].equals(String.valueOf(t.getId_usuario_asignado())) ? "selected":""%>>
                            <%=u[1]%>
                        </option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Observaciones:</td>
                <td><input type="text" name="cobservaciones"
                    value="<%=t.getObservaciones() != null ? t.getObservaciones() : ""%>"/></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Actualizar"/></td>
            </tr>
        </table>
    </form>
</body>
</html>
