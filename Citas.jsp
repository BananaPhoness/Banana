<%--  
    Document   : Medicos
    Created on : 12 nov. 2024, 9:08:32 p. m.
    Author     : moish
--%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page import="jakarta.servlet.http.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <link rel="stylesheet" href="../plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <link rel="stylesheet" href="../dist/css/adminlte.min.css">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gestión de Citas</title>
    </head>
    <body class="sidebar-mini layout-fixed layout-navbar-fixed" style="height: auto;">
        <%
            Connection cn = null;
            Statement st = null;
            ResultSet rs = null;
            String notification = "";

            if (request.getParameter("deleteID") != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    cn = DriverManager.getConnection("jdbc:mysql://localhost/csmsanjuan?user=root&password=");
                    st = cn.createStatement();
                    String deleteID = request.getParameter("deleteID");
                    String deleteBoletaQuery = "DELETE FROM Boleta WHERE ID_Cita = " + deleteID;
                    st.executeUpdate(deleteBoletaQuery);
                    String deleteQuery = "DELETE FROM Citas WHERE ID_Cita = " + deleteID;
                    int result = st.executeUpdate(deleteQuery);
                    if (result > 0) {
                        notification = "Cita con ID " + deleteID + " y su boleta correspondiente eliminadas correctamente.";
                    }
                } catch (Exception e) {
                    notification = "Error al eliminar la cita y su boleta: " + e.getMessage();
                } finally {
                    if (st != null) st.close();
                    if (cn != null) cn.close();
                }
            }

            if (request.getParameter("modifyID") != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    cn = DriverManager.getConnection("jdbc:mysql://localhost/csmsanjuan?user=root&password=");
                    st = cn.createStatement();
                    String modifyID = request.getParameter("modifyID");
                    // Aquí podrías añadir la lógica de modificación
                    notification = "Cita con ID " + modifyID + " modificada correctamente.";
                } catch (Exception e) {
                    notification = "Error al modificar la cita: " + e.getMessage();
                } finally {
                    if (st != null) st.close();
                    if (cn != null) cn.close();
                }
            }

            if (request.getParameter("viewID") != null) {
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    cn = DriverManager.getConnection("jdbc:mysql://localhost/csmsanjuan?user=root&password=");
                    st = cn.createStatement();
                    String viewID = request.getParameter("viewID");
                    // Aquí podrías añadir la lógica para visualizar los detalles de la cita
                    notification = "Visualizando detalles de la cita con ID " + viewID + ".";
                } catch (Exception e) {
                    notification = "Error al visualizar la cita: " + e.getMessage();
                } finally {
                    if (st != null) st.close();
                    if (cn != null) cn.close();
                }
            }
        %>
        <nav class="main-header navbar navbar-expand navbar-light">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" data-widget="pushmenu" href="#"><i class="fa fa-bars"></i></a>
                </li>
            </ul>
            <ul class="navbar-nav ml-auto">
                <li class="nav-item d-none d-sm-inline-block">
                    <a href="InicioCSM.jsp" class="nav-link">Home</a>
                </li>
            </ul>
        </nav>
        <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="InicioCSM.jsp" class="brand-link">
      <img src="../img/img1.jpg" alt="Sanjuan" class="brand-image img-circle elevation-3" style="opacity: 0.9"/>
      <span class="brand-text font-weight-light">CSM San Juan</span>
    </a>
    
    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        
        <div class="info">
          <a href="#" class="d-block">Alexander Pierce</a>
        </div>
      </div>
      
      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <li class="nav-item">
            <a href="InicioCSM.jsp" class="nav-link">
                <i class="nav-icon fas fa-edit"></i>
              <p>
                Menú
              </p>
            </a>
              
              <li class="nav-item">
                <a href="Medicos.jsp" class="nav-link">
                  <i class="fas fa-users nav-icon"></i>
                  <p>Medico</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="./index3.html" class="nav-link">
                  <i class="nav-icon far fa-calendar-alt"></i>
                  <p>Cronograma</p>
                </a>
              </li>
            
          </li>
          <li class="nav-item">
            <a href="Citas.jsp" class="nav-link active">
              <i class="fas fa-calendar-check nav-icon"></i>
              <p>
                Citas
              </p>
            </a>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-times"></i>
              <p>
                Salir
              </p>
            </a>
          </li>
        </ul>
      </nav>
    </div>
  </aside>
        <div class="content-wrapper" style="min-height: 1156.88px;">
            <section class="content-header">
                <div class="container-fluid">
                    <div class="row mb-2">
                        <div class="col-sm-6">
                            <h1>Gestión de Citas</h1>
                        </div>
                        <div class="col-sm-6">
                            <ol class="breadcrumb float-sm-right">
                                <li class="breadcrumb-item"><a href="#">Home</a></li>
                                <li class="breadcrumb-item active">Gestión de Citas</li>
                            </ol>
                        </div>
                    </div>
                </div>
            </section>
            <div>
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">Buscar Citas</h3>
                    </div>
                    <form method="GET" action="Citas.jsp">
                        <div class="card-body">
                            <div class="form-group">
                                <label for="DNI">DNI</label>
                                <input type="text" class="form-control" id="DNI" name="DNI" maxlength="8" placeholder="Ingrese DNI">
                            </div>
                            <div class="form-group">
                                <label for="HistoriaClinica">N° de Historia Clínica</label>
                                <input type="text" class="form-control" id="HistoriaClinica" name="HistoriaClinica" placeholder="Ingrese N° de Historia Clínica">
                            </div>
                            <div class="form-group">
                                <label for="startDate">Fecha Inicio</label>
                                <input type="date" class="form-control" id="startDate" name="startDate">
                            </div>
                            <div class="form-group">
                                <label for="endDate">Fecha Fin</label>
                                <input type="date" class="form-control" id="endDate" name="endDate">
                            </div>
                            <button type="submit" class="btn btn-primary">Filtrar</button>
                            <a href="Citas.jsp" class="btn btn-secondary">Eliminar filtros</a>
                            <div class="card-body table-responsive p-0">
                                <table class="table table-striped table-valign-middle">
                                    <thead>
                                        <tr>
                                            <th>ID de cita</th>
                                            <th>Fecha y hora</th>
                                            <th>N° de historia clinica</th>
                                            <th>DNI del paciente</th>
                                            <th>Nombres de paciente</th>
                                            <th>Apellidos de paciente</th>
                                            <th>Especialidad de la cita</th>
                                            <th>ID del personal</th>
                                            <th>Nombres del personal</th>
                                            <th>Apellidos del personal</th>
                                            <th>More</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            try {
        Class.forName("com.mysql.jdbc.Driver");
        cn = DriverManager.getConnection("jdbc:mysql://localhost/csmsanjuan?user=root&password=");
        st = cn.createStatement();

        String DNI = request.getParameter("DNI");
        String HistoriaClinica = request.getParameter("HistoriaClinica");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        String query = "SELECT Citas.ID_Cita, Paciente.*, Citas.Fecha, Especialidades.Nom_Espec, Personalmedico.* " +
                       "FROM Citas " +
                       "INNER JOIN Paciente ON Citas.Num_hist = Paciente.Num_hist " +
                       "INNER JOIN Especialidades ON Citas.ID_Espec = Especialidades.ID_Espec " +
                       "INNER JOIN Personalmedico ON Citas.ID_Per = Personalmedico.ID_Per";

        boolean hasCondition = false;

        // Añadir condiciones para el filtro de DNI, Historia Clínica y fechas
        if ((DNI != null && !DNI.isEmpty()) || (HistoriaClinica != null && !HistoriaClinica.isEmpty()) || (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty())) {
            query += " WHERE ";
        }

        // Filtro por DNI
        if (DNI != null && !DNI.isEmpty()) {
            query += "Paciente.DNI_Pac = '" + DNI + "'";
            hasCondition = true;
        }

        // Filtro por Historia Clínica
        if (HistoriaClinica != null && !HistoriaClinica.isEmpty()) {
            if (hasCondition) query += " AND ";  // Si ya hay una condición, agregar un AND
            query += "Citas.Num_hist = '" + HistoriaClinica + "'";
            hasCondition = true;
        }

        // Filtro por rango de fechas
        if (startDate != null && !startDate.isEmpty() && endDate != null && !endDate.isEmpty()) {
            if (hasCondition) query += " AND ";  // Si ya hay una condición, agregar un AND
            query += "Citas.Fecha BETWEEN '" + startDate + "' AND '" + endDate + "'";
        }

        rs = st.executeQuery(query);
        while (rs.next()) {
                                        %>
                                        <tr>
                                            <td><%= rs.getString("ID_Cita") %></td>
                                            <td><%= rs.getString("Fecha") %></td>
                                            <td><%= rs.getString("Num_hist") %></td>
                                            <td><%= rs.getString("DNI_Pac") %></td>
                                            <td><%= rs.getString("Nom_Pac") %></td>
                                            <td><%= rs.getString("Ape_Pac") %></td>
                                            <td><%= rs.getString("Nom_Espec") %></td>
                                            <td><%= rs.getString("ID_Per") %></td>
                                            <td><%= rs.getString("Nom_Per") %></td>
                                            <td><%= rs.getString("Ape_Per") %></td>
                                            <td>
                                                <form action="ModificarCita.jsp" method="GET" style="display:inline;">
                                                    <input type="hidden" name="ID_Cita" value="<%= rs.getString("ID_Cita") %>" />
                                                    <button type="submit" class="btn btn-primary">Modificar</button>
                                                </form>
                                                <form method="POST" style="display:inline;">
                                                    <input type="hidden" name="deleteID" value="<%= rs.getString("ID_Cita") %>" />
                                                    <button type="submit" class="btn btn-danger">Eliminar</button>
                                                </form>
                                                <form action="VisualizarCita.jsp" method="GET" style="display:inline;">
                                                    <input type="hidden" name="ID_Cita" value="<%= rs.getString("ID_Cita") %>" />
                                                    <button type="submit" class="btn btn-secondary">Visualizar</button>
                                                </form>
                                            </td>
                                        </tr>
                                        <%
                                                }
                                            } catch (Exception e) {
                                                out.println("Error: " + e.getMessage());
                                            } finally {
                                                if (rs != null) rs.close();
                                                if (st != null) st.close();
                                                if (cn != null) cn.close();
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                            <% if (!notification.isEmpty()) { %>
                            <div class="alert alert-success" role="alert">
                                <%= notification %>
                            </div>
                            <% } %>
                        </div>
                    </form>
                </div>
            </div>
        </div>
                        <script src="../plugins/jquery/jquery.min.js"></script>
            <!-- Bootstrap -->
            <script src="../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
            <!-- AdminLTE -->
            <script src="../dist/js/adminlte.js"></script>

            <!-- OPTIONAL SCRIPTS -->
            <script src="../plugins/chart.js/Chart.min.js"></script>
            <!-- AdminLTE for demo purposes -->
            
            <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
            <script src="../dist/js/pages/dashboard3.js"></script>
    </body>
</html>