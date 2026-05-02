package modelo;

import Interfaces.horarioCRUD;
import config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class HorarioDAO implements horarioCRUD{

    @Override
    public int agregar(Horario h) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO Horario (id_asignatura, id_profesor, dia_semana, hora_inicio, hora_fin, salon, id_estado) " +
                "VALUES (?,?,?,?,?,?,1)");
            ps.setInt(1, h.getId_asignatura());
            ps.setInt(2, h.getId_profesor());
            ps.setString(3, h.getDia_semana());
            ps.setString(4, h.getHora_inicio());
            ps.setString(5, h.getHora_fin());
            ps.setString(6, h.getSalon());
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR agregar Horario: " + ex.getMessage()); }
        return estatus;
    }

    @Override
    public int actualizar(Horario h) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE Horario SET id_asignatura=?, id_profesor=?, dia_semana=?, " +
                "hora_inicio=?, hora_fin=?, salon=? WHERE id_horario=?");
            ps.setInt(1, h.getId_asignatura());
            ps.setInt(2, h.getId_profesor());
            ps.setString(3, h.getDia_semana());
            ps.setString(4, h.getHora_inicio());
            ps.setString(5, h.getHora_fin());
            ps.setString(6, h.getSalon());
            ps.setInt(7, h.getId_horario());
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR actualizar Horario: " + ex.getMessage()); }
        return estatus;
    }

    @Override
    public int eliminar(int id) {
        Conexion cn = new Conexion();
        int estatus = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE Horario SET id_estado = 0 WHERE id_horario = ?");
            ps.setInt(1, id);
            estatus = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR eliminar Horario: " + ex.getMessage()); }
        return estatus;
    }

    @Override
    public Horario buscarPorId(int id) {
        Conexion cn = new Conexion();
        Horario h = null;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM Horario WHERE id_horario = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) h = mapear(rs);
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR buscar Horario: " + ex.getMessage()); }
        return h;
    }

    @Override
    public List<Horario> listar() {
        List<Horario> lista = new ArrayList<>();
        Conexion cn = new Conexion();
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM Horario WHERE id_estado = 1 ORDER BY dia_semana, hora_inicio");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) lista.add(mapear(rs));
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR listar Horario: " + ex.getMessage()); }
        return lista;
    }

    // Para el calendario: horarios del usuario (via asignatura del profesor)
    @Override
    public List<Horario> listarPorUsuario(int idUsuario) {
        List<Horario> lista = new ArrayList<>();
        Conexion cn = new Conexion();
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "SELECT h.* FROM Horario h " +
                "JOIN Profesor p ON h.id_profesor = p.id_profesor " +
                "WHERE p.identificacion = ? AND h.id_estado = 1 " +
                "ORDER BY h.dia_semana, h.hora_inicio");
            ps.setInt(1, idUsuario);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) lista.add(mapear(rs));
            con.close();
        } catch (SQLException ex) { System.out.println("ERROR listarPorUsuario Horario: " + ex.getMessage()); }
        return lista;
    }

    private Horario mapear(ResultSet rs) throws SQLException {
        Horario h = new Horario();
        h.setId_horario(rs.getInt("id_horario"));
        h.setId_asignatura(rs.getInt("id_asignatura"));
        h.setId_profesor(rs.getInt("id_profesor"));
        h.setDia_semana(rs.getString("dia_semana"));
        h.setHora_inicio(rs.getString("hora_inicio"));
        h.setHora_fin(rs.getString("hora_fin"));
        h.setSalon(rs.getString("salon"));
        h.setId_estado(rs.getInt("id_estado"));
        return h;
    }
}