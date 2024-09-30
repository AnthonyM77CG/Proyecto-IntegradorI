<%@ page import="Metodos.met_registro" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Obtener los parámetros del formulario
    String nombre = request.getParameter("nombre");
    String apellidos = request.getParameter("apellidos");
    String celular = request.getParameter("celular");
    String dni = request.getParameter("numero_documento");
    String email = request.getParameter("correo");
    String password = request.getParameter("contrasena");

    // Validar que todos los campos son obligatorios
    if (nombre == null || apellidos == null || celular == null || dni == null || email == null || password == null ||
        nombre.isEmpty() || apellidos.isEmpty() || celular.isEmpty() || dni.isEmpty() || email.isEmpty() || password.isEmpty()) {
        out.println("<script>alert('Todos los campos son obligatorios.'); window.location='registro.jsp';</script>");
    } else {
        // Llamar al método para registrar el usuario
        boolean registrado = met_registro.registrarUsuario(nombre, apellidos, celular, dni, email, password);

        if (registrado) {
            // Usuario registrado exitosamente
            out.println("<script>alert('Usuario registrado exitosamente.'); window.location='login.jsp';</script>");
        } else {
            // Hubo un error al registrar el usuario
            out.println("<script>alert('Error al registrar el usuario. Intenta nuevamente.'); window.location='registro.jsp';</script>");
        }
    }
%>
