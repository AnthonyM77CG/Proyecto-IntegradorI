<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>Iniciar Sesión</title>
    <%@ include file="logicajsp/logicalogin_promociones.jsp" %>
    <link rel="stylesheet" type="text/css" href="css/formlogin.css">
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
	<jsp:include page="/fragmentos/encabezado.jsp" />

    <div class="conteiner-login">
        <form class="form-login" action="loginusuario_promocion.jsp" method="POST">
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
                    <p>¿No tienes una cuenta? <a href="registerant_promociones.jsp">Regístrate</a></p>
                </div>
            </fieldset>
        </form>
    </div>
</body>
</html>