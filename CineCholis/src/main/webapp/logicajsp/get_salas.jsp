<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.PeliculasCinesDAOimpl" %>
<%@ page import="model.Sala" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%
// Crear una instancia de metPeliculasCines
    PeliculasCinesDAOimpl metodos = new PeliculasCinesDAOimpl();
    
    String nombreCine = request.getParameter("cine");
    List<Sala> listaSalas = new ArrayList<>();
    
    // Obtener salas por nombre de cine
    if (nombreCine != null && !nombreCine.isEmpty()) {
        listaSalas = metodos.obtenerSalasPorNombreCine(nombreCine);
    }
%>
<select>
    <%
        // Verificar si se encontraron salas
        if (listaSalas.isEmpty()) {
    %>
        <option value="">No hay salas disponibles</option>
    <%
        } else {
            // Mostrar las salas disponibles
            for (Sala sala : listaSalas) {
    %>
        <option value="<%= sala.getId() %>"><%= sala.getNombre() %></option>
    <%
            }
        }
    %>
</select>
