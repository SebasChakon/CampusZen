<%@page import="modelo.GesActividad, modelo.GesActividadDAO"%>
<%@page import="modelo.Perfil, modelo.PerfilDAO"%>
<%@page import="modelo.Actividades, modelo.ActividadesDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    GesActividadDAO dao   = new GesActividadDAO();
    PerfilDAO       pdao  = new PerfilDAO();
    ActividadesDAO  adao  = new ActividadesDAO();

    List<GesActividad> lista          = dao.listar();
    List<Perfil>       listaPerfiles  = pdao.listadoPerfiles();
    List<Actividades>  listaActs      = adao.listadoActividades();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestión de Actividades por Perfil</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
</head>
<body>
    <h2>Gestión de Actividades por Perfil</h2>

    <fieldset>
        <legend><b>Nueva Asignación</b></legend>
        <form method="post" action="CtrolGesActividad">
            <input type="hidden" name="accion" value="agregar"/>
            <table border="1">
                <tr>
                    <td><label for="cid_perfil">Perfil:</label></td>
                    <td>
                        <select id="cid_perfil" name="cid_perfil" required>
                            <option value="">-- Seleccione --</option>
                            <% for (Perfil p : listaPerfiles) { %>
                            <option value="<%=p.getId_perfil()%>"><%=p.getPerfil()%></option>
                            <% } %>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><label for="cid_actividad">Actividad (menú):</label></td>
                    <td>
                        <select id="cid_actividad" name="cid_actividad" required>
                            <option value="">-- Seleccione --</option>
                            <% for (Actividades a : listaActs) { %>
                            <option value="<%=a.getId_actividad()%>"><%=a.getNom_actividad()%></option>
                            <% } %>
                        </select>
                    </td>
                </tr>
                <tr><td colspan="2"><input type="submit" value="Asignar"/></td></tr>
            </table>
        </form>
    </fieldset>
    <br/>

    <table border="1">
        <tr>
            <th>ID</th><th>ID Perfil</th><th>ID Actividad</th><th>Acciones</th>
        </tr>
        <% for (GesActividad g : lista) { %>
        <tr>
            <td><%=g.getIdgesActividad()%></td>
            <td><%=g.getId_perfil()%></td>
            <td><%=g.getId_actividad()%></td>
            <td>
                <a href="EditarGesActividad.jsp?id=<%=g.getIdgesActividad()%>" target="marco">Editar</a>
                <a href="CtrolGesActividad?accion=eliminar&id=<%=g.getIdgesActividad()%>"
                   onclick="return confirm('¿Eliminar asignación?')">Eliminar</a>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
