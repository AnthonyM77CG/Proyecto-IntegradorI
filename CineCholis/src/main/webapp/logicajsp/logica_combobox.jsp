 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Metodos.metCine" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %> 

<%
    List<String> ciudades = metCine.getCiudades();

   
    String ciudadSeleccionada = request.getParameter("ciudad");

   
    List<String> cines = new ArrayList<>();
    if (ciudadSeleccionada != null && !ciudadSeleccionada.isEmpty()) {
        cines = metCine.getCinesPorCiudad(ciudadSeleccionada);
    }
%>