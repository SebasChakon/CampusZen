<%@page import="modelo.Actividades"%>
<%@page import="modelo.ActividadesDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
    <title>Gestionar Actividades</title>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //Borrar directivas de memoria cache y anular algoritmos predeterminados para almacenar cache
        response.setHeader("Pragma", "no-cache");//Directivas compatibles con memorias cache
        response.setDateHeader("Expires", 0);//Proporciona fecha y hora para decir el tiempo de respuesta caduco
    %>
</head>
<body>
    <h2>Gestión de Actividades</h2>
    <form method="post" action="CtrolActividades">
        <input type="hidden" name="accion" value="agregar"/>
        <table border="1">
            <tr>
                <td><label for="cnom_actividad">Nombre Actividad:</label></td>
                <td><input type="text" id="cnom_actividad" name="cnom_actividad" required/></td>
            </tr>
            <tr>
                <td><label for="cenlace">Enlace:</label></td>
                <td><input type="text" id="cenlace" name="cenlace" required/></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Agregar"/></td>
            </tr>
        </table>
    </form>
    <br/>
    <table border="1">
        <tr>
            <th>ID</th><th>Nombre Actividad</th><th>Enlace</th><th>Acciones</th>
        </tr>
        <%
            ActividadesDAO adao = new ActividadesDAO();
            List<Actividades> lista = adao.listadoActividades();
            for (Actividades a : lista) {
        %>
        <tr>
            <td><%=a.getId_actividad()%></td>
            <td><%=a.getNom_actividad()%></td>
            <td><%=a.getEnlace()%></td>
            <td>
                <a href="EditarActividad.jsp?id=<%=a.getId_actividad()%>" target="marco">Editar</a>
                <a href="CtrolActividades?accion=eliminar&id=<%=a.getId_actividad()%>"
                   onclick="return confirm('¿Eliminar?')">Eliminar</a>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
