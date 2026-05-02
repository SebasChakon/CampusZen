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
    <title>Gestión Actividades por Perfil</title>
</head>
<body>
    <h2>Gestión de Actividades por Perfil</h2>
    <%
        PerfilDAO pdao = new PerfilDAO();
        List<Perfil> listaPerfiles = pdao.listadoPerfiles();
        ActividadesDAO adao = new ActividadesDAO();
        List<Actividades> listaActs = adao.listadoActividades();
    %>
    <form method="post" action="CtrolGesActividad">
        <input type="hidden" name="accion" value="agregar"/>
        <table border="1">
            <tr>
                <td>Perfil:</td>
                <td>
                    <select name="cid_perfil" required>
                        <option value="">-- Seleccione --</option>
                        <% for (Perfil p : listaPerfiles) { %>
                        <option value="<%=p.getId_perfil()%>"><%=p.getPerfil()%></option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td>Actividad:</td>
                <td>
                    <select name="cid_actividad" required>
                        <option value="">-- Seleccione --</option>
                        <% for (Actividades a : listaActs) { %>
                        <option value="<%=a.getId_actividad()%>"><%=a.getNom_actividad()%></option>
                        <% } %>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Asignar"/></td>
            </tr>
        </table>
    </form>
    <br/>
    <table border="1">
        <tr>
            <th>ID</th><th>ID Perfil</th><th>ID Actividad</th><th>Acciones</th>
        </tr>
        <%
            GesActividadDAO gdao = new GesActividadDAO();
            List<GesActividad> lista = gdao.listadoGesActividades();
            for (GesActividad g : lista) {
        %>
        <tr>
            <td><%=g.getIdgesActividad()%></td>
            <td><%=g.getId_perfil()%></td>
            <td><%=g.getId_actividad()%></td>
            <td>
                <a href="EditarGesActividad.jsp?id=<%=g.getIdgesActividad()%>" target="marco">Editar</a>
                <a href="CtrolGesActividad?accion=eliminar&id=<%=g.getIdgesActividad()%>"
                   onclick="return confirm('¿Eliminar?')">Eliminar</a>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
