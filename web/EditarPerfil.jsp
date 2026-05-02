<%@page import="modelo.Perfil"%>
<%@page import="modelo.PerfilDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="styles.css">
    <title>Editar Perfil</title>
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
                <td>Perfil:</td>
                <td><input type="text" name="cperfil" value="<%=p.getPerfil()%>" required/></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="Actualizar"/></td>
            </tr>
        </table>
    </form>
</body>
</html>
