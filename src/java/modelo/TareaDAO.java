package modelo;

import Interfaces.tareasCRUD;
import config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.Tarea;

public class TareaDAO implements tareasCRUD{

    // ── Agregar ──────────────────────────────────────────────────────────────
    @Override
    public int agregar(Tarea t) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            String q = "INSERT INTO Tareas (nombre, descripcion, fecha_limite, prioridad, estado, " +
                       "id_actividad, id_usuario_asignado, observaciones, id_estado) VALUES (?,?,?,?,?,?,?,?,1)";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setString(1, t.getNombre());
            ps.setString(2, t.getDescripcion());
            ps.setString(3, t.getFecha_limite());
            ps.setString(4, t.getPrioridad());
            ps.setString(5, t.getEstado());
            ps.setInt(6, t.getId_actividad());
            ps.setInt(7, t.getId_usuario_asignado());
            ps.setString(8, t.getObservaciones());
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR agregar Tarea: " + ex.getMessage()); }
        return estatus;
    }

    // ── Actualizar ───────────────────────────────────────────────────────────
    @Override
    public int actualizar(Tarea t) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            String q = "UPDATE Tareas SET nombre=?, descripcion=?, fecha_limite=?, prioridad=?, " +
                       "estado=?, id_actividad=?, id_usuario_asignado=?, observaciones=? WHERE id_tarea=?";
            PreparedStatement ps = con.prepareStatement(q);
            ps.setString(1, t.getNombre());
            ps.setString(2, t.getDescripcion());
            ps.setString(3, t.getFecha_limite());
            ps.setString(4, t.getPrioridad());
            ps.setString(5, t.getEstado());
            ps.setInt(6, t.getId_actividad());
            ps.setInt(7, t.getId_usuario_asignado());
            ps.setString(8, t.getObservaciones());
            ps.setInt(9, t.getId_tarea());
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR actualizar Tarea: " + ex.getMessage()); }
        return estatus;
    }

    // ── Soft delete ──────────────────────────────────────────────────────────
    @Override
    public int eliminar(int id) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE Tareas SET id_estado = 0 WHERE id_tarea = ?");
            ps.setInt(1, id);
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR eliminar Tarea: " + ex.getMessage()); }
        return estatus;
    }

    // ── Buscar por ID ────────────────────────────────────────────────────────
    @Override
    public Tarea buscarPorId(int id) {
        Conexion cn = new Conexion();
        Tarea t = null;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM Tareas WHERE id_tarea = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) t = mapear(rs);
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR buscar Tarea: " + ex.getMessage()); }
        return t;
    }

    // ── Listar todas habilitadas ─────────────────────────────────────────────
    @Override
    public List<Tarea> listar() {
        List<Tarea> lista = new ArrayList<>();
        Conexion cn = new Conexion();
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM Tareas WHERE id_estado = 1 ORDER BY fecha_limite");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) lista.add(mapear(rs));
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR listar Tareas: " + ex.getMessage()); }
        return lista;
    }

    // ── Listar por usuario asignado ──────────────────────────────────────────
    @Override
    public List<Tarea> listarPorUsuario(int idUsuario) {
        List<Tarea> lista = new ArrayList<>();
        Conexion cn = new Conexion();
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM Tareas WHERE id_usuario_asignado = ? AND id_estado = 1 ORDER BY fecha_limite");
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) lista.add(mapear(rs));
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR listarPorUsuario Tarea: " + ex.getMessage()); }
        return lista;
    }

    // ── Listar tareas pendientes (para notificaciones) ───────────────────────
    @Override
    public List<Tarea> listarPendientesPorUsuario(int idUsuario) {
        List<Tarea> lista = new ArrayList<>();
        Conexion cn = new Conexion();
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM Tareas WHERE id_usuario_asignado = ? AND id_estado = 1 " +
                "AND estado IN ('pendiente','en progreso') ORDER BY fecha_limite");
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) lista.add(mapear(rs));
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR pendientes Tarea: " + ex.getMessage()); }
        return lista;
    }

    private Tarea mapear(ResultSet rs) throws SQLException {
        Tarea t = new Tarea();
        t.setId_tarea(rs.getInt("id_tarea"));
        t.setNombre(rs.getString("nombre"));
        t.setDescripcion(rs.getString("descripcion"));
        t.setFecha_limite(rs.getString("fecha_limite"));
        t.setPrioridad(rs.getString("prioridad"));
        t.setEstado(rs.getString("estado"));
        t.setId_actividad(rs.getInt("id_actividad"));
        t.setId_usuario_asignado(rs.getInt("id_usuario_asignado"));
        t.setObservaciones(rs.getString("observaciones"));
        t.setId_estado(rs.getInt("id_estado"));
        return t;
    }
}
