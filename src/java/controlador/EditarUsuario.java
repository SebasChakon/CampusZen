package controlador;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Usuario;
import modelo.UsuarioDAO;
import org.mindrot.jbcrypt.BCrypt;

public class EditarUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // cidd = identificacion original (PK, no cambia)
        String identificacion = request.getParameter("cidd");
        String nombre         = request.getParameter("cnombre");
        String apellido       = request.getParameter("capellido");
        String email          = request.getParameter("cmail");
        String telefono       = request.getParameter("ctelefono");
        String usuario        = request.getParameter("cusuario");
        String claveNueva     = request.getParameter("cclave");
        int    idperfil       = Integer.parseInt(request.getParameter("cperfil"));

        UsuarioDAO udao = new UsuarioDAO();

        // Si clave vacía → conservar hash actual
        String claveHash;
        if (claveNueva != null && !claveNueva.trim().isEmpty()) {
            claveHash = BCrypt.hashpw(claveNueva, BCrypt.gensalt());
        } else {
            Usuario actual = udao.listadoDatos_Id(identificacion);
            claveHash = (actual != null) ? actual.getClave() : "";
        }

        Usuario a = new Usuario();
        a.setIdentificacion(identificacion);
        a.setNombre(nombre);
        a.setApellido(apellido);
        a.setEmail(email);
        a.setTelefono(telefono);
        a.setUsuario(usuario);
        a.setClave(claveHash);
        a.setIdperfil(idperfil);

        int status = udao.actualizarDatos(a);

        if (status > 0) {
            response.sendRedirect("listaUsuarios.jsp");
        } else {
            response.getWriter().println("Error al actualizar usuario");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }

    @Override
    public String getServletInfo() { return "Short description"; }
}
