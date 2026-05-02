package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.NotificacionDAO;
import java.io.IOException;

public class CtrolNotificacion extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        String accion = request.getParameter("accion");
        NotificacionDAO dao = new NotificacionDAO();

        if ("marcarLeida".equals(accion)) {
            dao.marcarLeida(Integer.parseInt(request.getParameter("id")));
            response.sendRedirect("notificaciones.jsp");

        } else if ("marcarTodas".equals(accion)) {
            // Recuperar el id del usuario en sesión
            String nUsuario = (String) request.getSession(false).getAttribute("nUsuario");
            if (nUsuario != null) {
                // Buscar el id numérico del usuario
                config.Conexion cn = new config.Conexion();
                java.sql.Connection con = cn.crearConexion();
                try {
                    java.sql.PreparedStatement ps = con.prepareStatement(
                        "SELECT identificacion FROM Usuario WHERE usuario = ?");
                    ps.setString(1, nUsuario);
                    java.sql.ResultSet rs = ps.executeQuery();
                    if (rs.next()) dao.marcarTodasLeidas(rs.getInt("identificacion"));
                    con.close();
                } catch (Exception e) { e.printStackTrace(); }
            }
            response.sendRedirect("notificaciones.jsp");
        }
    }

    @Override protected void doGet(HttpServletRequest rq, HttpServletResponse rs)
            throws ServletException, IOException { processRequest(rq, rs); }
    @Override protected void doPost(HttpServletRequest rq, HttpServletResponse rs)
            throws ServletException, IOException { processRequest(rq, rs); }
}
