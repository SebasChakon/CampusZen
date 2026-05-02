package modelo;

import Interfaces.actividadesCRUD;
import config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ActividadesDAO implements actividadesCRUD {

    @Override
    public int agregarActividad(Actividades a) {
        Conexion cn = new Conexion();
        Connection con;
        PreparedStatement ps;
        int estatus = 0;
        try {
            con = cn.crearConexion();
            String q = "INSERT INTO actividades (nom_actividad, enlace, id_estado) VALUES (?,?,1)";
            ps = con.prepareStatement(q);
            ps.setString(1, a.getNom_actividad());
            ps.setString(2, a.getEnlace());
            estatus = ps.executeUpdate();
            System.out.println("ACTIVIDAD GUARDADA");
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR AL AGREGAR ACTIVIDAD: " + ex.getMessage());
        }
        return estatus;
    }

    @Override
    public int actualizarActividad(Actividades a) {
        Conexion cn = new Conexion();
        Connection con;
        PreparedStatement ps;
        int estatus = 0;
        try {
            con = cn.crearConexion();
            String q = "UPDATE actividades SET nom_actividad=?, enlace=? WHERE id_actividad=?";
            ps = con.prepareStatement(q);
            ps.setString(1, a.getNom_actividad());
            ps.setString(2, a.getEnlace());
            ps.setInt(3, a.getId_actividad());
            estatus = ps.executeUpdate();
            System.out.println("ACTIVIDAD ACTUALIZADA");
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR AL ACTUALIZAR ACTIVIDAD: " + ex.getMessage());
        }
        return estatus;
    }

    @Override
    public int eliminarActividad(int id) {
        Conexion cn = new Conexion();
        Connection con;
        PreparedStatement ps;
        int estatus = 0;
        try {
            con = cn.crearConexion();
            String q = "UPDATE actividades SET id_estado = 0 WHERE id_actividad = ?";
            ps = con.prepareStatement(q);
            ps.setInt(1, id);
            estatus = ps.executeUpdate();
            System.out.println("ACTIVIDAD DESHABILITADA");
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR AL DESHABILITAR ACTIVIDAD: " + ex.getMessage());
        }
        return estatus;
    }

    public List<Actividades> listadoActividades() {
        List<Actividades> lista = new ArrayList<>();
        Conexion cn = new Conexion();
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        try {
            con = cn.crearConexion();
            ps = con.prepareStatement("SELECT * FROM actividades WHERE id_estado = 1 ORDER BY id_actividad");
            rs = ps.executeQuery();
            while (rs.next()) {
                Actividades a = new Actividades();
                a.setId_actividad(rs.getInt("id_actividad"));
                a.setNom_actividad(rs.getString("nom_actividad"));
                a.setEnlace(rs.getString("enlace"));
                lista.add(a);
            }
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR AL LISTAR ACTIVIDADES: " + ex.getMessage());
        }
        return lista;
    }

    @Override
    public Actividades listadoDatos_Id(int id) {
        Conexion cn = new Conexion();
        Actividades a = null;
        Connection con;
        PreparedStatement ps;
        ResultSet rs;
        try {
            con = cn.crearConexion();
            String q = "SELECT * FROM actividades WHERE id_actividad = ?";
            ps = con.prepareStatement(q);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                a = new Actividades();
                a.setId_actividad(rs.getInt("id_actividad"));
                a.setNom_actividad(rs.getString("nom_actividad"));
                a.setEnlace(rs.getString("enlace"));
            }
            con.close();
        } catch (SQLException ex) {
            System.out.println("ERROR AL BUSCAR ACTIVIDAD: " + ex.getMessage());
        }
        return a;
    }
}
