package Controlador;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/**
 * LoginHandler
 * Centraliza la lógica de autenticación y registro de usuarios.
 * Retorna "redirect" si el proceso fue exitoso, o un mensaje de error en caso contrario.
 */
public class LoginHandler {

    /**
     * Procesa la acción del formulario (login o registro).
     *
     * @param request La solicitud HTTP con los parámetros del formulario.
     * @param session La sesión HTTP donde se almacenan los datos del usuario.
     * @return "redirect" si el proceso fue exitoso, o un String con el mensaje de error.
     */
    public static String procesar(HttpServletRequest request, HttpSession session) {
        String accion = request.getParameter("accion");

        if ("login".equals(accion)) {
            return procesarLogin(request, session);
        }

        if ("registro".equals(accion)) {
            return procesarRegistro(request, session);
        }

        return "Acción no reconocida.";
    }

    // ============================================================
    // LOGIN
    // ============================================================

    private static String procesarLogin(HttpServletRequest request, HttpSession session) {
        String usuario  = request.getParameter("usuario");
        String password = request.getParameter("password");

        // Validación simulada: campos no vacíos = acceso concedido
        if (usuario != null && !usuario.trim().isEmpty()
                && password != null && !password.isEmpty()) {

            session.setAttribute("usuarioSesion", usuario.trim());
            session.setAttribute("rolUsuario", "Estudiante"); // rol por defecto
            return "redirect";
        }

        return "Debes ingresar usuario y contraseña.";
    }

    // ============================================================
    // REGISTRO
    // ============================================================

    private static String procesarRegistro(HttpServletRequest request, HttpSession session) {
        String nombre  = request.getParameter("nombre");
        String email   = request.getParameter("email");
        String newPass = request.getParameter("newPassword");
        String rol     = request.getParameter("rol");

        if (nombre != null && !nombre.trim().isEmpty()
                && email != null && !email.trim().isEmpty()
                && newPass != null && !newPass.isEmpty()) {

            session.setAttribute("usuarioSesion", nombre.trim());
            session.setAttribute("rolUsuario", rol != null ? rol : "Estudiante");
            return "redirect";
        }

        return "Completa todos los campos del registro.";
    }
}
