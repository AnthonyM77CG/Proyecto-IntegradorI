<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión</title>
    <%@ include file="logicajsp/logicalogin.jsp" %>
    <link rel="stylesheet" type="text/css" href="css/formlogin.css">
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <jsp:include page="/fragmentos/encabezado.jsp" />

    <div class="conteiner-login">
        <form class="form-login" action="loginusuario.jsp" method="POST">
            <fieldset>
                <h3>Iniciar Sesión</h3>
                
                <!-- Campo del Usuario -->
                <div class="conteiner">
                    <i class="fas fa-envelope"></i>
                    <label for="usuario">Usuario:</label>
                    <input type="text" id="usuario" name="email" required>
                </div>
                
                <!-- Campo de la Contraseña -->
                <div class="conteiner">
                    <i class="fas fa-lock"></i>
                    <label for="contraseña">Contraseña:</label>
                    <input type="password" id="contraseña" name="pass" required>
                </div>
                
                <!-- Mostrar el mensaje de error si existe -->
                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null && !error.isEmpty()) {
                %>
                    <p class="error-message"><%= error %></p>
                <%
                    }
                %>

                <!-- Opción de Recordarme y Recuperar Contraseña -->
                <div class="remember-me">
                    <label><input type="checkbox">Recordarme</label>
                    <a href="#">¿Has olvidado tu contraseña?</a>
                </div>

                <!-- Botón para Ingresar -->
                <div class="boton-envia">
                    <input type="submit" value="Ingresar">
                </div>
                
                <!-- Enlace para Registrarse -->
                <div class="register">
                    <p>¿No tienes una cuenta? <a href="registerant_usuario.jsp">Regístrate</a></p>
                </div>
                
                <!-- Parámetros ocultos -->
                <!-- Parámetros ocultos -->
<input type="hidden" name="cine" value="<%= request.getParameter("cine") != null ? request.getParameter("cine") : "" %>">
<input type="hidden" name="horario" value="<%= request.getParameter("horario") != null ? request.getParameter("horario") : "" %>">
<input type="hidden" name="fecha" value="<%= request.getParameter("fecha") != null ? request.getParameter("fecha") : "" %>">
<input type="hidden" name="pelicula" value="<%= request.getParameter("pelicula") != null ? request.getParameter("pelicula") : "" %>">
<input type="hidden" name="asientos" value="<%= request.getParameter("asientos") != null ? request.getParameter("asientos") : "" %>">
<input type="hidden" name="imagen" value="<%= request.getParameter("imagen") != null ? request.getParameter("imagen") : "" %>">
<input type="hidden" name="sala" value="<%= request.getParameter("sala") != null ? request.getParameter("sala") : "" %>"> <!-- Campo oculto para sala -->


            </fieldset>
        </form>
    </div>
</body>
</html>

