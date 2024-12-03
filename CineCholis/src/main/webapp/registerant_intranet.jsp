<%@ page import="dao.met_registro" %>
<%@ page import="service.DNIService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Registro</title>
    <link rel="stylesheet" type="text/css" href="css/formregistro.css">
    <link rel="stylesheet" type="text/css" href="css/index.css">
    <link rel="icon" type="image/png" href="img/favicon.png">
    <script>
        function validarDNI() {
            const dniInput = document.getElementById("numero_documento").value;
            if (dniInput.length !== 8 || isNaN(dniInput)) {
                alert("Por favor, ingresa un DNI válido de 8 dígitos.");
            }
        }

        function continuar() {
            const dni = document.getElementById("numero_documento").value;
            if (dni.length === 8) {
                document.getElementById("dniForm").submit(); // Enviar el formulario
            } else {
                alert("Por favor, ingresa un DNI válido.");
            }
        }
    </script>
</head>
<body>
    <jsp:include page="/fragmentos/encabezado.jsp" />

    <div class="form-container">
        <h2>Únete</h2>
        <p>Ingresa tu DNI para continuar</p>
        <form id="dniForm" method="post">
            <div class="form-row">
                <div class="form-group" style="flex: 1;">
                    <input type="text" id="numero_documento" name="numero_documento" placeholder="N° de Documento" required onblur="validarDNI()">
                </div>
                <div class="form-group" style="flex-basis: auto; margin-left: 10px;">
                    <button type="button" class="submit-btn" onclick="continuar()">Continuar</button>
                </div>
            </div>
        </form>

        <% 
            String dni = request.getParameter("numero_documento");
            if (dni != null && !dni.isEmpty()) {
                String resultado = DNIService.consultarDNI(dni);
                System.out.println("Resultado de la consulta: " + resultado); // Para depuración
                if (resultado != null && !resultado.isEmpty()) {
                    try {
                        String nombres = "";
                        String apellidoPaterno = "";
                        String apellidoMaterno = "";

                        // Extraer los valores del JSON manualmente
                        if (resultado.contains("nombres")) {
                            nombres = resultado.split("\"nombres\":\"")[1].split("\"")[0].trim();
                        }
                        if (resultado.contains("apellidoPaterno")) {
                            apellidoPaterno = resultado.split("\"apellidoPaterno\":\"")[1].split("\"")[0].trim();
                        }
                        if (resultado.contains("apellidoMaterno")) {
                            apellidoMaterno = resultado.split("\"apellidoMaterno\":\"")[1].split("\"")[0].trim();
                        }

                        // Establecemos los atributos para el formulario
                        request.setAttribute("nombre", nombres);
                        request.setAttribute("apellidos", apellidoPaterno + " " + apellidoMaterno);
                    } catch (Exception e) {
                        out.println("<script>alert('Error al procesar la respuesta de la API: " + e.getMessage() + "');</script>");
                    }
                } else {
                    out.println("<script>alert('Error al consultar DNI. Verifica que el número sea correcto.');</script>");
                }
            }
        %>

        <div class="resultado">
            <form action="logicajsp/logicaregistro_intranet.jsp" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <input type="text" id="nombre" name="nombre" placeholder="Nombre" required value="<%= request.getAttribute("nombre") != null ? request.getAttribute("nombre") : "" %>" readonly>
                    </div>
                    <div class="form-group">
                        <input type="text" id="apellidos" name="apellidos" placeholder="Apellidos" required value="<%= request.getAttribute("apellidos") != null ? request.getAttribute("apellidos") : "" %>" readonly>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <input type="tel" id="celular" name="celular" placeholder="Celular" required>
                    </div>
                    <div class="form-group">
                        <input type="email" id="correo" name="correo" placeholder="Correo Electrónico" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <input type="text" id="numero_documento" name="numero_documento" placeholder="N° de Documento" required value="<%= request.getParameter("numero_documento") != null ? request.getParameter("numero_documento") : "" %>" readonly>
                    </div>
                    <div class="form-group">
                        <input type="password" id="contrasena" name="contrasena" placeholder="Contraseña" required>
                    </div>
                </div>
                <div class="form-group form-group-center">
                    <input type="password" id="confirmar_contrasena" name="confirmar_contrasena" placeholder="Confirmar Contraseña" required>
                </div>
                <div class="form-group checkbox-group">
                    <input type="checkbox" id="acepto_terminos" name="acepto_terminos" required>
                    <label for="acepto_terminos">Acepto los <a href="#">Términos y Condiciones</a> y la <a href="#">Política de Privacidad</a></label>
                </div>
                <div class="form-group checkbox-group">
                    <input type="checkbox" id="finalidades" name="finalidades">
                    <label for="finalidades">He leído y acepto las finalidades de tratamiento adicionales</label>
                </div>
                <button type="submit" class="submit-btn">Unirme</button>
            </form>
        </div>
    </div>
</body>
</html>