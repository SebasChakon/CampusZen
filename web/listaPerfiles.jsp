<%@page import="modelo.Perfil"%>
<%@page import="modelo.PerfilDAO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
    <title>Gestionar Perfiles</title>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //Borrar directivas de memoria cache y anular algoritmos predeterminados para almacenar cache
        response.setHeader("Pragma", "no-cache");//Directivas compatibles con memorias cache
        response.setDateHeader("Expires", 0);//Proporciona fecha y hora para decir el tiempo de respuesta caduco
    %>
</head>
<body>
    <h2>Gestión de Perfiles</h2>
    <form method="post" action="CtrolPerfil">
        <input type="hidden" name="accion" value="agregar"/>
        <table border="1">
            <tr>
                <td><label for="cperfil">Nombre Perfil:</label></td>
                <td><input type="text" id="cperfil" name="cperfil" required/></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Agregar"/></td>
            </tr>
        </table>
    </form>
    <br/>
    <table border="1">
        <tr>
            <th>ID</th><th>Perfil</th><th>Acciones</th>
        </tr>
        <%
            PerfilDAO pdao = new PerfilDAO();
            List<Perfil> lista = pdao.listadoPerfiles();
            for (Perfil p : lista) {
        %>
        <tr>
            <td><%=p.getId_perfil()%></td>
            <td><%=p.getPerfil()%></td>
            <td>
                <a href="EditarPerfil.jsp?id=<%=p.getId_perfil()%>" target="marco">Editar</a>
                <a href="CtrolPerfil?accion=eliminar&id=<%=p.getId_perfil()%>"
                   onclick="return confirm('¿Eliminar?')">Eliminar</a>
            </td>
        </tr>
        <% } %>
    </table>
</body>
</html>
