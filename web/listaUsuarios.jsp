<%-- 
    Document   : listaUsuarios
    Created on : 19/03/2026, 9:47:42 a. m.
    Author     : sebas
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.UsuarioDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
    <title>Listado de Usuarios</title>
    <%
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); //Borrar directivas de memoria cache y anular algoritmos predeterminados para almacenar cache
        response.setHeader("Pragma", "no-cache");//Directivas compatibles con memorias cache
        response.setDateHeader("Expires", 0);//Proporciona fecha y hora para decir el tiempo de respuesta caduco
    %>
</head>
<body>

    <h2>Listado de Datos de usuarios</h2>

    <table border="1">
        <tr>
            <th>Identificación</th>
            <th>Nombres</th>
            <th>Apellidos</th>
            <th>E-mail</th>
            <th>Teléfono</th>
            <th>Usuario</th>
            <th>Contraseña</th>
            <th>Perfil</th>
            <th>Acción</th>
        </tr>

        <%
            UsuarioDAO udao = new UsuarioDAO();
            List<Usuario> lista = udao.listadoDatos();

            for (Usuario a : lista) {
        %>

        <tr>
            <td><%=a.getIdentificacion()%></td>
            <td><%=a.getNombre()%></td>
            <td><%=a.getApellido()%></td>
            <td><%=a.getEmail()%></td>
            <td><%=a.getTelefono()%></td>
            <td><%=a.getUsuario()%></td>
            <td>******</td>
            <td><%=a.getIdperfil()%></td>
            <td>
                <a href="EditarUsuario.jsp?id=<%=a.getIdentificacion()%>" target="marco">Editar</a>
                <a href="EliminarUsuario?id=<%=a.getIdentificacion()%>" onclick="return confirm('¿Eliminar usuario?')">Eliminar</a>
            </td>
        </tr>

        <%
            }
        %>

    </table>

</body>
</html>