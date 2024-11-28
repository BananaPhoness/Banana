<%@page import="java.sql.*"%>
<%@page import="com.mysql.cj.jdbc.Driver"%>
<%@page contentType="text/html; charset=UTF-8"%>
<%
    String idespec = request.getParameter("ID_Espec");

    if (idespec != null && !idespec.isEmpty()) {
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = DriverManager.getConnection("jdbc:mysql://localhost/csmsanjuan?user=root&password=");

            // Usar TRIM para asegurar que no haya discrepancias por espacios
            String query = "SELECT * FROM Personalmedico WHERE ID_Espec = ?";
            ps = cn.prepareStatement(query);
            ps.setString(1, idespec.trim()); // Aplicar trim al valor enviado
            rs = ps.executeQuery();

            boolean found = false;

            while (rs.next()) {
                found = true;
                String ID_Per = rs.getString("ID_Per");
                String Nom_Per = rs.getString("Nom_Per");
                String Ape_Per = rs.getString("Ape_Per");
%>
                <option value="<%= ID_Per %>"><%= Nom_Per %> <%= Ape_Per %></option>
<%
            }

            if (!found) {
%>
                <option value="">No se encontraron médicos para esta especialidad.</option>
<%
            }

        } catch (Exception e) {
            e.printStackTrace();
%>
            <option value="">Error al obtener los médicos: <%= e.getMessage() %></option>
<%
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (cn != null) cn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
