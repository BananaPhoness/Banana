<%-- 
    Document   : GenerarCita
    Created on : 15 nov. 2024, 8:58:42 p. m.
    Author     : moish
--%>
<%@page import="java.util.List"%>
<%@page import="Modelo.Especialidades"%>
<%@page import="ModeloDAO.ModeloDAO"%>
<%@page import= "java.time.LocalDate" %>
<%@page import= "java.time.Period"%>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Generar Cita</title>
        <!-- Estilos y scripts -->
        <script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css">
        <link rel="stylesheet" href="dist/css/adminlte.min.css">
    </head>
    <body class="sidebar-mini layout-fixed layout-navbar-fixed" style="height: auto;">

        <%
            Connection cn = null;
            Statement st = null;
            ResultSet rs = null;

            String numHist = request.getParameter("Num_hist");
            String dniPac = request.getParameter("DNI_Pac");
            String Nom = request.getParameter("Nom");
            String Ape = request.getParameter("Ape");
            String fechaNac = request.getParameter("fechaNac");
            String Edad = "";

            if (fechaNac != null && !fechaNac.isEmpty()) {
                fechaNac = fechaNac.substring(0, 10); // Toma solo los primeros 10 caracteres
                LocalDate fechaNacimiento = LocalDate.parse(fechaNac);
                LocalDate fechaActual = LocalDate.now();
                Period periodo = Period.between(fechaNacimiento, fechaActual);
                Edad = String.valueOf(periodo.getYears());
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
            <a href="Controlador?accion=inicio" class="brand-link">
                <img src="img/img1.jpg" alt="Sanjuan" class="brand-image img-circle elevation-3" style="opacity: 0.9"/>
                <span class="brand-text font-weight-light">CSM San Juan</span>
            </a>

            <!-- Sidebar -->
            <div class="sidebar">
                <!-- Sidebar user panel (optional) -->
                <div class="user-panel mt-3 pb-3 mb-3 d-flex">

                    <div class="info">
                        <a href="#" class="d-block"><%= session.getAttribute("nombrePersonalActual")%></a>
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

            <!-- general form elements -->
            <div class="card card-primary">
                <div class="card-header">
                    <h3 class="card-title">Historias clinicas</h3>
                </div>
                <!-- /.card-header -->
                <!-- form start -->
                <form method="GET" action="Controlador">
                    <div class="card-body">
                        <div class="form-group">
                            <input type="hidden" name="Num_hist" value="<%= numHist%>">
                            <input type="hidden" name="DNI_Pac" value="<%= dniPac%>">
                            <input type="hidden" name="Nom" value="<%= Nom%>">
                            <input type="hidden" name="Ape" value="<%= Ape%>">
                            <input type="hidden" name="Edad" value="<%= Edad%>">
                            <label for="HC">Número de historia clínica</label>
                            <input type="text" class="form-control" id="Num_hist" name="Num_hist" value="<%= numHist%>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="DNI">DNI</label>
                            <input type="text" class="form-control" id="DNI" name="DNI" value="<%= dniPac%>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="Nom">Nombres</label>
                            <input type="text" class="form-control" id="Nom" name="Nom" value="<%= Nom%>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="Ape">Apellidos</label>
                            <input type="text" class="form-control" id="Ape" name="Ape" value="<%= Ape%>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="Edad">Edad</label>
                            <input type="text" class="form-control" id="Edad" name="Edad" value="<%= Edad%>" readonly>
                        </div>
                        <div class="form-group">
                            <label for="Alergias">Alergias</label>
                            <input type="text" class="form-control" id="Alergias" name="Alergias" placeholder="Ej. Polen">
                        </div>
                        <div class="form-group">
                            <label for="Enfermedad_Cronica">Enfermedades Crónicas</label>
                            <input type="text" class="form-control" id="Enfermedad_Cronica" name="Enfermedad_Cronica" placeholder="Ej. Cardiopatía">
                        </div>
                        <div class="form-group">
                            <label for="Sintomas">Síntomas</label>
                            <textarea name="Sintomas" class="form-control" id="Sintomas"></textarea>
                        </div>
                        <%
                            // Instanciar el DAO y listar especialidades
                            ModeloDAO dao = new ModeloDAO();
                            List<Especialidades> especialidadesList = dao.listarEspecialidades();
                        %>
                        <div class="form-group">
                            <label for="ID_Espec">Seleccionar Especialidad</label>
                            <select class="form-control" id="ID_Espec" name="ID_Espec">
                                <option value="">Seleccionar Especialidad</option>
                                <%
                                    for (Especialidades esp : especialidadesList) {
                                %>
                                <option value="<%= esp.getID_Espec()%>"><%= esp.getNom_Espec()%></option>
                                <%
                                    }
                                %>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="ID_Per">Seleccionar Médico:</label>
                            <select class="form-control" id="ID_Per" name="ID_Per">
                                <!-- Aquí se llenan los médicos dependiendo de la especialidad seleccionada -->
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="Fecha">Fecha de la cita</label>
                            <input type="datetime-local" class="form-control" id="Fecha" name="Fecha" min="<%= LocalDate.now()%>T00:00">
                                </div>
                        <button type="submit" name="accion" value="generar1" class="btn btn-primary">Generar Cita</button>


                    </div>


                </form>
                <!-- /.card-body -->



                <!--/.col (right) -->

            </div>
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script>
                function ajax() {
                    // Obtener el valor seleccionado en el select con id 'idespec'
                    const idespecValue = document.getElementById("ID_Espec").value;

                    // Crear el objeto XMLHttpRequest
                    const http = new XMLHttpRequest();
                    const url = 'vistas/ObtenerMedico.jsp?ID_Espec=' + encodeURIComponent(idespecValue); // Pasar el valor como parámetro en la URL

                    http.onreadystatechange = function () {
                        if (this.readyState == 4 && this.status == 200) {
                            document.getElementById("ID_Per").innerHTML = this.responseText;  // Insertar la respuesta en el contenedor con id 'medicos'
                        }
                    }
                    http.open("GET", url, true);  // Usar 'true' para la petición asíncrona
                    http.send();
                }

                // Escuchar el evento 'change' en el select con id 'ID_Espec'
                document.getElementById("ID_Espec").addEventListener("change", function () {
                    ajax();  // Llamar la función ajax cuando se cambia la selección
                });
            </script>
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