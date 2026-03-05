package Controlador;

import jakarta.servlet.http.HttpSession;

/**
 * SessionHelper
 * Centraliza el acceso a los atributos de sesión del usuario.
 * Evita repetir lógica de casteo y valores por defecto en los JSP.
 */
public class SessionHelper {

    private static final String KEY_USUARIO = "usuarioSesion";
    private static final String KEY_ROL     = "rolUsuario";
    private static final String ROL_DEFAULT = "Estudiante";

    /**
     * Retorna el nombre del usuario en sesión, o null si no hay sesión activa.
     */
    public static String getUsuario(HttpSession session) {
        if (session == null) return null;
        return (String) session.getAttribute(KEY_USUARIO);
    }

    /**
     * Retorna el rol del usuario en sesión.
     * Si no está definido, retorna "Estudiante" como valor por defecto.
     */
    public static String getRol(HttpSession session) {
        if (session == null) return ROL_DEFAULT;
        String rol = (String) session.getAttribute(KEY_ROL);
        return rol != null ? rol : ROL_DEFAULT;
    }

    /**
     * Verifica si hay una sesión activa (usuario logueado).
     */
    public static boolean isLoggedIn(HttpSession session) {
        return getUsuario(session) != null;
    }

    /**
     * Cierra la sesión del usuario.
     */
    public static void cerrarSesion(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
    }
}
