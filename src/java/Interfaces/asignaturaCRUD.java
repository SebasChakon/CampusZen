/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Interfaces;
import modelo.Asignatura;
import java.util.List;

/**
 *
 * @author sebas
 */
public interface asignaturaCRUD {
    public int agregar(Asignatura a);
    public int actualizar(Asignatura a);
    public int eliminar(int id);
    public int asignarProfesor(int idAsignatura, int idDocente);
    public Asignatura buscarPorId(int id);
    public List<Asignatura> listar();
}
