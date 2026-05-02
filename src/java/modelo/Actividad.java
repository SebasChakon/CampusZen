/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author sebas
 */
public class Actividad {
    int id_actividad;
    String nombre;
    String descripcion;
    String fecha_limite;
    int id_asignatura;
    int id_usuario_creador;
    int id_estado;

    public Actividad(int id_actividad, String nombre, String descripcion, String fecha_limite, int id_asignatura, int id_usuario_creador, int id_estado) {
        this.id_actividad = id_actividad;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.fecha_limite = fecha_limite;
        this.id_asignatura = id_asignatura;
        this.id_usuario_creador = id_usuario_creador;
        this.id_estado = id_estado;
    }

    public Actividad() {
    }

    public int getId_actividad() {
        return id_actividad;
    }

    public void setId_actividad(int id_actividad) {
        this.id_actividad = id_actividad;
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

    public int getId_asignatura() {
        return id_asignatura;
    }

    public void setId_asignatura(int id_asignatura) {
        this.id_asignatura = id_asignatura;
    }

    public int getId_usuario_creador() {
        return id_usuario_creador;
    }

    public void setId_usuario_creador(int id_usuario_creador) {
        this.id_usuario_creador = id_usuario_creador;
    }

    public int getId_estado() {
        return id_estado;
    }

    public void setId_estado(int id_estado) {
        this.id_estado = id_estado;
    }
}
