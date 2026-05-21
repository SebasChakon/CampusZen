package modelo;

import Interfaces.gesActividadCRUD;
import config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class GesActividadDAO {

    public int agregar(GesActividad g) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO GesActividad (id_perfil, id_actividad, id_estado) VALUES (?,?,1)");
            ps.setInt(1, g.getId_perfil());
            ps.setInt(2, g.getId_actividad());
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR agregar GesActividad: " + ex.getMessage()); }
        return estatus;
    }

    public int actualizar(GesActividad g) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE GesActividad SET id_perfil=?, id_actividad=? WHERE idgesActividad=?");
            ps.setInt(1, g.getId_perfil());
            ps.setInt(2, g.getId_actividad());
            ps.setInt(3, g.getIdgesActividad());
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR actualizar GesActividad: " + ex.getMessage()); }
        return estatus;
    }

    public int eliminar(int id) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE GesActividad SET id_estado = 0 WHERE idgesActividad = ?");
            ps.setInt(1, id);
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR eliminar GesActividad: " + ex.getMessage()); }
        return estatus;
    }

    public GesActividad buscarPorId(int id) {
        Conexion cn = new Conexion();
        GesActividad g = null;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM GesActividad WHERE idgesActividad = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) g = mapear(rs);
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR buscar GesActividad: " + ex.getMessage()); }
        return g;
    }

    public List<GesActividad> listar() {
        List<GesActividad> lista = new ArrayList<>();
        Conexion cn = new Conexion();
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM GesActividad WHERE id_estado = 1 ORDER BY id_perfil, id_actividad");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) lista.add(mapear(rs));
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR listar GesActividad: " + ex.getMessage()); }
        return lista;
    }

    private GesActividad mapear(ResultSet rs) throws SQLException {
        GesActividad g = new GesActividad();
        g.setIdgesActividad(rs.getInt("idgesActividad"));
        g.setId_perfil(rs.getInt("id_perfil"));
        g.setId_actividad(rs.getInt("id_actividad"));
        g.setId_estado(rs.getInt("id_estado"));
        return g;
    }
}