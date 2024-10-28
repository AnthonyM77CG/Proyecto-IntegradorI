<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="dao.Met_login" %>

<%
    // Código de lógica de autenticación
    String email = request.getParameter("email");
    String password = request.getParameter("pass");

    // Verificar que el formulario fue enviado
    if (email != null && password != null) {
        Met_login metLogin = new Met_login();
        String rol = metLogin.validarUsuario(email, password);

        if (rol != null) {
            // Almacenar el correo en la sesión
            session.setAttribute("usuario", email); // Almacenas el correo del usuario
            
            // Obtener los valores necesarios para la redirección
            String cine = request.getParameter("cine");
            String horario = request.getParameter("horario");
            String fecha = request.getParameter("fecha");
            String pelicula = request.getParameter("pelicula");
            String asientos = request.getParameter("asientos");
            String imagen = request.getParameter("imagen");
            String sala = request.getParameter("sala"); // Obtener el ID de la sala

            // Redirigir al usuario a la página de selección de butacas
            response.sendRedirect("entrada_butacas.jsp?cine=" + URLEncoder.encode(cine, "UTF-8") +
                                  "&horario=" + URLEncoder.encode(horario, "UTF-8") +
                                  "&fecha=" + URLEncoder.encode(fecha, "UTF-8") +
                                  "&asientos=" + URLEncoder.encode(asientos, "UTF-8") + // Corregido: debe ser asientos
                                  "&imagen=" + URLEncoder.encode(imagen, "UTF-8") +
                                  "&pelicula=" + URLEncoder.encode(pelicula, "UTF-8") +
                                  "&sala=" + URLEncoder.encode(sala, "UTF-8")); // Agregar sala aquí
            
            return;
        } else {
            request.setAttribute("error", "Usuario o contraseña incorrectos");
        }
    }
%>
