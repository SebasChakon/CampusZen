<%@page import="modelo.GesActividad, modelo.GesActividadDAO"%>
<%@page import="modelo.Perfil, modelo.PerfilDAO"%>
<%@page import="modelo.Actividades, modelo.ActividadesDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    GesActividadDAO dao  = new GesActividadDAO();
    GesActividad    g    = dao.buscarPorId(id);
    if (g == null) { out.println("Asignación no encontrada."); return; }

    PerfilDAO      pdao = new PerfilDAO();
    ActividadesDAO adao = new ActividadesDAO();
    List<Perfil>      listaPerfiles = pdao.listadoPerfiles();
    List<Actividades> listaActs     = adao.listadoActividades();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Editar Asignación</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
</head>
<body>
    <h2>Editar Asignación</h2>
    <form method="post" action="CtrolGesActividad">
        <input type="hidden" name="accion" value="editar"/>
        <input type="hidden" name="cidgesActividad" value="<%=g.getIdgesActividad()%>"/>
        <table border="1">
            <tr>
                <td><label for="cid_perfil">Perfil:</label></td>
                <td>
                    <select id="cid_perfil" name="cid_perfil" required>
                        <% for (Perfil p : listaPerfiles) { %>
                        <option value="<%=p.getId_perfil()%>"
                            <%=p.getId_perfil()==g.getId_perfil()?"selected":""%>>
                            <%=p.getPerfil()%>
                        </option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="cid_actividad">Actividad (menú):</label></td>
                <td>
                    <select id="cid_actividad" name="cid_actividad" required>
                        <% for (Actividades a : listaActs) { %>
                        <option value="<%=a.getId_actividad()%>"
                            <%=a.getId_actividad()==g.getId_actividad()?"selected":""%>>
                            <%=a.getNom_actividad()%>
                        </option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr><td colspan="2"><input type="submit" value="Actualizar"/></td></tr>
        </table>
    </form>
</body>
</html>
