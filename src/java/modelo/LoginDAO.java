/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

import config.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// 🔐 IMPORTANTE
import org.mindrot.jbcrypt.BCrypt;

public class LoginDAO {

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs;

    public LoginDAO() {
    }

    public Usuario Login_datos(String usuario, String clave) {

        Usuario datos = null;

        try {
            Conexion cn = new Conexion();
            conn = cn.crearConexion();

            stmt = conn.prepareStatement(
                "SELECT * FROM Usuario WHERE usuario = ?"
            );

            stmt.setString(1, usuario);

            rs = stmt.executeQuery();

            if (rs.next()) {

                String hashBD = rs.getString("clave");

                if (BCrypt.checkpw(clave, hashBD)) {

                    datos = new Usuario();
                    datos.setUsuario(rs.getString("usuario"));
                    datos.setClave(hashBD);
                }
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return datos;
    }
}