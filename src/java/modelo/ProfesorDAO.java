/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;
import Interfaces.profesorCRUD;
import java.util.List;
import modelo.Profesor;
import config.Conexion;
import java.sql.*;
import java.util.ArrayList;


/**
 *
 * @author sebas
 */
public class ProfesorDAO implements profesorCRUD {
    
    public List<Profesor> listar() {
    List<Profesor> lista = new ArrayList<>();
    Conexion cn = new Conexion();

    try {
        Connection con = cn.crearConexion();
        PreparedStatement ps = con.prepareStatement(
            "SELECT * FROM Profesor WHERE id_estado = 1"
        );

        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Profesor p = new Profesor();
            p.setId_profesor(rs.getInt("id_profesor"));
            p.setIdentificacion(rs.getInt("identificacion"));
            p.setEspecialidad(rs.getString("especialidad"));
            p.setDepartamento(rs.getString("departamento"));
            p.setId_estado(rs.getInt("id_estado"));

            lista.add(p);
        }

        con.close();

    } catch (SQLException ex) {
        System.out.println("ERROR listar Profesor: " + ex.getMessage());
    }

    return lista;
}
    
}
