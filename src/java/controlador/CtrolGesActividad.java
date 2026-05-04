package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.GesActividad;
import modelo.GesActividadDAO;
import java.io.IOException;

public class CtrolGesActividad extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");
        GesActividadDAO dao = new GesActividadDAO();

        if ("agregar".equals(accion)) {
            GesActividad g = new GesActividad();
            g.setId_perfil(Integer.parseInt(request.getParameter("cid_perfil")));
            g.setId_actividad(Integer.parseInt(request.getParameter("cid_actividad")));
            if (dao.agregar(g) > 0) response.sendRedirect("listaGesActividad.jsp");

        } else if ("editar".equals(accion)) {
            GesActividad g = new GesActividad();
            g.setIdgesActividad(Integer.parseInt(request.getParameter("cidgesActividad")));
            g.setId_perfil(Integer.parseInt(request.getParameter("cid_perfil")));
            g.setId_actividad(Integer.parseInt(request.getParameter("cid_actividad")));
            if (dao.actualizar(g) > 0) response.sendRedirect("listaGesActividad.jsp");

        } else if ("eliminar".equals(accion)) {
            if (dao.eliminar(Integer.parseInt(request.getParameter("id"))) > 0)
                response.sendRedirect("listaGesActividad.jsp");
        }
    }

    @Override protected void doGet(HttpServletRequest rq, HttpServletResponse rs)
            throws ServletException, IOException { processRequest(rq, rs); }
    @Override protected void doPost(HttpServletRequest rq, HttpServletResponse rs)
            throws ServletException, IOException { processRequest(rq, rs); }
}
