<%@page import="java.sql.*"%>
<%
    Connection cn = null;
    PreparedStatement psDeleteBoleta = null;
    PreparedStatement psDeleteCita = null;

    try {
        // Conectar a la base de datos
        Class.forName("com.mysql.cj.jdbc.Driver");
        cn = DriverManager.getConnection("jdbc:mysql://localhost/csmsanjuan?user=root&password=");

        // Obtener el ID_Cita desde el formulario
        int idCita = Integer.parseInt(request.getParameter("ID_Cita"));

        // Eliminar la boleta asociada
        String sqlDeleteBoleta = "DELETE FROM Boleta WHERE ID_Cita = ?";
        psDeleteBoleta = cn.prepareStatement(sqlDeleteBoleta);
        psDeleteBoleta.setInt(1, idCita);
        psDeleteBoleta.executeUpdate();

        // Eliminar la cita
        String sqlDeleteCita = "DELETE FROM Citas WHERE ID_Cita = ?";
        psDeleteCita = cn.prepareStatement(sqlDeleteCita);
        psDeleteCita.setInt(1, idCita);
        psDeleteCita.executeUpdate();

        // Redirigir a InicioCSM.jsp
        response.sendRedirect("InicioCSM.jsp");

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('Error al cancelar registros: " + e.getMessage() + "'); window.location.href='GenerarBoleta.jsp';</script>");
    } finally {
        if (psDeleteBoleta != null) psDeleteBoleta.close();
        if (psDeleteCita != null) psDeleteCita.close();
        if (cn != null) cn.close();
    }
%>