<%@page import="modelo.Perfil"%>
<%@page import="modelo.PerfilDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
    <title>Editar Perfil</title>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //Borrar directivas de memoria cache y anular algoritmos predeterminados para almacenar cache
        response.setHeader("Pragma", "no-cache");//Directivas compatibles con memorias cache
        response.setDateHeader("Expires", 0);//Proporciona fecha y hora para decir el tiempo de respuesta caduco
    %>
</head>
<body>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    PerfilDAO pdao = new PerfilDAO();
    Perfil p = pdao.listadoPerfil_Id(id);
%>
    <h2>Editar Perfil</h2>
    <form method="post" action="CtrolPerfil">
        <input type="hidden" name="accion" value="editar"/>
        <input type="hidden" name="cid_perfil" value="<%=p.getId_perfil()%>"/>
        <table border="1">
            <tr>
                <td><label for="cperfil">Perfil:</label></td>
                <td><input type="text" id="cperfil" name="cperfil" value="<%=p.getPerfil()%>" required/></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Actualizar"/></td>
            </tr>
        </table>
    </form>
</body>
</html>
