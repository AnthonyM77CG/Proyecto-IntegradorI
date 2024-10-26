<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Comprobante de Pago</title>
    <link rel="stylesheet" type="text/css" href="css/comprobante.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <script>
        function imprimirComprobante() {
            window.print(); // Abre el diálogo de impresión
        }
    </script>
</head>
<body>
    <div class="comprobante-container">
        <h1>BOLETA ELECTRÓNICA</h1>
        <p>R.U.C.: 20429683581</p>
        <p><strong>CineCholis</strong></p>
        <p>Dirección: Av. La Mar, Santa Cruz</p>
        <p>Emisión: <%= new java.util.Date() %></p> <!-- Fecha actual -->

        <ul>
            <li><strong>Usuario:</strong> <%= request.getParameter("full-name") %></li>
            <li><strong>Película:</strong> <%= request.getParameter("pelicula") %></li>
            <li><strong>Cine Escogido:</strong> <%= request.getParameter("cine") %></li>
            <li><strong>Sala de la Función:</strong> <%= request.getParameter("sala") %></li>
            <li><strong>Asientos Comprados:</strong> <%= request.getParameter("asientos") %></li>
            <li><strong>Fecha de la Función:</strong> <%= request.getParameter("fecha") %></li>
            <li><strong>Horario de la Función:</strong> <%= request.getParameter("horario") %></li>
            <li><strong>Forma de Pago:</strong> <%= request.getParameter("forma_pago") %></li>
        </ul>

        <!-- Mostrar el monto total resaltado y centrado -->
        <div style="text-align: center; margin-top: 20px;">
            <p class="monto-total" style="font-size: 24px; color: #d9534f; font-weight: bold;">
                <strong>Monto Total: </strong>S/. <%= request.getParameter("total") %>
            </p>
        </div>

        <%
            // Definir las variables usando el request
            String fullName = request.getParameter("full-name");
            String pelicula = request.getParameter("pelicula");
            String cine = request.getParameter("cine");
            String sala = request.getParameter("sala");
            String asientos = request.getParameter("asientos");
            String formaPago = request.getParameter("forma_pago");
            String fecha = request.getParameter("fecha");
            String horario = request.getParameter("horario");
            String total = request.getParameter("total");

            // Crear un JSON con los datos para generar el código QR
            String jsonData = String.format(
                "{\"Usuario\":\"%s\",\"Película\":\"%s\",\"Cine\":\"%s\",\"Sala\":\"%s\",\"Asientos\":\"%s\",\"Monto Total\":\"%s\",\"Forma de Pago\":\"%s\",\"Fecha\":\"%s\",\"Horario\":\"%s\"}",
                fullName, pelicula, cine, sala, asientos, total, formaPago, fecha, horario
            );

            // Escapar el JSON para que sea válido en la URL
            String encodedJsonData = URLEncoder.encode(jsonData, StandardCharsets.UTF_8.toString());
        %>

        <!-- Código QR Dinámico -->
        <div style="text-align: center;">
            <img src="https://api.qrserver.com/v1/create-qr-code/?data=<%= encodedJsonData %>&size=150x150" alt="Código QR" class="qr-code" />
        </div>

        <!-- Botón para imprimir el comprobante -->
        <div style="text-align: center; margin-top: 20px;">
            <button onclick="imprimirComprobante()" style="padding: 10px 20px; font-size: 16px; background-color: #d9534f; color: #fff; border: none; border-radius: 5px; cursor: pointer;">
                Imprimir Comprobante
            </button>
        </div>
    </div>
</body>
</html>
