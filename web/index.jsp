<%-- 
    Document   : index.jsp
    Created on : 17/03/2026, 5:19:29 p. m.
    Author     : sebas
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles.css">
        <title>Administración de Usuarios</title>
    </head>

    <body>
        <h2>Login</h2>

        <form id="form1" name="form1" method="post" action="CtrolValidar">
            <table width="421" height="102" border="1">
                
                <tr>
                    <td width="157">Usuario</td>
                    <td width="248">
                        <label for="cusuario"></label>
                        <input type="text" name="cusuario" id="cusuario" />
                    </td>
                </tr>

                <tr>
                    <td>Contraseña</td>
                    <td>
                        <label for="cclave"></label>
                        <input type="password" name="cclave" id="cclave" />
                    </td>
                </tr>

                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <input name="accion" value="Ingresar" type="submit" id="button" />
                    </td>
                </tr>

            </table>
            <a href="Register.jsp">Registrarse</a>
        </form>

    </body>
</html>