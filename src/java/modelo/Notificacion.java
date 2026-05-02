/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelo;

/**
 *
 * @author sebas
 */
public class Notificacion {
    int id_notificacion;
    int id_usuario;
    String tipo;
    String titulo;
    String mensaje;
    int leida;
    String url_referencia;
    int id_estado;

    public Notificacion() {
    }

    public Notificacion(int id_notificacion, int id_usuario, String tipo, String titulo, String mensaje, int leida, String url_referencia, int id_estado) {
        this.id_notificacion = id_notificacion;
        this.id_usuario = id_usuario;
        this.tipo = tipo;
        this.titulo = titulo;
        this.mensaje = mensaje;
        this.leida = leida;
        this.url_referencia = url_referencia;
        this.id_estado = id_estado;
    }

    public int getId_notificacion() {
        return id_notificacion;
    }

    public void setId_notificacion(int id_notificacion) {
        this.id_notificacion = id_notificacion;
    }

    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public int getLeida() {
        return leida;
    }

    public void setLeida(int leida) {
        this.leida = leida;
    }

    public String getUrl_referencia() {
        return url_referencia;
    }

    public void setUrl_referencia(String url_referencia) {
        this.url_referencia = url_referencia;
    }

    public int getId_estado() {
        return id_estado;
    }

    public void setId_estado(int id_estado) {
        this.id_estado = id_estado;
    }
}
