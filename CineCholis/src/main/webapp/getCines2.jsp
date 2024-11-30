<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<%
    String ciudadId = request.getParameter("ciudad_id");
    Connection conn = null;
    PrintWriter as = response.getWriter();
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/cineproyect", "root", "");
        PreparedStatement ps = conn.prepareStatement("SELECT id, nombre_cine FROM cines WHERE id_ciudad = ?");
        ps.setInt(1, Integer.parseInt(ciudadId));
        ResultSet rs = ps.executeQuery();

        out.println("<option value=''>Selecciona Cine</option>");
        while (rs.next()) {
            out.println("<option value='" + rs.getInt("id") + "'>" + rs.getString("nombre_cine") + "</option>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
