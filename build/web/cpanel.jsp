<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="config.Conexion" %>
<%
    HttpSession sesion_cli = request.getSession(true);
    String nUsuario = (String) sesion_cli.getAttribute("nUsuario");
    Connection con = null;
    Statement  sentencia = null;
    ResultSet  resultado = null;
    String nombre   = null;
    String apellido = null;
    String usu      = null;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Panel de Control</title>
</head>
<body>
<%
    try {
        Conexion cn = new Conexion();
        con = cn.crearConexion();
        sentencia = con.createStatement();
        resultado = sentencia.executeQuery(
            "SELECT * FROM Usuario WHERE usuario = '" + nUsuario + "' AND id_estado = 1"
        );
        while (resultado.next()) {
            nombre   = resultado.getString("nombre");
            apellido = resultado.getString("apellido");
            usu      = resultado.getString("usuario");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    con.close();
%>

<div id="apDiv2">
    <table width="1184" height="50" border="1">
        <tr>
            <td width="473"><%=nombre%>&nbsp;<%=apellido%></td>
            <td width="168"><a href="CerrarSesion">Cerrar sesión</a></td>
        </tr>
    </table>
</div>

<div id="apDiv1">
    <table width="1191" height="667" border="1">
        <tr>
            <!-- Panel izquierdo: Menú dinámico -->
            <td width="303" valign="top">
                <div id="apDiv5">
                    <table width="244" border="1">
                        <tr>
                            <th><strong>Menú</strong></th>
                        </tr>
<%
    if (usu != null && usu.equals(nUsuario)) {
        Conexion cn1 = new Conexion();
        con = cn1.crearConexion();
        sentencia = con.createStatement();

        // ADAPTADO A LA NUEVA BD:
        // GesActividad solo tiene id_perfil e id_actividad.
        // El menú se filtra por el perfil del usuario en sesión.
        resultado = sentencia.executeQuery(
            "SELECT a.nom_actividad AS actividad, " +
            "       a.enlace        AS enlace " +
            "FROM actividades a " +
            "JOIN GesActividad g ON a.id_actividad = g.id_actividad " +
            "JOIN Usuario u      ON g.id_perfil    = u.id_perfil " +
            "WHERE u.usuario     = '" + nUsuario + "' " +
            "  AND a.id_estado   = 1 " +
            "  AND g.id_estado   = 1"
        );
        while (resultado.next()) {
%>
                        <tr>
                            <td>
                                <a href="<%=resultado.getString("enlace")%>" target="marco">
                                    <%=resultado.getString("actividad")%>
                                </a>
                            </td>
                        </tr>
<%
        }
        con.close();
    }
%>
                    </table>
                </div>
            </td>

            <!-- Panel derecho: iframe -->
            <td valign="top">
                <div id="apDiv7">
                    <iframe width="869" height="493" name="marco" src="front.jsp" frameborder="0"></iframe>
                </div>
            </td>
        </tr>
    </table>
</div>
</body>
</html>
