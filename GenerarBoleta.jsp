<%-- 
    Document   : GenerarBoleta
    Created on : 16 nov. 2024, 11:14:00 p. m.
    Author     : moish
--%>
<%@page import="java.math.BigDecimal"%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Generar Boleta</title>
    <!-- Estilos y scripts -->
    <script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <link rel="stylesheet" href="../plugins/fontawesome-free/css/all.min.css">
    <link rel="stylesheet" href="../dist/css/adminlte.min.css">
</head>
<body class="sidebar-mini layout-fixed layout-navbar-fixed" style="height: auto;">

<%
    Connection cn = null;
    PreparedStatement psCita = null;
    PreparedStatement psBoleta = null;
    PreparedStatement psEspecialidad = null;
    PreparedStatement psMedico = null;
    ResultSet rs = null;
    ResultSet rsEspecialidad = null;
    ResultSet rsMedico = null;

    try {
        // Conectar a la base de datos
        Class.forName("com.mysql.cj.jdbc.Driver");
        cn = DriverManager.getConnection("jdbc:mysql://localhost/csmsanjuan?user=root&password=");
        cn.setAutoCommit(false); // Iniciar transacción

        // Insertar en Citas
        String sqlCita = "INSERT INTO Citas (Num_hist, ID_Per, ID_Espec, Fecha, Alergias, Enfermedad_Cronica, Sintomas) VALUES (?, ?, ?, ?, ?, ?, ?)";
        psCita = cn.prepareStatement(sqlCita, Statement.RETURN_GENERATED_KEYS);

        // Valores recibidos desde GenerarCita.jsp
        psCita.setInt(1, Integer.parseInt(request.getParameter("Num_hist")));
        psCita.setInt(2, Integer.parseInt(request.getParameter("ID_Per"))); // ID del médico seleccionado
        psCita.setString(3, request.getParameter("ID_Espec"));
        psCita.setString(4, request.getParameter("Fecha"));
        psCita.setString(5, request.getParameter("Alergias"));
        psCita.setString(6, request.getParameter("Enfermedad_Cronica"));
        psCita.setString(7, request.getParameter("Sintomas"));

        psCita.executeUpdate();
        rs = psCita.getGeneratedKeys();

        int idCita = 0;
        if (rs.next()) {
            idCita = rs.getInt(1); // Recuperar ID_Cita generado
        }

        // Obtener el costo y nombre de la especialidad
        String sqlEspecialidad = "SELECT Nom_Espec, Costo FROM Especialidades WHERE ID_Espec = ?";
        psEspecialidad = cn.prepareStatement(sqlEspecialidad);
        psEspecialidad.setString(1, request.getParameter("ID_Espec"));
        rsEspecialidad = psEspecialidad.executeQuery();

        BigDecimal costo = BigDecimal.ZERO;
        String nombreEspecialidad = "";
        if (rsEspecialidad.next()) {
            costo = rsEspecialidad.getBigDecimal("Costo");
            nombreEspecialidad = rsEspecialidad.getString("Nom_Espec");
        }

        // Obtener el nombre del doctor
        String sqlMedico = "SELECT Nom_Per, Ape_Per FROM Personalmedico WHERE ID_Per = ?";
        psMedico = cn.prepareStatement(sqlMedico);
        psMedico.setInt(1, Integer.parseInt(request.getParameter("ID_Per")));
        rsMedico = psMedico.executeQuery();

        String nombreMedico = "";
        String apellidoMedico = "";
        if (rsMedico.next()) {
            nombreMedico = rsMedico.getString("Nom_Per");
            apellidoMedico = rsMedico.getString("Ape_Per");
        }

        // Insertar en Boleta con el costo calculado
        String sqlBoleta = "INSERT INTO Boleta (ID_Cita, Total) VALUES (?, ?)";
        psBoleta = cn.prepareStatement(sqlBoleta);

        psBoleta.setInt(1, idCita);
        psBoleta.setBigDecimal(2, costo);

        psBoleta.executeUpdate();

        // Confirmar transacción
        cn.commit();

        request.setAttribute("ID_Boleta", idCita);
        request.setAttribute("ID_Cita", idCita);
        request.setAttribute("Fecha_Emision", new java.util.Date());
        request.setAttribute("DNI_Pac", request.getParameter("DNI_Pac"));
        request.setAttribute("Nom_Pac", request.getParameter("Nom"));
        request.setAttribute("Ape_Pac", request.getParameter("Ape"));
        request.setAttribute("Nom_Espec", nombreEspecialidad);
        request.setAttribute("Nom_Per", nombreMedico);
        request.setAttribute("Ape_Per", apellidoMedico);
        request.setAttribute("Total", costo);
    } catch (Exception e) {
        if (cn != null) cn.rollback(); // Revertir transacción en caso de error
        e.printStackTrace();
        out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
    } finally {
        if (rs != null) rs.close();
        if (rsEspecialidad != null) rsEspecialidad.close();
        if (rsMedico != null) rsMedico.close();
        if (psCita != null) psCita.close();
        if (psBoleta != null) psBoleta.close();
        if (psEspecialidad != null) psEspecialidad.close();
        if (psMedico != null) psMedico.close();
        if (cn != null) cn.close();
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
          <!-- Add icons to the links using the .nav-icon class
               with font-awesome or any other icon font library -->
          <li class="nav-item">
            <a href="InicioCSM.jsp" class="nav-link active">
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
            <a href="Citas.jsp" class="nav-link">
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
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>
<div class="content-wrapper" style="min-height: 1156.88px;">
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Boleta Generada</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Boleta Generada</li>
            </ol>
          </div>
        </div>
      </div>
    </section>
    <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">Historias clinicas</h3>
              </div>
              <div class="form-group">
                <label for="ID_Boleta">ID de Boleta</label>
                <label class="form-control">
                    <%= request.getAttribute("ID_Boleta") %>
                </label>
              </div>
              <div class="form-group">
                <label for="ID_Cita">ID de Cita</label>
                <label class="form-control">
                    <%= request.getAttribute("ID_Cita") %>
                </label>
              </div>
              <div class="form-group">
                <label for="Fecha_Emision">Fecha de Emisión</label>
                <label class="form-control">
                    <%= request.getAttribute("Fecha_Emision") %>
                </label>
              </div>
              <div class="form-group">
                <label for="DNI_Paciente">DNI del Paciente</label>
                <label class="form-control">
                    <%= request.getAttribute("DNI_Pac") %>
                </label>
              </div>
              <div class="form-group">
                <label for="Nombre_Paciente">Nombre del Paciente</label>
                <label class="form-control">
                    <%= request.getAttribute("Nom_Pac") %> <%= request.getAttribute("Ape_Pac") %>
                </label>
              </div>
              <div class="form-group">
                <label for="Especialidad">Especialidad</label>
                <label class="form-control">
                    <%= request.getAttribute("Nom_Espec") %>
                </label>
              </div>
              <div class="form-group">
                <label for="Nombre_Doctor">Nombre del Doctor</label>
                <label class="form-control">
                    <%= request.getAttribute("Nom_Per") %> <%= request.getAttribute("Ape_Per") %>
                </label>
              </div>
              <div class="form-group">
                <label for="Total">Costo Total</label>
                <label class="form-control">
                    <%= request.getAttribute("Total") %>
                </label>
              </div>
              <div class="card-footer d-flex justify-content-between">
                <!-- Botón Cancelar -->
                <form action="CancelarCita.jsp" method="POST">
                    <input type="hidden" name="ID_Cita" value="<%= request.getAttribute("ID_Cita") %>">
                    <button type="submit" class="btn btn-danger">Cancelar Cita</button>
                </form>

                <!-- Botón Terminar proceso -->
                <form method="GET" action="InicioCSM.jsp">
                    <button type="submit" class="btn btn-success">Terminar Proceso</button>
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
<script src="../dist/js/pages/dashboard3.js"></script>

</body>
</html>