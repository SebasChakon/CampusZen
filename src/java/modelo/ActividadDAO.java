/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import modelo.Actividad;
import Interfaces.actividadCRUD;
import config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.Actividad;
        
/**
 *
 * @author sebas
 */
public class ActividadDAO implements actividadCRUD {
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
}
