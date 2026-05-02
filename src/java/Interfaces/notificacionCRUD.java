/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Interface.java to edit this template
 */
package Interfaces;
import java.util.List;
import modelo.Notificacion;

/**
 *
 * @author sebas
 */
public interface notificacionCRUD {
    public int agregar(Notificacion n);
    public int marcarLeida(int id);
    public int marcarTodasLeidas(int idUsuario);
    public List<Notificacion> listarPorUsuario(int idUsuario);
    public int contarNoLeidas(int idUsuario);
}
