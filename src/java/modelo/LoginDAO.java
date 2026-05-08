package modelo;

import config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;

public class LoginDAO {

    public LoginDAO() {}

    public Usuario Login_datos(String usuario, String clave) {

        Usuario datos = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();

            stmt = conn.prepareStatement(
                "SELECT * FROM Usuario WHERE usuario = ? AND id_estado = 1");
            stmt.setString(1, usuario);
            rs = stmt.executeQuery();

            if (rs.next()) {
                String hashGuardado = rs.getString("clave");
                if (BCrypt.checkpw(clave, hashGuardado)) {
                    datos = new Usuario();
                    datos.setIdentificacion(rs.getString("identificacion")); // para la sesión
                    datos.setUsuario(rs.getString("usuario"));
                    datos.setClave(rs.getString("clave"));
                    datos.setNombre(rs.getString("nombre"));
                    datos.setApellido(rs.getString("apellido"));
                    datos.setIdperfil(rs.getInt("id_perfil"));
                }
            }

        } catch (SQLException e) {
            System.out.println("ERROR LoginDAO: " + e.getMessage());
        } finally {
            try { if (rs   != null) rs.close();   } catch (SQLException ex) {}
            try { if (stmt != null) stmt.close();  } catch (SQLException ex) {}
            try { if (conn != null) conn.close();  } catch (SQLException ex) {}
        }

        return datos;
    }
}
