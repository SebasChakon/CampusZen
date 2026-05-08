<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
    <title>Registrar Usuario</title>
</head>
<body>
    <h2>Registro de Usuario</h2>
    <form id="form1" name="form1" method="post" action="ControladorUsuario">
        <table border="1">
            <tr>
                <td>Identificación:</td>
                <td><input type="text" name="cidentificacion" required/></td>
            </tr>
            <tr>
                <td>Nombre:</td>
                <td><input type="text" name="cnombre" required/></td>
            </tr>
            <tr>
                <td>Apellido:</td>
                <td><input type="text" name="capellido" required/></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><input type="email" name="cmail" required/></td>
            </tr>
            <tr>
                <td>Teléfono:</td>
                <td><input type="text" name="ctelefono"/></td>
            </tr>
            <tr>
                <td>Usuario:</td>
                <td><input type="text" name="cusuario" required/></td>
            </tr>
            <tr>
                <td>Clave:</td>
                <td><input type="password" name="cclave" required/></td>
            </tr>
            <tr>
                <td>Perfil (ID):</td>
                <td><input type="number" name="cidperfil" required/></td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="Guardar"/>
                    <input type="reset" value="Limpiar"/>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
