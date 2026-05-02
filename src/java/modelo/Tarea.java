/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author sebas
 */
public class Tarea {
    int id_tarea;
    String nombre;
    String descripcion;
    String fecha_limite;
    String prioridad;
    String estado;
    int id_actividad;
    int id_usuario_asignado;
    String observaciones;
    int id_estado;

    public Tarea(int id_tarea, String nombre, String descripcion, String fecha_limite, String prioridad, String estado, int id_actividad, int id_usuario_asignado, String observaciones, int id_estado) {
        this.id_tarea = id_tarea;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.fecha_limite = fecha_limite;
        this.prioridad = prioridad;
        this.estado = estado;
        this.id_actividad = id_actividad;
        this.id_usuario_asignado = id_usuario_asignado;
        this.observaciones = observaciones;
        this.id_estado = id_estado;
    }

    public Tarea() {
    }

    public int getId_tarea() {
        return id_tarea;
    }

    public void setId_tarea(int id_tarea) {
        this.id_tarea = id_tarea;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public String getFecha_limite() {
        return fecha_limite;
    }

    public void setFecha_limite(String fecha_limite) {
        this.fecha_limite = fecha_limite;
    }

    public String getPrioridad() {
        return prioridad;
    }

    public void setPrioridad(String prioridad) {
        this.prioridad = prioridad;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public int getId_actividad() {
        return id_actividad;
    }

    public void setId_actividad(int id_actividad) {
        this.id_actividad = id_actividad;
    }

    public int getId_usuario_asignado() {
        return id_usuario_asignado;
    }

    public void setId_usuario_asignado(int id_usuario_asignado) {
        this.id_usuario_asignado = id_usuario_asignado;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public int getId_estado() {
        return id_estado;
    }

    public void setId_estado(int id_estado) {
        this.id_estado = id_estado;
    }
}
