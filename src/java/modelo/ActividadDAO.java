package modelo;
import modelo.Actividad;
import Interfaces.actividadCRUD;
import config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ActividadDAO implements actividadCRUD {
    
    @Override
    public int agregar(Actividad a) {
        Conexion cn = new Conexion();
        int status = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO Actividad (nombre, descripcion, fecha_limite, id_asignatura, id_usuario_creador, id_estado) " +
                "VALUES (?, ?, ?, ?, ?, 1)"
            );
            ps.setString(1, a.getNombre());
            ps.setString(2, a.getDescripcion());
            ps.setString(3, a.getFecha_limite());
            ps.setInt(4, a.getId_asignatura());
            ps.setInt(5, a.getId_usuario_creador());
            status = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR agregar Actividad: " + ex.getMessage());
        }
        return status;
    }

    public int actualizar(Actividad a) {
        Conexion cn = new Conexion();
        int status = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE Actividad SET nombre=?, descripcion=?, fecha_limite=?, id_asignatura=? WHERE id_actividad=?"
            );
            ps.setString(1, a.getNombre());
            ps.setString(2, a.getDescripcion());
            ps.setString(3, a.getFecha_limite());
            ps.setInt(4, a.getId_asignatura());
            ps.setInt(5, a.getId_actividad());
            status = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR actualizar Actividad: " + ex.getMessage());
        }
        return status;
    }

    public int eliminar(int id) {
        Conexion cn = new Conexion();
        int status = 0;
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "UPDATE Actividad SET id_estado=0 WHERE id_actividad=?"
            );
            ps.setInt(1, id);
            status = ps.executeUpdate();
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR eliminar Actividad: " + ex.getMessage());
        }
        return status;
    }

    public Actividad buscarPorId(int id) {
        Actividad a = new Actividad();
        Conexion cn = new Conexion();
        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM Actividad WHERE id_actividad=?"
            );
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                a.setId_actividad(rs.getInt("id_actividad"));
                a.setNombre(rs.getString("nombre"));
                a.setDescripcion(rs.getString("descripcion"));
                a.setFecha_limite(rs.getString("fecha_limite"));
                a.setId_asignatura(rs.getInt("id_asignatura"));
                a.setId_usuario_creador(rs.getInt("id_usuario_creador"));
                a.setId_estado(rs.getInt("id_estado"));
            }
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR buscarPorId Actividad: " + ex.getMessage());
        }
        return a;
    }

    public List<Actividad> listar() {
        List<Actividad> lista = new ArrayList<>();
        Conexion cn = new Conexion();

        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM Actividad WHERE id_estado = 1 ORDER BY nombre"
            );
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Actividad a = new Actividad();
                a.setId_actividad(rs.getInt("id_actividad"));
                a.setNombre(rs.getString("nombre"));
                a.setDescripcion(rs.getString("descripcion"));
                a.setFecha_limite(rs.getString("fecha_limite"));
                a.setId_asignatura(rs.getInt("id_asignatura"));
                a.setId_usuario_creador(rs.getInt("id_usuario_creador"));
                a.setId_estado(rs.getInt("id_estado"));

                lista.add(a);
            }

            con.close();

        } catch (SQLException ex) {
            System.out.println("ERROR listar Actividad: " + ex.getMessage());
        }

        return lista;
    }

    public List<Actividad> listarPorAsignatura(int idAsignatura) {
        List<Actividad> lista = new ArrayList<>();
        Conexion cn = new Conexion();

        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM Actividad WHERE id_asignatura = ? AND id_estado = 1 ORDER BY nombre"
            );
            ps.setInt(1, idAsignatura);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Actividad a = new Actividad();
                a.setId_actividad(rs.getInt("id_actividad"));
                a.setNombre(rs.getString("nombre"));
                a.setDescripcion(rs.getString("descripcion"));
                a.setFecha_limite(rs.getString("fecha_limite"));
                a.setId_asignatura(rs.getInt("id_asignatura"));
                a.setId_usuario_creador(rs.getInt("id_usuario_creador"));
                a.setId_estado(rs.getInt("id_estado"));

                lista.add(a);
            }

            con.close();

        } catch (SQLException ex) {
            System.out.println("ERROR listarPorAsignatura Actividad: " + ex.getMessage());
        }

        return lista;
    }

    public List<Actividad> listarPorUsuario(int idUsuario) {
        List<Actividad> lista = new ArrayList<>();
        Conexion cn = new Conexion();

        try {
            Connection con = cn.crearConexion();
            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM Actividad WHERE id_estado = 1 " +
                "AND (id_usuario_creador = ? OR id_actividad IN (" +
                "SELECT id_actividad FROM Tareas WHERE id_usuario_asignado = ? AND id_estado = 1)) " +
                "ORDER BY fecha_limite"
            );
            ps.setInt(1, idUsuario);
            ps.setInt(2, idUsuario);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Actividad a = new Actividad();
                a.setId_actividad(rs.getInt("id_actividad"));
                a.setNombre(rs.getString("nombre"));
                a.setDescripcion(rs.getString("descripcion"));
                a.setFecha_limite(rs.getString("fecha_limite"));
                a.setId_asignatura(rs.getInt("id_asignatura"));
                a.setId_usuario_creador(rs.getInt("id_usuario_creador"));
                a.setId_estado(rs.getInt("id_estado"));

                lista.add(a);
            }

            con.close();

        } catch (SQLException ex) {
            System.out.println("ERROR listarPorUsuario Actividad: " + ex.getMessage());
        }

        return lista;
    }
}