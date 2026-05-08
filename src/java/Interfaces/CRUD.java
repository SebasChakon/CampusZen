/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Interfaces;

import java.util.List;
import modelo.Usuario;

/**
 *
 * @author sebas
 */
public interface CRUD {
    public int agregarUsuario(Usuario u);
    public int actualizarDatos(Usuario u);
    public int actualizarDatos(Usuario u, String identificacionOriginal);
    public int eliminarDatos(int id);
    public int eliminarDatosPorIdentificacion(String identificacion);
    public List<Usuario> listadoDatos();
    public Usuario listadoDatos_Id(int id);
    public Usuario listadoDatos_Id(String identificacion);
}
