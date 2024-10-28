<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="dao.Met_login" %>

<%
    // Código de lógica de autenticación
    String email = request.getParameter("email");
    String password = request.getParameter("pass");

    if (email != null && password != null) {
        Met_login metLogin = new Met_login();
        String rol = metLogin.validarUsuario(email, password);

        if (rol != null) {
            if (rol.equals("administrador")) {
                response.sendRedirect("crudPeliculas.jsp");
                return;
            } else if (rol.equals("usuario")) {
                response.sendRedirect("promociones_intranet.jsp");
                return;
            }
        } else {
            request.setAttribute("error", "Usuario o contraseña incorrectos");
        }
    }
%>
