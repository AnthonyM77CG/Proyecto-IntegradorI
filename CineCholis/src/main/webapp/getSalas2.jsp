<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*" %>
<%
    String cineId = request.getParameter("cine_id");
    Connection conn = null;
    PrintWriter as = response.getWriter();
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/cineproyect", "root", "");
        PreparedStatement ps = conn.prepareStatement("SELECT id, nombre FROM salas WHERE cine_id = ?");
        ps.setInt(1, Integer.parseInt(request.getParameter("cine_id")));
        ResultSet rs = ps.executeQuery();


        out.println("<option value=''>Selecciona Sala</option>");
        while (rs.next()) {
            out.println("<option value='" + rs.getInt("id") + "'>" + rs.getString("nombre") + "</option>");
        }
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        if (conn != null) try { conn.close(); } catch (SQLException e) {}
    }
%>
