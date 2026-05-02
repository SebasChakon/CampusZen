<%@page import="modelo.GesActividad"%>
<%@page import="modelo.GesActividadDAO"%>
<%@page import="modelo.Perfil"%>
<%@page import="modelo.PerfilDAO"%>
<%@page import="modelo.Actividades"%>
<%@page import="modelo.ActividadesDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="styles.css">
    <title>Editar Asignación</title>
</head>
<body>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    GesActividadDAO gdao = new GesActividadDAO();
    GesActividad g = gdao.listadoGesActividad_Id(id);
    PerfilDAO pdao = new PerfilDAO();
    List<Perfil> listaPerfiles = pdao.listadoPerfiles();
    ActividadesDAO adao = new ActividadesDAO();
    List<Actividades> listaActs = adao.listadoActividades();
%>
    <h2>Editar Asignación</h2>
    <form method="post" action="CtrolGesActividad">
        <input type="hidden" name="accion" value="editar"/>
        <input type="hidden" name="cidgesActividad" value="<%=g.getIdgesActividad()%>"/>
        <table border="1">
            <tr>
                <td>Perfil:</td>
                <td>
                    <select name="cid_perfil" required>
                        <% for (Perfil p : listaPerfiles) { %>
                        <option value="<%=p.getId_perfil()%>"
                            <%=p.getId_perfil() == g.getId_perfil() ? "selected" : ""%>>
                            <%=p.getPerfil()%>
                        </option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Actividad:</td>
                <td>
                    <select name="cid_actividad" required>
                        <% for (Actividades a : listaActs) { %>
                        <option value="<%=a.getId_actividad()%>"
                            <%=a.getId_actividad() == g.getId_actividad() ? "selected" : ""%>>
                            <%=a.getNom_actividad()%>
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
