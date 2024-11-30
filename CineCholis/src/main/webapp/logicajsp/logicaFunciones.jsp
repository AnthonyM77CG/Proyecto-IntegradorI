<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        // Recibir datos del formulario
        String id_pelicula = request.getParameter("pelicula");
        String id_cine = request.getParameter("cine");
        String[] horarios = request.getParameterValues("horarios[]"); // Recibir múltiples horarios
        
        // Validar si todos los campos necesarios han sido enviados
        if (id_pelicula != null && id_cine != null && horarios != null) {
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            
            try {
                // Establecer la conexión a la base de datos
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost/cineproyect", "root", "");
                
                // Insertar la función en la tabla funciones
                String insertQuery = "INSERT INTO funciones (id_pelicula, id_cine, horario) VALUES (?, ?, ?)";
                ps = conn.prepareStatement(insertQuery);
                
                for (String horario : horarios) {
                    ps.setInt(1, Integer.parseInt(id_pelicula));
                    ps.setInt(2, Integer.parseInt(id_cine));
                    ps.setString(3, horario);
                    ps.executeUpdate(); // Insertar cada horario
                }

                out.print("¡Función(s) guardada(s) exitosamente!");
            } catch (Exception e) {
                out.print("Error: " + e.getMessage());
            } finally {
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        } else {
            out.println("Por favor complete todos los campos.");
        }
    }
%>