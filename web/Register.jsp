<%-- 
    Document   : index.jsp
    Created on : 17/03/2026, 5:19:29 p. m.
    Author     : sebas
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="styles.css">
        <link rel="icon" type="image/png" href="img/icono.png">
        <title>CampusZen | Registro</title>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //Borrar directivas de memoria cache y anular algoritmos predeterminados para almacenar cache
            response.setHeader("Pragma", "no-cache");//Directivas compatibles con memorias cache
            response.setDateHeader("Expires", 0);//Proporciona fecha y hora para decir el tiempo de respuesta caduco
        %>
    </head>
    <body>
        <h2>Registro de Usuario</h2>
        <form id="form1" name="form1" method="post" action="ControladorUsuario">
            <table>
                <tr>
                    <td><label for="cidentificacion">Identificación:</label></td>
                    <td><input type="text" id="cidentificacion" name="cidentificacion" required minlength="10" maxlength="10" pattern="[0-9]{10}" title="Debe contener exactamente 10 números"/></td>
                </tr>
                <tr>
                    <td><label for="cnombre">Nombre:</label></td>
                    <td><input type="text" id="cnombre" name="cnombre" required title="Ingrese su nombre"/></td>
                </tr>
                <tr>
                    <td><label for="capellido">Apellido:</label></td>
                    <td><input type="text" id="capellido" name="capellido" required title="Ingrese su apellido"/></td>
                </tr>
                <tr>
                    <td><label for="cmail">Email:</label></td>
                    <td><input type="email" id="cmail" name="cmail" required title="Ingrese un correo válido (ejemplo@correo.com)"/></td>
                </tr>
                <tr>
                    <td><label for="ctelefono">Teléfono:</label></td>
                    <td><input type="text" id="ctelefono" name="ctelefono" required minlength="10" maxlength="10" pattern="[0-9]{10}" title="Debe contener exactamente 10 números"/></td>
                </tr>
                <tr>
                    <td><label for="cusuario">Usuario:</label></td>
                    <td><input type="text" id="cusuario" name="cusuario" required minlength="4" title="Debe tener al menos 4 caracteres"/></td>
                </tr>
                <tr>
                  <td><label for="cclave">Clave:</label></td>
                  <td>
                    <input 
                      type="password" 
                      id="cclave"
                      name="cclave" 
                      required
                      minlength="8"
                      pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$"
                      title="Debe tener al menos 8 caracteres, incluir mayúsculas, minúsculas, números y símbolos">
                  </td>
                </tr>
                <tr>
                    <td><label for="cidperfil">Perfil:</label></td>
                    <td>
                        <select id="cidperfil" name="cidperfil" required>
                            <option value="">Seleccione un perfil</option>
                            <option value="1">Administrador</option>
                            <option value="2">Docente</option>
                            <option value="3">Estudiante</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="submit" value="Guardar"/>
                        <input type="reset" value="Limpiar"/>
                    </td>
                </tr>
            </table>
            <p style="margin-top: 18px; color: #4b6f52;">¿Ya tienes cuenta? <a href="login.jsp">Inicia sesión</a>.</p>
        </form>
    </body>
</html>