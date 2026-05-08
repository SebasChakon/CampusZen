<%@page import="modelo.Tarea, modelo.TareaDAO, modelo.Horario, modelo.HorarioDAO, modelo.Actividad, modelo.ActividadDAO"%>
<%@page import="config.Conexion, java.sql.*, java.util.*, java.text.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nUsuario = (String) session.getAttribute("nUsuario");
    if (nUsuario == null) { response.sendRedirect("login.jsp"); return; }

    int idUsuario = 0;
    int idPerfil  = 0;
    try {
        Conexion cn = new Conexion();
        Connection con = cn.crearConexion();
        PreparedStatement ps = con.prepareStatement(
            "SELECT identificacion, id_perfil FROM Usuario WHERE usuario = ?");
        ps.setString(1, nUsuario);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            idUsuario = rs.getInt("identificacion");
            idPerfil  = rs.getInt("id_perfil");
        }
        con.close();
    } catch (Exception e) { e.printStackTrace(); }

    Calendar hoy   = Calendar.getInstance();
    int anioActual = hoy.get(Calendar.YEAR);
    int mesActual  = hoy.get(Calendar.MONTH) + 1; 

    int anio = request.getParameter("anio") != null
               ? Integer.parseInt(request.getParameter("anio")) : anioActual;
    int mes  = request.getParameter("mes")  != null
               ? Integer.parseInt(request.getParameter("mes"))  : mesActual;

    int mesSig = mes == 12 ? 1 : mes + 1;
    int anioSig = mes == 12 ? anio + 1 : anio;
    int mesAnt = mes == 1 ? 12 : mes - 1;
    int anioAnt = mes == 1 ? anio - 1 : anio;

    Calendar cal = Calendar.getInstance();
    cal.set(anio, mes - 1, 1);
    int primerDiaSemana = cal.get(Calendar.DAY_OF_WEEK); 
    int diasEnMes = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

    TareaDAO tareaDAO = new TareaDAO();
    List<Tarea> tareasUsuario = tareaDAO.listarPorUsuario(idUsuario);

    Map<Integer, List<Tarea>> tareasPorDia = new HashMap<>();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    for (Tarea t : tareasUsuario) {
        if (t.getFecha_limite() != null) {
            String fl = t.getFecha_limite().toString().substring(0, 10);
            String[] partes = fl.split("-");
            if (partes.length == 3) {
                int ta = Integer.parseInt(partes[0]);
                int tm = Integer.parseInt(partes[1]);
                int td = Integer.parseInt(partes[2]);
                if (ta == anio && tm == mes) {
                    tareasPorDia.computeIfAbsent(td, k -> new ArrayList<>()).add(t);
                }
            }
        }
    }

    ActividadDAO actividadDAO = new ActividadDAO();
    List<Actividad> actividadesUsuario = actividadDAO.listarPorUsuario(idUsuario);
    Map<Integer, List<Actividad>> actividadesPorDia = new HashMap<>();
    for (Actividad act : actividadesUsuario) {
        if (act.getFecha_limite() != null) {
            String fl = act.getFecha_limite().toString().substring(0, 10);
            String[] partes = fl.split("-");
            if (partes.length == 3) {
                int ta = Integer.parseInt(partes[0]);
                int tm = Integer.parseInt(partes[1]);
                int td = Integer.parseInt(partes[2]);
                if (ta == anio && tm == mes) {
                    actividadesPorDia.computeIfAbsent(td, k -> new ArrayList<>()).add(act);
                }
            }
        }
    }

    HorarioDAO horarioDAO = new HorarioDAO();
    List<Horario> horarios = new ArrayList<>();
    if (idPerfil == 2) {
        horarios = horarioDAO.listarPorDocente(idUsuario);
    }
    if (horarios.isEmpty()) {
        horarios = horarioDAO.listar();
    }
    Map<String, List<Horario>> horariosPorDia = new HashMap<>();
    for (Horario h : horarios) {
        horariosPorDia.computeIfAbsent(h.getDia_semana(), k -> new ArrayList<>()).add(h);
    }

    String[] DIAS_SEMANA = {"Dom","Lun","Mar","Mié","Jue","Vie","Sáb"};
    String[] MESES_ESP   = {"","Enero","Febrero","Marzo","Abril","Mayo","Junio",
                             "Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"};

    String[] diasNombre = {"Domingo","Lunes","Martes","Miércoles","Jueves","Viernes","Sábado"};
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Calendario</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="icon" type="image/png" href="img/icono.png">
    <style>
        body { font-family: Arial, sans-serif; padding: 16px; }
        h2   { color: #2c3e50; }
        .nav { display: flex; align-items: center; gap: 16px; margin-bottom: 12px; }
        .nav a { text-decoration: none; font-weight: bold; color: #2980b9; }
        table.cal { width: 100%; border-collapse: collapse; }
        table.cal th { background: #2c3e50; color: #fff; padding: 8px; text-align: center; }
        table.cal td { border: 1px solid #ccc; vertical-align: top; width: 14.28%;
                       min-height: 120px; padding: 4px; font-size: 12px; height: auto; overflow: visible; }
        .num-dia { font-weight: bold; font-size: 14px; color: #2c3e50; }
        .hoy-cell { background: #eaf4fb; }
        .tarea-alta   { background: #fdecea; border-left: 3px solid #e74c3c;
                        margin: 2px 0; padding: 2px 4px; border-radius: 3px; display: block; }
        .tarea-media  { background: #fef9e7; border-left: 3px solid #f39c12;
                        margin: 2px 0; padding: 2px 4px; border-radius: 3px; display: block; }
        .tarea-baja   { background: #eafaf1; border-left: 3px solid #27ae60;
                        margin: 2px 0; padding: 2px 4px; border-radius: 3px; display: block; }
        .horario-item { background: #ebf5fb; border-left: 3px solid #2980b9;
                        margin: 2px 0; padding: 4px 6px; border-radius: 3px; display: block; }
        .actividad-item { background: #eef2ff; border-left: 3px solid #9900ff;
                          margin: 2px 0; padding: 4px 6px; border-radius: 3px; display: block; }
        .event-list { display: block; margin-top: 6px; overflow: visible; min-height: auto; }
        .event-row { display: block; margin-bottom: 4px; white-space: normal; }
        .event-label { font-weight: bold; margin-right: 4px; }
        .leyenda { display: flex; gap: 16px; margin-bottom: 10px; font-size: 12px; }
        .leyenda span { padding: 3px 8px; border-radius: 3px; }
    </style>
</head>
<body>
    <h2>Calendario — <%=MESES_ESP[mes]%> <%=anio%></h2>

    <div class="nav">
        <a href="calendario.jsp?mes=<%=mesAnt%>&anio=<%=anioAnt%>">&larr; Mes anterior</a>
        <a href="calendario.jsp">Hoy</a>
        <a href="calendario.jsp?mes=<%=mesSig%>&anio=<%=anioSig%>">Mes siguiente &rarr;</a>
    </div>

    <div class="leyenda">
        <span class="tarea-alta">Tarea Alta</span>
        <span class="tarea-media">Tarea Media</span>
        <span class="tarea-baja">Tarea Baja</span>
        <span class="horario-item">Horario</span>
        <span class="actividad-item">Actividad</span>
    </div>

    <table class="cal">
        <tr>
            <% for (String d : DIAS_SEMANA) { %>
            <th><%=d%></th>
            <% } %>
        </tr>
        <%
            int diaActual = 1;
            boolean iniciado = false;
            
            while (diaActual <= diasEnMes) {
                out.println("<tr>");
                for (int col = 1; col <= 7; col++) {
                    if (!iniciado && col < primerDiaSemana) {
                        out.println("<td></td>");
                    } else if (diaActual > diasEnMes) {
                        out.println("<td></td>");
                    } else {
                        iniciado = true;
                        boolean esHoy = (diaActual == hoy.get(Calendar.DAY_OF_MONTH)
                                         && mes == mesActual && anio == anioActual);
                        out.println("<td class='" + (esHoy ? "hoy-cell" : "") + "'>");
                        out.println("<div class='num-dia'>" + diaActual + "</div>");
                        out.println("<div class='event-list'>");

                        String diaNombreActual = diasNombre[col - 1]; 
                        List<Horario> hsDelDia = horariosPorDia.get(diaNombreActual);
                        if (hsDelDia != null) {
                            for (Horario h : hsDelDia) {
                                out.println("<div class='event-row horario-item'><span class='event-label'>Horario:</span> " +
                                    h.getHora_inicio() + " Asig." + h.getId_asignatura() +
                                    " Sal." + h.getSalon() + "</div>");
                            }
                        }

                        List<Tarea> tsDelDia = tareasPorDia.get(diaActual);
                        if (tsDelDia != null) {
                            for (Tarea t : tsDelDia) {
                                String cls = "tarea-" + (t.getPrioridad() != null ? t.getPrioridad() : "media");
                                out.println("<div class='event-row " + cls + "'><span class='event-label'>Tarea:</span> " +
                                    t.getNombre() + " [" + t.getEstado() + "]</div>");
                            }
                        }

                        List<Actividad> actsDelDia = actividadesPorDia.get(diaActual);
                        if (actsDelDia != null) {
                            for (Actividad act : actsDelDia) {
                                out.println("<div class='event-row actividad-item'><span class='event-label'>Actividad:</span> " +
                                    act.getNombre() + "</div>");
                            }
                        }
                        out.println("</div>");
                        out.println("</td>");
                        diaActual++;
                    }
                }
                out.println("</tr>");
            }
        %>
    </table>
</body>
</html>
