/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Interfaces;
import java.util.List;
import modelo.Horario;

/**
 *
 * @author sebas
 */
public interface horarioCRUD {
    public int agregar(Horario h);
    public int actualizar(Horario h);
    public int eliminar(int id);
    public Horario buscarPorId(int id);
    public List<Horario> listar();
    public List<Horario> listarPorUsuario(int idUsuario);
}
