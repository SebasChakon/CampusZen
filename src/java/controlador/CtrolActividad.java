package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Actividad;
import modelo.ActividadDAO;
import java.io.IOException;

public class CtrolActividad extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");
        if (accion == null || accion.trim().isEmpty()) {
            response.sendRedirect("listaActividad.jsp");
            return;
        }

        ActividadDAO dao = new ActividadDAO();

        if (accion.equals("agregar")) {
            Actividad a = new Actividad();
            a.setNombre(request.getParameter("cnombre"));
            a.setDescripcion(request.getParameter("cdescripcion"));
            a.setFecha_limite(request.getParameter("cfecha_limite"));
            a.setId_asignatura(Integer.parseInt(request.getParameter("cid_asignatura")));
            a.setId_usuario_creador(Integer.parseInt((String) request.getSession().getAttribute("identificacion")));
            int status = dao.agregar(a);
            if (status > 0) response.sendRedirect("listaActividad.jsp");

        } else if (accion.equals("editar")) {
            Actividad a = new Actividad();
            a.setId_actividad(Integer.parseInt(request.getParameter("cid_actividad")));
            a.setNombre(request.getParameter("cnombre"));
            a.setDescripcion(request.getParameter("cdescripcion"));
            a.setFecha_limite(request.getParameter("cfecha_limite"));
            a.setId_asignatura(Integer.parseInt(request.getParameter("cid_asignatura")));
            int status = dao.actualizar(a);
            if (status > 0) response.sendRedirect("listaActividad.jsp");

        } else if (accion.equals("eliminar")) {
            int status = dao.eliminar(Integer.parseInt(request.getParameter("id")));
            if (status > 0) response.sendRedirect("listaActividad.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }
}