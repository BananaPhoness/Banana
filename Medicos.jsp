<%-- 
    Document   : Pacientes
    Created on : 12 nov. 2024, 9:08:32 p. m.
    Author     : moish
--%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="../plugins/fontawesome-free/css/all.min.css">
  <!-- IonIcons -->
  <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../dist/css/adminlte.min.css">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body class="sidebar-mini layout-fixed layout-navbar-fixed" style="height: auto;">
        <%
            Connection cn = null;
            Statement st = null;
            ResultSet rs = null;

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
            <a href="InicioCSM.jsp" class="nav-link">
                <i class="nav-icon fas fa-edit"></i>
              <p>
                Menú
              </p>
            </a>
              
              <li class="nav-item">
                <a href="Medicos.jsp" class="nav-link active">
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
            <h1>General Form</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">General Form</li>
            </ol>
          </div>
        </div>
      </div>
    </section>
    <!-- Main content -->
    
          <!-- left column -->
          <div>
            <!-- general form elements -->
            <div class="card card-primary">
              <div class="card-header">
                <h3 class="card-title">Personal Medico</h3>
              </div>
              <!-- /.card-header -->
              <!-- form start -->
              <form method="GET" action="Medicos.jsp">
    <div class="card-body">
        <div class="form-group">
            <label for="NomD">Nombres</label>
            <input type="text" class="form-control" id="NomD" name="NomD" placeholder="Ej. Juan">
        </div>
        <div class="form-group">
            <label for="ApeD">Apellidos</label>
            <input type="text" class="form-control" id="ApeD" name="ApeD" placeholder="Ej. Pérez">
        </div>
        <div class="form-group">
            <label for="Espec">Especialidad</label>
            <input type="text" class="form-control" id="Espec" name="Espec" placeholder="Ej. Cardiología">
        </div>
        <button type="submit" class="btn btn-primary">Filtrar</button>
        <a href="Medicos.jsp" class="btn btn-secondary">Eliminar filtros</a>
    </div>
</form>

<div class="card-body table-responsive p-0">
    <table class="table table-striped table-valign-middle">
        <thead>
            <tr>
                <th>ID del personal</th>
                <th>Nombres</th>
                <th>Apellidos</th>
                <th>Especialidad</th>
                <th>DNI</th>
                <th>N° de colegiatura</th>
                <th>Grado</th>
                <th>Nivel</th>
            </tr>
        </thead>
        <tbody>
            <%
                Class.forName("com.mysql.jdbc.Driver");
                cn = DriverManager.getConnection("jdbc:mysql://localhost/csmsanjuan?user=root&password=");
                st = cn.createStatement();

                String NomD = request.getParameter("NomD");
                String ApeD = request.getParameter("ApeD");
                String Espec = request.getParameter("Espec");

                String query = "SELECT Personalmedico.ID_Per, Personalmedico.Nom_Per, Personalmedico.Ape_Per, especialidades.Nom_Espec, "
                             + "Personalmedico.DNI_Per, Personalmedico.Num_Colegiatura, Personalmedico.Nivel, Personalmedico.Tipo "
                             + "FROM Personalmedico "
                             + "INNER JOIN especialidades ON Personalmedico.ID_Espec = especialidades.ID_Espec";

                if ((NomD != null && !NomD.isEmpty()) || (ApeD != null && !ApeD.isEmpty()) || (Espec != null && !Espec.isEmpty())) {
                    query += " WHERE 1=1";
                    if (NomD != null && !NomD.isEmpty()) {
                        query += " AND Personalmedico.Nom_Per LIKE '%" + NomD + "%'";
                    }
                    if (ApeD != null && !ApeD.isEmpty()) {
                        query += " AND Personalmedico.Ape_Per LIKE '%" + ApeD + "%'";
                    }
                    if (Espec != null && !Espec.isEmpty()) {
                        query += " AND especialidades.Nom_Espec LIKE '%" + Espec + "%'";
                    }
                }

                rs = st.executeQuery(query);

                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString(1) %></td>
                <td><%= rs.getString(2) %></td>
                <td><%= rs.getString(3) %></td>
                <td><%= rs.getString(4) %></td>
                <td><%= rs.getString(5) %></td>
                <td><%= rs.getString(6) %></td>
                <td><%= rs.getString(7) %></td>
                <td><%= rs.getString(8) %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>

                  
                
                            </form>
                <!-- /.card-body -->

          </div>
          <div class="col-md-6">
            <!-- Form Element sizes -->
            <!-- /.card -->
          </div>
          <!--/.col (right) -->
        </div>
        <!-- /.row -->
      
    <!-- /.content -->
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
