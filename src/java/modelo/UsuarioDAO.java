package modelo;

import Interfaces.CRUD;
import config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioDAO implements CRUD {

    @Override
    public int agregarUsuario(Usuario u) {
        Conexion cn = new Conexion();
        Connection con;
        PreparedStatement ps;
        int estatus = 0;
        try {
            con = cn.crearConexion();
            String q = "INSERT INTO Usuario (identificacion, nombre, apellido, email, telefono, usuario, clave, id_perfil, id_estado) VALUES (?,?,?,?,?,?,?,?,1)";
            ps = con.prepareStatement(q);
            ps.setString(1, u.getIdentificacion());
            ps.setString(2, u.getNombre());
            ps.setString(3, u.getApellido());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getTelefono());
            ps.setString(6, u.getUsuario());
            ps.setString(7, u.getClave());
            ps.setInt(8, u.getIdperfil());
            estatus = ps.executeUpdate();
            System.out.println("REGISTRO GUARDADO CORRECTAMENTE");
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR AL REGISTRAR: " + ex.getMessage());
        }
        return estatus;
    }

    // Actualizar sin cambiar identificacion (versión original de la interfaz)
    @Override
    public int actualizarDatos(Usuario u) {
        Conexion cn = new Conexion();
        Connection con;
        PreparedStatement ps;
        int estatus = 0;
        try {
            con = cn.crearConexion();
            String q = "UPDATE Usuario SET nombre=?, apellido=?, email=?, telefono=?, usuario=?, clave=?, id_perfil=? WHERE identificacion=?";
            ps = con.prepareStatement(q);
            ps.setString(1, u.getNombre());
            ps.setString(2, u.getApellido());
            ps.setString(3, u.getEmail());
            ps.setString(4, u.getTelefono());
            ps.setString(5, u.getUsuario());
            ps.setString(6, u.getClave());
            ps.setInt(7, u.getIdperfil());
            ps.setString(8, u.getIdentificacion());
            estatus = ps.executeUpdate();
            System.out.println("REGISTRO ACTUALIZADO");
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR AL ACTUALIZAR: " + ex.getMessage());
        }
        return estatus;
    }

    // Actualizar permitiendo cambio de identificacion:
    // u.getIdentificacion() = nueva identificacion
    // identificacionOriginal = valor actual en BD para el WHERE
    public int actualizarDatos(Usuario u, String identificacionOriginal) {
        Conexion cn = new Conexion();
        Connection con;
        PreparedStatement ps;
        int estatus = 0;
        try {
            con = cn.crearConexion();
            String q = "UPDATE Usuario SET identificacion=?, nombre=?, apellido=?, email=?, " +
                       "telefono=?, usuario=?, clave=?, id_perfil=? WHERE identificacion=?";
            ps = con.prepareStatement(q);
            ps.setString(1, u.getIdentificacion());   // nueva identificacion
            ps.setString(2, u.getNombre());
            ps.setString(3, u.getApellido());
            ps.setString(4, u.getEmail());
            ps.setString(5, u.getTelefono());
            ps.setString(6, u.getUsuario());
            ps.setString(7, u.getClave());
            ps.setInt(8, u.getIdperfil());
            ps.setString(9, identificacionOriginal);  // WHERE con la original
            estatus = ps.executeUpdate();
            System.out.println("REGISTRO ACTUALIZADO");
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR AL ACTUALIZAR: " + ex.getMessage());
        }
        return estatus;
    }

    @Override
    public int eliminarDatos(int id) {
        Conexion cn = new Conexion();
        Connection con;
        PreparedStatement ps;
        int estatus = 0;
        try {
            con = cn.crearConexion();
            String q = "UPDATE Usuario SET id_estado = 0 WHERE identificacion = ?";
            ps = con.prepareStatement(q);
            ps.setInt(1, id);
            estatus = ps.executeUpdate();
            System.out.println("USUARIO DESHABILITADO");
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR AL DESHABILITAR: " + ex.getMessage());
        }
        return estatus;
    }

    public int eliminarDatosPorIdentificacion(String identificacion) {
        Conexion cn = new Conexion();
        Connection con;
        PreparedStatement ps;
        int estatus = 0;
        try {
            con = cn.crearConexion();
            String q = "UPDATE Usuario SET id_estado = 0 WHERE identificacion = ?";
            ps = con.prepareStatement(q);
            ps.setString(1, identificacion);
            estatus = ps.executeUpdate();
            System.out.println("USUARIO DESHABILITADO");
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR AL DESHABILITAR: " + ex.getMessage());
        }
        return estatus;
    }

    public List<Usuario> listadoDatos() {
        List<Usuario> lista = new ArrayList<>();
        Conexion cn = new Conexion();
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        try {
            con = cn.crearConexion();
            String q = "SELECT * FROM Usuario WHERE id_estado = 1";
            ps = con.prepareStatement(q);
            rs = ps.executeQuery();
            while (rs.next()) lista.add(mapear(rs));
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR AL LISTAR: " + ex.getMessage());
        }
        return lista;
    }

    // Requerido por interfaz CRUD
    @Override
    public Usuario listadoDatos_Id(int identificacion) {
        Conexion cn = new Conexion();
        Usuario u = null;
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        try {
            con = cn.crearConexion();
            PreparedStatement ps2 = cn.crearConexion().prepareStatement(
                "SELECT * FROM Usuario WHERE identificacion = ?");
            ps2.setInt(1, identificacion);
            ResultSet rs2 = ps2.executeQuery();
            if (rs2.next()) u = mapear(rs2);
        } catch (SQLException ex) {
            System.out.println("ERROR AL BUSCAR: " + ex.getMessage());
        }
        return u;
    }

    // Versión con String usada por EditarUsuario.jsp y EditarUsuario.java
    public Usuario listadoDatos_Id(String identificacion) {
        Conexion cn = new Conexion();
        Usuario u = null;
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        try {
            con = cn.crearConexion();
            String q = "SELECT * FROM Usuario WHERE identificacion = ?";
            ps = con.prepareStatement(q);
            ps.setString(1, identificacion);
            rs = ps.executeQuery();
            if (rs.next()) u = mapear(rs);
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR AL BUSCAR: " + ex.getMessage());
        }
        return u;
    }

    private Usuario mapear(ResultSet rs) throws SQLException {
        Usuario u = new Usuario();
        u.setIdentificacion(rs.getString("identificacion"));
        u.setNombre(rs.getString("nombre"));
        u.setApellido(rs.getString("apellido"));
        u.setEmail(rs.getString("email"));
        u.setTelefono(rs.getString("telefono"));
        u.setUsuario(rs.getString("usuario"));
        u.setClave(rs.getString("clave"));
        u.setIdperfil(rs.getInt("id_perfil"));
        return u;
    }
}
