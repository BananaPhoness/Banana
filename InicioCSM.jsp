<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="Modelo.Paciente"%>
<%@page import="ModeloDAO.ModeloDAO"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Driver"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
    <!-- IonIcons -->
    <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
    <!-- Theme style -->
    <link rel="stylesheet" href="dist/css/adminlte.min.css">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body class="sidebar-mini layout-fixed layout-navbar-fixed" style="height: auto;">

        <nav class="main-header navbar navbar-expand navbar-light">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" data-widget="pushmenu" href="#"><i class="fa fa-bars"></i></a>
                </li>
            </ul>

            <ul class="navbar-nav ml-auto">
                <li class="nav-item d-none d-sm-inline-block">
                    <a href="vistas/InicioCSM.jsp" class="nav-link">Home</a>
                </li>


            </ul>

        </nav>
        <aside class="main-sidebar sidebar-dark-primary elevation-4">
            <!-- Brand Logo -->
            <a href="Controlador?accion=inicio" class="brand-link">
                <img src="img/img1.jpg" alt="Sanjuan" class="brand-image img-circle elevation-3" style="opacity: 0.9"/>
                <span class="brand-text font-weight-light">CSM San Juan</span>
            </a>

            <!-- Sidebar -->
            <div class="sidebar">
                <!-- Sidebar user panel (optional) -->
                <div class="user-panel mt-3 pb-3 mb-3 d-flex">

                    <div class="info">
                        <a href="#" class="d-block"><%= session.getAttribute("nombrePersonalActual") %></a>
                    </div>
                </div>

                <!-- Sidebar Menu -->
                <nav class="mt-2">
                    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
                        <!-- Add icons to the links using the .nav-icon class
                             with font-awesome or any other icon font library -->
                        <li class="nav-item">
                            <a href="Controlador?accion=inicio" class="nav-link active">
                                <i class="nav-icon fas fa-edit"></i>
                                <p>
                                    Menú
                                </p>
                            </a>
                        <li class="nav-item">
                            <a href="vistas/Medicos.jsp" class="nav-link">
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
                            <a href="vistas/Citas.jsp" class="nav-link">
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
            <div >
                <!-- general form elements -->
                <div class="card card-primary">
                    <div class="card-header">
                        <h3 class="card-title">Historias clinicas</h3>
                    </div>
                    <!-- /.card-header -->
                    <!-- form start -->
                    <form method="GET" action="InicioCSM.jsp">
                        <div class="card-body">
                            <div class="form-group">
                                <label for="HC">Número de historia clínica</label>
                                <input type="text" class="form-control" id="HC" name="HC" placeholder="Ej. 100000234">
                            </div>
                            <div class="form-group">
                                <label for="DNI">DNI</label>
                                <input type="text" class="form-control" id="DNI" name="DNI" placeholder="Ej. 70472765">
                            </div>
                            <button type="filtrar" class="btn btn-primary">Filtrar</button>
                            <a href="vistas/InicioCSM.jsp" class="btn btn-secondary">Eliminar filtros</a>

                            <div class="card-body table-responsive p-0">
                                <table class="table table-striped table-valign-middle">
                                    <thead>
                                        <tr>
                                            <th>N° de historia clinica</th>
                                            <th>DNI</th>
                                            <th>Nombres</th>
                                            <th>Apellidos</th>
                                            <th>Fecha de nacimiento</th>
                                            <th>Telefono</th>
                                            <th>Sexo</th>
                                            <th>Domicilio</th>
                                            <th>Distrito</th>
                                            <th>More</th>
                                        </tr>
                                    </thead>
                                    <%
                                        ModeloDAO dao = new ModeloDAO();
                                        List<Paciente> list = dao.listar();
                                        Iterator<Paciente> iter = list.iterator();
                                        Paciente pa = null;
                                        while (iter.hasNext()) {
                                            pa = iter.next();

                                    %>
                                    <tbody>
                                        <tr>
                                            <td><%= pa.getNum_hist()%></td>
                                            <td><%= pa.getDNI_Pac()%></td>
                                            <td><%= pa.getNom_Pac()%></td>
                                            <td><%= pa.getApe_Pac()%></td>
                                            <td><%= pa.getFechNac_Pac()%></td>
                                            <td><%= pa.getTelef_Pac()%></td>
                                            <td><%= pa.getEstad_Civil_Pac()%></td>
                                            <td><%= pa.getSex_Pac()%></td>
                                            <td><%= pa.getDomicilio()%></td>
                                            <td>
                                                <a href="Controlador?accion=generar&Num_hist=<%= pa.getNum_hist()%>&DNI_Pac=<%= pa.getDNI_Pac()%>&Nom=<%= pa.getNom_Pac()%>&Ape=<%= pa.getApe_Pac()%>&fechaNac=<%= pa.getFechNac_Pac()%>" class="text-muted">
                                                    <button type="button" class="btn btn-primary">Generar cita</button>
                                                </a>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>

                                    </tbody>
                                </table>
                            </div>


                        </div>
                    </form>
                    <!-- /.card-body -->

                </div>
                <!--/.col (left) -->
                <!-- right column -->
                <div class="col-md-6">
                    <!-- Form Element sizes -->
                    <!-- /.card -->
                </div>
                <!--/.col (right) -->
            </div>
            <!-- /.row -->

            <!-- /.content -->
        </div>
        <script src="plugins/jquery/jquery.min.js"></script>
        <!-- Bootstrap -->
        <script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- AdminLTE -->
        <script src="dist/js/adminlte.js"></script>

        <!-- OPTIONAL SCRIPTS -->
        <script src="plugins/chart.js/Chart.min.js"></script>
        <!-- AdminLTE for demo purposes -->
        <!-- AdminLTE dashboard demo (This is only for demo purposes) -->
        <script src="dist/js/pages/dashboard3.js"></script>
         </body>
</html>