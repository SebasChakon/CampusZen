package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Tarea;
import modelo.TareaDAO;
import modelo.Notificacion;
import modelo.NotificacionDAO;
import java.io.IOException;

public class CtrolTareas extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");
        TareaDAO dao = new TareaDAO();

        if ("agregar".equals(accion)) {
            Tarea t = buildTarea(request);
            int idTarea = dao.agregar(t);
            if (idTarea > 0) {
                t.setId_tarea(idTarea);
                if (t.getId_usuario_asignado() > 0) {
                    NotificacionDAO notiDAO = new NotificacionDAO();
                    Notificacion noti = new Notificacion();
                    noti.setId_usuario(t.getId_usuario_asignado());
                    noti.setTipo("Tarea");
                    noti.setTitulo("Nueva tarea asignada");
                    noti.setMensaje("Se te ha asignado la tarea: " + t.getNombre() +
                                   (t.getFecha_limite() != null ? " (Límite: " + t.getFecha_limite() + ")" : ""));
                    noti.setUrl_referencia("listaTareas.jsp?id=" + t.getId_tarea());
                    notiDAO.agregar(noti);
                }
                response.sendRedirect("listaTareas.jsp");
            }

        } else if ("editar".equals(accion)) {
            Tarea t = buildTarea(request);
            t.setId_tarea(Integer.parseInt(request.getParameter("cid_tarea")));
            if (dao.actualizar(t) > 0) response.sendRedirect("listaTareas.jsp");

        } else if ("eliminar".equals(accion)) {
            if (dao.eliminar(Integer.parseInt(request.getParameter("id"))) > 0)
                response.sendRedirect("listaTareas.jsp");

        } else if ("cambiarEstado".equals(accion)) {
            Tarea t = dao.buscarPorId(Integer.parseInt(request.getParameter("id")));
            if (t != null) {
                t.setEstado(request.getParameter("estado"));
                t.setObservaciones(request.getParameter("observaciones") != null
                        ? request.getParameter("observaciones") : t.getObservaciones());
                dao.actualizar(t);
            }
            response.sendRedirect("listaTareas.jsp");
        }
    }

    private Tarea buildTarea(HttpServletRequest request) {
        Tarea t = new Tarea();
        t.setNombre(request.getParameter("cnombre"));
        t.setDescripcion(request.getParameter("cdescripcion"));
        t.setFecha_limite(request.getParameter("cfecha_limite"));
        t.setPrioridad(request.getParameter("cprioridad"));
        t.setEstado(request.getParameter("cestado"));
        t.setObservaciones(request.getParameter("cobservaciones"));
        String idAct = request.getParameter("cid_actividad");
        t.setId_actividad(idAct != null && !idAct.isEmpty() ? Integer.parseInt(idAct) : 0);
        String idUsu = request.getParameter("cid_usuario_asignado");
        t.setId_usuario_asignado(idUsu != null && !idUsu.isEmpty() ? Integer.parseInt(idUsu) : 0);
        return t;
    }

    @Override protected void doGet(HttpServletRequest rq, HttpServletResponse rs)
            throws ServletException, IOException { processRequest(rq, rs); }
    @Override protected void doPost(HttpServletRequest rq, HttpServletResponse rs)
            throws ServletException, IOException { processRequest(rq, rs); }
}
