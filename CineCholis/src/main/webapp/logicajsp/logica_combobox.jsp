 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.CineDAOimpl" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %> 

<%
 List<String> ciudades = CineDAOimpl.getCiudades();

    
     String ciudadSeleccionada = request.getParameter("ciudad");

    
     List<String> cines = new ArrayList<>();
     if (ciudadSeleccionada != null && !ciudadSeleccionada.isEmpty()) {
         cines = CineDAOimpl.getCinesPorCiudad(ciudadSeleccionada);
     }
 %>