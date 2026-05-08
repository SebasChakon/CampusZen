package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.LoginDAO;
import modelo.Usuario;
import java.io.IOException;

public class CtrolValidar extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");

        if (accion != null && accion.equalsIgnoreCase("Ingresar")) {

            String usu = request.getParameter("cusuario");
            String cla = request.getParameter("cclave");

            LoginDAO logindao = new LoginDAO();
            Usuario  datos    = logindao.Login_datos(usu, cla);

            if (datos != null && datos.getUsuario() != null) {

                request.setAttribute("datos", datos);

                HttpSession sesion_cli = request.getSession(true);
                sesion_cli.setAttribute("nUsuario",       usu);
                sesion_cli.setAttribute("idPerfil",       datos.getIdperfil());
                sesion_cli.setAttribute("identificacion", datos.getIdentificacion());

                request.getRequestDispatcher("cpanel.jsp").forward(request, response);

            } else {
                request.setAttribute("error", "Usuario o contraseña incorrectos. Intente de nuevo.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }

        } else {
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() { return "Servlet de validación de credenciales"; }
}
