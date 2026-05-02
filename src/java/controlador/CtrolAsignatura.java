package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Asignatura;
import modelo.AsignaturaDAO;
import java.io.IOException;

public class CtrolAsignatura extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");
        AsignaturaDAO dao = new AsignaturaDAO();

        if ("agregar".equals(accion)) {
            if (dao.agregar(buildAsignatura(request)) > 0)
                response.sendRedirect("listaAsignaturas.jsp");

        } else if ("editar".equals(accion)) {
            Asignatura a = buildAsignatura(request);
            a.setId_asignatura(Integer.parseInt(request.getParameter("cid_asignatura")));
            if (dao.actualizar(a) > 0) response.sendRedirect("listaAsignaturas.jsp");

        } else if ("eliminar".equals(accion)) {
            if (dao.eliminar(Integer.parseInt(request.getParameter("id"))) > 0)
                response.sendRedirect("listaAsignaturas.jsp");

        } else if ("asignarProfesor".equals(accion)) {
            int idAsignatura = Integer.parseInt(request.getParameter("cid_asignatura"));
            // id_profesor = 0 significa desasignar
            String idProfStr = request.getParameter("cid_profesor");
            int idProfesor = (idProfStr != null && !idProfStr.isEmpty()) ? Integer.parseInt(idProfStr) : 0;
            if (dao.asignarProfesor(idAsignatura, idProfesor) > 0)
                response.sendRedirect("listaAsignaturas.jsp");
        }
    }

    private Asignatura buildAsignatura(HttpServletRequest request) {
        Asignatura a = new Asignatura();
        a.setNombre(request.getParameter("cnombre"));
        a.setDescripcion(request.getParameter("cdescripcion"));
        String cred = request.getParameter("ccreditos");
        a.setCreditos(cred != null && !cred.isEmpty() ? Integer.parseInt(cred) : 3);
        return a;
    }

    @Override protected void doGet(HttpServletRequest rq, HttpServletResponse rs)
            throws ServletException, IOException { processRequest(rq, rs); }
    @Override protected void doPost(HttpServletRequest rq, HttpServletResponse rs)
            throws ServletException, IOException { processRequest(rq, rs); }
}
