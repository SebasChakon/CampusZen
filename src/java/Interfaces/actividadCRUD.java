/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Interfaces;
import java.util.List;
import modelo.Actividad;

/**
 *
 * @author sebas
 */
public interface actividadCRUD {
    public int agregar(Actividad a);
    public int actualizar(Actividad a);
    public int eliminar(int id);
    public Actividad buscarPorId(int id);
    public List<Actividad> listar();
    public List<Actividad> listarPorAsignatura(int idAsignatura);
    public List<Actividad> listarPorUsuario(int idUsuario);
}
