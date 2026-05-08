package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import modelo.Horario;
import modelo.HorarioDAO;
import java.io.IOException;

public class CtrolHorario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String accion = request.getParameter("accion");
        HorarioDAO dao = new HorarioDAO();

        if ("agregar".equals(accion)) {
            if (dao.agregar(buildHorario(request)) > 0)
                response.sendRedirect("listaHorarios.jsp");

        } else if ("editar".equals(accion)) {
            Horario h = buildHorario(request);
            h.setId_horario(Integer.parseInt(request.getParameter("cid_horario")));
            if (dao.actualizar(h) > 0) response.sendRedirect("listaHorarios.jsp");

        } else if ("eliminar".equals(accion)) {
            if (dao.eliminar(Integer.parseInt(request.getParameter("id"))) > 0)
                response.sendRedirect("listaHorarios.jsp");
        }
    }

    private Horario buildHorario(HttpServletRequest request) {
        Horario h = new Horario();
        h.setId_asignatura(Integer.parseInt(request.getParameter("cid_asignatura")));
        h.setId_profesor(Integer.parseInt(request.getParameter("cid_docente")));
        h.setDia_semana(request.getParameter("cdia_semana"));
        h.setHora_inicio(request.getParameter("chora_inicio"));
        h.setHora_fin(request.getParameter("chora_fin"));
        h.setSalon(request.getParameter("csalon"));
        return h;
    }

    @Override protected void doGet(HttpServletRequest rq, HttpServletResponse rs)
            throws ServletException, IOException { processRequest(rq, rs); }
    @Override protected void doPost(HttpServletRequest rq, HttpServletResponse rs)
            throws ServletException, IOException { processRequest(rq, rs); }
}
