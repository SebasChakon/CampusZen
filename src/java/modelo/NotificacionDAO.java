package modelo;

import Interfaces.notificacionCRUD;
import config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NotificacionDAO implements notificacionCRUD {

    @Override
    public int agregar(Notificacion n) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO Notificacion (id_usuario, tipo, titulo, mensaje, leida, url_referencia, id_estado) " +
                "VALUES (?,?,?,?,0,?,1)");
            ps.setInt(1, n.getId_usuario());
            ps.setString(2, n.getTipo());
            ps.setString(3, n.getTitulo());
            ps.setString(4, n.getMensaje());
            ps.setString(5, n.getUrl_referencia());
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR agregar Notificacion: " + ex.getMessage()); }
        return estatus;
    }

    @Override
    public int marcarLeida(int id) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE Notificacion SET leida = 1 WHERE id_notificacion = ?");
            ps.setInt(1, id);
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR marcar leida: " + ex.getMessage()); }
        return estatus;
    }

    @Override
    public int marcarTodasLeidas(int idUsuario) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE Notificacion SET leida = 1 WHERE id_usuario = ?");
            ps.setInt(1, idUsuario);
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR marcar todas leidas: " + ex.getMessage()); }
        return estatus;
    }

    @Override
    public List<Notificacion> listarPorUsuario(int idUsuario) {
        List<Notificacion> lista = new ArrayList<>();
        Conexion cn = new Conexion();
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM Notificacion WHERE id_usuario = ? AND id_estado = 1 " +
                "ORDER BY leida ASC, id_notificacion DESC");
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Notificacion n = new Notificacion();
                n.setId_notificacion(rs.getInt("id_notificacion"));
                n.setId_usuario(rs.getInt("id_usuario"));
                n.setTipo(rs.getString("tipo"));
                n.setTitulo(rs.getString("titulo"));
                n.setMensaje(rs.getString("mensaje"));
                n.setLeida(rs.getInt("leida"));
                n.setUrl_referencia(rs.getString("url_referencia"));
                lista.add(n);
            }
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR listar Notificaciones: " + ex.getMessage()); }
        return lista;
    }

    @Override
    public int contarNoLeidas(int idUsuario) {
        Conexion cn = new Conexion();
        int count = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "SELECT COUNT(*) FROM Notificacion WHERE id_usuario = ? AND leida = 0 AND id_estado = 1");
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) count = rs.getInt(1);
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR contar noLeidas: " + ex.getMessage()); }
        return count;
    }
}
