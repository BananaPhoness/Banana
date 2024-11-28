package Controlador;

import Modelo.Citas;
import Modelo.Paciente;
import Modelo.Personaldeatencion;
import ModeloDAO.ModeloDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Timestamp;


/**
 *
 * @author moish
 */
public class Controlador extends HttpServlet {

    String login = "vistas/InicioCSM.jsp";
    String inicio = "vistas/InicioCSM.jsp";
    String generar = "vistas/GenerarCita.jsp";
    String generar1 = "vistas/GenerarBoleta.jsp";
    Citas c = new Citas();
    Paciente pa = new Paciente();
    Personaldeatencion ate = new Personaldeatencion();
    ModeloDAO dao = new ModeloDAO();
    int ID_Perate;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<script src=\"https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js\"></script>");
            out.println("<link rel=\"stylesheet\" href=\"https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback\">");
            out.println("<link rel=\"stylesheet\" href=\"plugins/fontawesome-free/css/all.min.css\">");
            out.println("<link rel=\"stylesheet\" href=\"https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css\">");
            out.println("<link rel=\"stylesheet\" href=\"dist/css/adminlte.min.css\">");
            out.println("<head>");
            out.println("<title>Servlet Controlador</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("""
                        <script src="plugins/jquery/jquery.min.js"></script>
                        <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
                        <script src="dist/js/adminlte.js"></script>
                        <script src="plugins/chart.js/Chart.min.js"></script>
                        <script src="dist/js/pages/dashboard3.js"></script>""");
            out.println("<h1>Servlet Controlador at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String acceso = "";
        String action = request.getParameter("accion");
        if (action.equalsIgnoreCase("login")) {
            String DNI_Perate = request.getParameter("DNI_Perate");
            int ID_Perate = Integer.parseInt(request.getParameter("ID_Perate"));
            ate.setDNI_Perate(DNI_Perate);
            ate.setID_Perate(ID_Perate);
            Personaldeatencion personal = dao.verificar(DNI_Perate, ID_Perate);

            // Verifica si el objeto 'personal' es null
            if (personal != null) {
                HttpSession session = request.getSession();
                session.setAttribute("nombrePersonalActual", ModeloDAO.getNombrePersonalActual());
                // Si el objeto 'personal' no es null, significa que la persona existe
                acceso = login; // Redirige a la página de inicio de sesión
            } else {
                // Si el objeto 'personal' es null, significa que la persona no existe
                acceso = "index.jsp";  // Redirige a la página de error si no se encuentra
            }
        } else if (action.equalsIgnoreCase("inicio")) {
            acceso = inicio;
        } else if (action.equalsIgnoreCase("generar")) {
            acceso = generar;
        } else if (action.equalsIgnoreCase("generar1")) {
            try {
                int Num_hist = Integer.parseInt(request.getParameter("Num_hist"));
                int ID_Per = Integer.parseInt(request.getParameter("ID_Per"));
                String ID_Espec = request.getParameter("ID_Espec");
                Timestamp Fecha = Timestamp.valueOf(request.getParameter("Fecha"));
                String Alergias = request.getParameter("Alergias");
                String Enfermedad_Cronica = request.getParameter("Enfermedad_Cronica");
                String Sintomas = request.getParameter("Sintomas");

                // Asignación de valores al objeto 'c'
                c.setNum_hist(Num_hist);
                c.setID_Per(ID_Per);
                c.setID_Espec(ID_Espec);
                c.setFecha(Fecha);
                c.setAlergias(Alergias);
                c.setEnfermedad_Cronica(Enfermedad_Cronica);
                c.setSintomas(Sintomas);

                // Llamada al DAO para guardar la cita
                dao.GenerarCita(c);
                acceso = generar1;  // Redirige a la vista que muestra la boleta
            } catch (Exception e) {
                e.printStackTrace();  // Imprime el error para depurar
                acceso = "error.jsp";  // Redirige a una página de error si ocurre una excepción
            }
        }
        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
