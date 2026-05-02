package modelo;

import Interfaces.asignaturaCRUD;
import config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AsignaturaDAO implements asignaturaCRUD {

    public int agregar(Asignatura a) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO Asignatura (nombre, descripcion, creditos, id_estado) VALUES (?,?,?,1)");
            ps.setString(1, a.getNombre());
            ps.setString(2, a.getDescripcion());
            ps.setInt(3, a.getCreditos());
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR agregar Asignatura: " + ex.getMessage()); }
        return estatus;
    }

    public int actualizar(Asignatura a) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE Asignatura SET nombre=?, descripcion=?, creditos=? WHERE id_asignatura=?");
            ps.setString(1, a.getNombre());
            ps.setString(2, a.getDescripcion());
            ps.setInt(3, a.getCreditos());
            ps.setInt(4, a.getId_asignatura());
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR actualizar Asignatura: " + ex.getMessage()); }
        return estatus;
    }

    public int eliminar(int id) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE Asignatura SET id_estado = 0 WHERE id_asignatura = ?");
            ps.setInt(1, id);
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR eliminar Asignatura: " + ex.getMessage()); }
        return estatus;
    }

    // ── Asignar / reasignar / desasignar profesor ────────────────────────────
    public int asignarProfesor(int idAsignatura, int idProfesor) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE Asignatura SET id_profesor = ? WHERE id_asignatura = ?");
            ps.setInt(1, idProfesor);   // 0 = desasignar
            ps.setInt(2, idAsignatura);
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR asignarProfesor: " + ex.getMessage()); }
        return estatus;
    }

    public Asignatura buscarPorId(int id) {
        Conexion cn = new Conexion();
        Asignatura a = null;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Asignatura WHERE id_asignatura = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) a = mapear(rs);
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR buscar Asignatura: " + ex.getMessage()); }
        return a;
    }

    public List<Asignatura> listar() {
        List<Asignatura> lista = new ArrayList<>();
        Conexion cn = new Conexion();
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM Asignatura WHERE id_estado = 1 ORDER BY nombre");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) lista.add(mapear(rs));
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR listar Asignatura: " + ex.getMessage()); }
        return lista;
    }

    private Asignatura mapear(ResultSet rs) throws SQLException {
        Asignatura a = new Asignatura();
        a.setId_asignatura(rs.getInt("id_asignatura"));
        a.setNombre(rs.getString("nombre"));
        a.setDescripcion(rs.getString("descripcion"));
        a.setCreditos(rs.getInt("creditos"));
        a.setId_profesor(rs.getInt("id_profesor"));
        a.setId_estado(rs.getInt("id_estado"));
        return a;
    }
}
