<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.CineDAOimpl" %>
<%@ page import="java.util.List" %>

<%
String ciudad = request.getParameter("ciudad");

    // Crear instancia de metCine
    CineDAOimpl metodos = new CineDAOimpl();

    // Obtener la lista de cines por ciudad usando metCine
    List<String> cines = metodos.getCinesPorCiudad(ciudad);
%>

<% if (cines.isEmpty()) { %>
    <option value="">No hay cines disponibles</option>
<% } else { %>
    <option value="">Elige tu cine favorito</option>
    <% for (String cine : cines) { %>
        <option value="<%= cine %>"><%= cine %></option>
    <% } %>
<% } %>
