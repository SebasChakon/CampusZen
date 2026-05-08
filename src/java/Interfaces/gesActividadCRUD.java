package Interfaces;

import java.util.List;
import modelo.GesActividad;

public interface gesActividadCRUD {
    public int agregar(GesActividad g);
    public int actualizar(GesActividad g);
    public int eliminar(int id);
    public GesActividad buscarPorId(int id);
    public List<GesActividad> listar();
}
