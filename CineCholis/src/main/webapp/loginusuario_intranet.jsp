<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Iniciar Sesión</title>
    <%@ include file="logicajsp/logicalogin_intranet.jsp" %>
    <link rel="stylesheet" type="text/css" href="css/formlogin.css">
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <script src="https://unpkg.com/ionicons@5.5.2/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="icon" type="image/png" href="img/favicon.png">
    
</head>
<body>
    <jsp:include page="/fragmentos/encabezado.jsp" />
    
    <div class="conteiner-login">
        <form class="form-login" action="loginusuario_intranet.jsp" method="POST">
            <fieldset>
                <h3>Iniciar Sesión</h3>
                <div class="conteiner">
                    <i class="fas fa-envelope"></i>
                    <label for="usuario">Usuario:</label>
                    <input type="text" id="usuario" name="email" required>
                </div>
                <div class="conteiner">
                    <i class="fas fa-lock"></i>
                    <label for="contraseña">Contraseña:</label>
                    <input type="password" id="contraseña" name="pass" required>
                </div>
                <%
                    // Mostrar el mensaje de error si existe
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                    <p class="error-message"><%= error %></p>
                <%
                    }
                %>
                <div class="remember-me">
                    <label for="#"><input type="checkbox">Recordarme</label>
                    <a href="#">¿Has olvidado tu contraseña?</a>
                </div>
                <div class="boton-envia">
                    <input type="submit" value="Ingresar">
                </div>
                <div class="register">
                    <p>¿No tienes una cuenta?<a href="registerant_intranet.jsp">Registrate</a></p>
                </div>
            </fieldset>
        </form>
    </div>
    <script>
    // Función para guardar el valor del usuario al hacer submit
    document.querySelector(".form-login").addEventListener("submit", function(event) {
        // Capturamos el valor del input "usuario"
        const usuario = document.getElementById("usuario").value;

        // Guardamos el valor en localStorage
        localStorage.setItem("usuario", usuario);
    });
</script>
</body>
</html>