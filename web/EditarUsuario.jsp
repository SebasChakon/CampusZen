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
    String id = request.getParameter("id");
    Usuario a = null;
    if (id != null && !id.isEmpty()) {
        UsuarioDAO udao = new UsuarioDAO();
        a = udao.listadoDatos_Id(id);
    }
    if (a == null) {
%>
    <p>No se encontró el usuario. <a href="listaUsuarios.jsp">Volver</a></p>
<% } else { %>
    <h2>Editar Usuario</h2>
    <form id="form1" name="form1" method="post" action="EditarUsuario">

        <%-- La identificacion es PK con FKs en otras tablas → no editable --%>
        <input type="hidden" name="cidd" value="<%=a.getIdentificacion()%>"/>

        <table>
            <tr>
                <td>Identificación:</td>
                <td>
                    <%-- Solo lectura: se muestra pero no se puede cambiar --%>
                    <input
                        type="text"
                        value="<%=a.getIdentificacion()%>"
                        disabled
                        style="background:#f0f0f0; color:#888; cursor:not-allowed;"
                        title="La identificación no puede modificarse"/>
                </td>
            </tr>
            <tr>
                <td>Nombre:</td>
                <td>
                    <input
                        type="text"
                        name="cnombre"
                        size="40"
                        value="<%=a.getNombre()%>"
                        required
                        title="Ingrese el nombre"/>
                </td>
            </tr>
            <tr>
                <td>Apellido:</td>
                <td>
                    <input
                        type="text"
                        name="capellido"
                        size="40"
                        value="<%=a.getApellido()%>"
                        required
                        title="Ingrese el apellido"/>
                </td>
            </tr>
            <tr>
                <td>Email:</td>
                <td>
                    <input
                        type="email"
                        name="cmail"
                        size="60"
                        value="<%=a.getEmail()%>"
                        required
                        title="Ingrese un correo válido (ejemplo@correo.com)"/>
                </td>
            </tr>
            <tr>
                <td>Teléfono:</td>
                <td>
                    <input
                        type="text"
                        name="ctelefono"
                        value="<%=a.getTelefono()%>"
                        required
                        minlength="10"
                        maxlength="10"
                        pattern="[0-9]{10}"
                        title="Debe contener exactamente 10 números"/>
                </td>
            </tr>
            <tr>
                <td>Usuario:</td>
                <td>
                    <input
                        type="text"
                        name="cusuario"
                        value="<%=a.getUsuario()%>"
                        required
                        minlength="4"
                        title="Debe tener al menos 4 caracteres"/>
                </td>
            </tr>
            <tr>
                <td>Clave:</td>
                <td>
                    <input
                        type="password"
                        name="cclave"
                        placeholder="Dejar vacío para no cambiar"
                        minlength="8"
                        pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$"
                        title="Debe tener al menos 8 caracteres, incluir mayúsculas, minúsculas, números y símbolos"/>
                    <small>Dejar vacío para conservar la clave actual.</small>
                </td>
            </tr>
            <tr>
                <td>Perfil:</td>
                <td>
                    <select name="cperfil" required title="Seleccione un perfil">
                        <option value="">Seleccione un perfil</option>
                        <option value="1" <%=a.getIdperfil()==1?"selected":""%>>Administrador</option>
                        <option value="2" <%=a.getIdperfil()==2?"selected":""%>>Usuario</option>
                        <option value="3" <%=a.getIdperfil()==3?"selected":""%>>Docente</option>
                        <option value="4" <%=a.getIdperfil()==4?"selected":""%>>Estudiante</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="Actualizar"/>
                    <a href="listaUsuarios.jsp">Cancelar</a>
                </td>
            </tr>
        </table>
    </form>
<% } %>
</body>
</html>
