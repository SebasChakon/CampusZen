/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Interfaces;

import modelo.Tarea;

import java.util.List;

/**
 *
 * @author sebas
 */
public interface tareasCRUD {
    public int agregar(Tarea t);
    public int actualizar(Tarea t);
    public int eliminar(int id);
    public Tarea buscarPorId(int id);
    public List<Tarea> listar();
    public List<Tarea> listarPorUsuario(int idUsuario);
    public List<Tarea> listarPendientesPorUsuario(int idUsuario);
}
