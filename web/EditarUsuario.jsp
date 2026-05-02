<%@page import="modelo.Usuario"%>
<%@page import="modelo.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="styles.css">
    
    <title>Editar Usuario</title>
</head>
<body>

<%
    UsuarioDAO udao = new UsuarioDAO();
    int id = Integer.parseInt(request.getParameter("id"));
    Usuario a = udao.listadoDatos_Id(id);
%>

<div id="apDiv1">
    <form id="form1" name="form1" method="post" action="EditarUsuario">
        
        <table width="665" border="1">

            <tr>
                <td>Identificación</td>
                <td>
                    <input type="hidden" name="cidd" value="<%=a.getIdentificacion()%>"/>
                    <input type="text" name="cid" id="cid" value="<%=a.getIdentificacion()%>"/>
                </td>
            </tr>

            <tr>
                <td>Nombres</td>
                <td>
                    <input name="cnombre" type="text" id="cnombre" size="40"
                           value="<%=a.getNombre()%>"/>
                </td>
            </tr>

            <tr>
                <td>Apellidos</td>
                <td>
                    <input name="capellido" type="text" id="capellido" size="40"
                           value="<%=a.getApellido()%>"/>
                </td>
            </tr>

            <tr>
                <td>E-mail</td>
                <td>
                    <input name="cmail" type="text" id="cmail" size="60"
                           value="<%=a.getEmail()%>"/>
                </td>
            </tr>

            <tr>
                <td>Teléfono</td>
                <td>
                    <input name="ctelefono" type="text" id="ctelefono" size="30"
                           value="<%=a.getTelefono()%>"/>
                </td>
            </tr>

            <tr>
                <td>Usuario</td>
                <td>
                    <input type="text" name="cusuario" id="cusuario"
                           value="<%=a.getUsuario()%>"/>
                </td>
            </tr>

            <tr>
                <td>Clave</td>
                <td>
                    <input type="password" name="cclave" id="cclave"
                           value="<%=a.getClave()%>"/>
                </td>
            </tr>

            <tr>
                <td>Perfil</td>
                <td>
                    <input type="text" name="cperfil" id="cperfil"
                           value="<%=a.getIdperfil()%>"/>
                </td>
            </tr>

        </table>

        <p>
            <input type="submit" name="button" id="button" value="Actualizar"/>
        </p>

    </form>
</div>

</body>
</html>